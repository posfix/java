package posfix.core;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.xml.bind.DatatypeConverter;

import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilderFactory;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSSerializer;

public class Helper {

	/*
		Doğru formatta tarih döndüren yardımcı sınıftır. Isteklerde tarih istenen noktalarda bu fonksiyon sonucu kullanılır.
		Servis çağrılarında kullanılacak istek zamanı için istenen tarih formatında bu fonksiyon kullanılmalıdır.
	*/

    //Bu fonksiyon verdiğimiz tarih değerini PosFix'nın bizden beklemiş olduğu tarih formatına değiştirmektedir.
    public static String getTransactionDateString() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return simpleDateFormat.format(new Date());
    }

    /*
     *	Çağrılarda kullanılacak Tokenları oluşturan yardımcı metotdur.
     *	İstek güvenlik bilgisi kullanılacak tüm çağrılarda token oluşturmamız gerekmektedir.
     *	Token oluştururken hash bilgisi ve public key alanlarının parametre olarak gönderilmesi gerekmektedir.
     *	hashstring alanı servise ait birden fazla alanın birleşmesi sonucu oluşan verileri ve public key mağaza açık anahtarını
     *	kullanarak bizlere token üretmemizi sağlar.

     *	@publicKey Mağaza Açık Anahtarınız
     *	@hashString Servise özel bir çok alanın birleştirilmesiyle oluşturulan veriler bütünü
     */
    public static String createToken(String publicKey, String hashString) throws Exception {
        try {
            MessageDigest sha1 = MessageDigest.getInstance(Constants.Formats.SHA1);
            String hash = DatatypeConverter.printBase64Binary((sha1.digest(hashString.getBytes(Constants.Formats.UTF8))));
            return publicKey + ":" + hash;
        } catch (NoSuchAlgorithmException e) {
            throw new Exception("Hash cannot be generated");
        }
    }

    /*
     *	Verilen string'i SHA1 ile hashleyip Base64 formatına çeviren fonksiyondur.
     *	CreateToken'dan farklı olarak token oluşturmaz sadece hash hesaplar
     */
    public static String computeHash(String hashString) throws Exception {
        MessageDigest sha1 = MessageDigest.getInstance(Constants.Formats.SHA1);
        return DatatypeConverter.printBase64Binary(sha1.digest(hashString.getBytes(Constants.Formats.UTF8)));
    }

    /*
        Bir çok çağrıda kullanılan HTTP Header bilgilerini otomatik olarak ekleyen fonksiyondur.
    */
    public static Map<String, String> getHttpHeaders(Settings settings, String acceptType) throws Exception {
        Map<String, String> headers = new HashMap<>();
        headers.put(Constants.StandardHTTPHeaders.ACCEPT, acceptType);
        headers.put(Constants.PosFixHTTPHeaders.VERSION, settings.version);
        headers.put(Constants.PosFixHTTPHeaders.TOKEN, createToken(settings.publicKey, settings.hashString));
        headers.put(Constants.PosFixHTTPHeaders.TRANSACTION_DATE, settings.transactionDate);
        return headers;
    }
    //3D akışının ilk adımında yapılan işlemin ardından gelen cevabın doğrulanması adına kullanılacak fonksiyondur.
    /*public static boolean validate3DReturn(ThreeDPaymentInitResponse paymentResponse, Settings settings) throws Exception {
        if (paymentResponse.hash == null) {
            throw new Exception("Ödeme cevabı hash bilgisi boş. [result : " + paymentResponse.result + ",error_code : " + paymentResponse.errorCode + ",error_message : " + paymentResponse.errorMessage + "]");
        }
        String hashText = paymentResponse.orderId
                + paymentResponse.result
                + paymentResponse.amount
                + paymentResponse.mode
                + paymentResponse.errorCode
                + paymentResponse.errorMessage
                + paymentResponse.transactionDate
                + settings.publicKey
                + settings.privateKey;
        String hashedText = computeHash(hashText);
        System.out.println("Hash Value in Payment Response  : " + paymentResponse.hash);
        System.out.println("Hash Value at Local Computation : " + hashedText);
        if (!hashedText.equals(paymentResponse.hash)) {
            throw new Exception("Ödeme cevabı hash doğrulaması hatalı. [result : " + paymentResponse.result + ",error_code : " + paymentResponse.errorCode + ",error_message : " + paymentResponse.errorMessage + "]");
        }
        return true;
    }*/
    /*
     * Parametre olarak verilen xml verisinin ekranlarda daha güzel gözükmesini sağlar.
     * Bu kısım api çağrılarında kullanılmaz sadece çıktının daha güzel gözükmesini sağlar.
     */
    public static String xmlFormatter(String xml) {

        try {
            final InputSource src = new InputSource(new StringReader(xml));
            final Node document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(src).getDocumentElement();
            final Boolean keepDeclaration = Boolean.valueOf(xml.startsWith("<?xml"));

            //May need this: System.setProperty(DOMImplementationRegistry.PROPERTY,"com.sun.org.apache.xerces.internal.dom.DOMImplementationSourceImpl");


            final DOMImplementationRegistry registry = DOMImplementationRegistry.newInstance();
            final DOMImplementationLS impl = (DOMImplementationLS) registry.getDOMImplementation("LS");
            final LSSerializer writer = impl.createLSSerializer();

            writer.getDomConfig().setParameter("format-pretty-print", Boolean.TRUE); // Set this to true if the output needs to be beautified.
            writer.getDomConfig().setParameter("xml-declaration", keepDeclaration); // Set this to true if the declaration is needed to be outputted.

            return writer.writeToString(document);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /*
     * Xml verisinin ekranda daha düzgün gözükmesi için kullanılan metodu temsil eder.
     * Api çağırılarında bu alanlar kullanılmaz. Sadece çıktının daha düzgün gözükmesi sağlanır.

     */
    public static  String prettyPrintXml(String xmlString)  throws Exception  {

        try
        {
            xmlString=xmlFormatter(xmlString);

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder;
            Document doc ;

            builder = factory.newDocumentBuilder();
            doc = builder.parse( new InputSource( new StringReader( xmlString )) );


            Transformer tf = TransformerFactory.newInstance().newTransformer();

            tf.setOutputProperty(OutputKeys.INDENT, "yes");
            tf.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "no");

            Writer out = new StringWriter();
            tf.transform(new DOMSource(doc), new StreamResult(out));
            return out.toString().replace("<", "&lt;");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
