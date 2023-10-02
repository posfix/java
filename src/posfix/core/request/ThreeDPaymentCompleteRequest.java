package posfix.core.request;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import posfix.core.Constants;
import posfix.core.CoreRequest;
import posfix.core.Helper;
import posfix.core.RestHttpCaller;
import posfix.core.Settings;
import posfix.core.entity.Product;
import posfix.core.entity.Purchaser;
import posfix.core.response.ThreeDPaymentCompleteResponse;

// 3D Secure ile ödeme 2. Adımında gerekli olan 3D servis girdi parametrelerini temsil eder.
@XmlRootElement(name = "auth")
public class ThreeDPaymentCompleteRequest extends CoreRequest {

	@XmlElement(name = "threeD")
	public String threeD;

	@XmlElement(name = "orderId")
	public String orderId;

	@XmlElement(name = "amount")
	public String amount;

	@XmlElement(name = "cardOwnerName")
	public String cardOwnerName;

	@XmlElement(name = "cardNumber")
	public String cardNumber;

	@XmlElement(name = "cardExpireMonth")
	public String cardExpireMonth;

	@XmlElement(name = "cardExpireYear")
	public String cardExpireYear;

	@XmlElement(name = "installment")
	public String installment;

	@XmlElement(name = "cardCvc")
	public String cvc;

	@XmlElement(name = "vendorId")
	public String vendorId;

	@XmlElement(name = "userId")
	public String userId;

	@XmlElement(name = "cardId")
	public String cardId;

	@XmlElement(name = "threeDSecureCode")
	public String threeDSecureCode;

	@XmlElementWrapper(name = "products")
	@XmlElement(name = "product")
	public List<Product> products;

	@XmlElement(name = "purchaser")
	public Purchaser purchaser;


	/*
	 *	3D Secure 2. Adımında ödeme onayı sağlanarak tahsilat gerçekleştirilmesi için gerekli olan servis isteğini temsil eder.
	 *	@request Ödeme Onayı sağlamak için gerekli olan girdilerin olduğu sınıfı temsil eder.
	 *	options Kullanıcıya özel olarak belirlenen ayarları temsil eder.
	*/
	public static ThreeDPaymentCompleteResponse execute(ThreeDPaymentCompleteRequest request, Settings settings) throws Exception {

        settings.transactionDate = Helper.getTransactionDateString();
        settings.hashString = settings.privateKey
                + request.orderId
                + request.amount
                + request.mode
                + request.threeDSecureCode
                + settings.transactionDate;
        return RestHttpCaller.getInstance().postXML(settings.baseUrl + "rest/payment/auth",
                Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_XML_UTF8),
                request, ThreeDPaymentCompleteResponse.class);

    }

}
