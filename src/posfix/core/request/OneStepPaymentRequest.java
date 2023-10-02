package posfix.core.request;

import com.google.gson.Gson;
import posfix.core.Constants;
import posfix.core.Helper;
import posfix.core.RestHttpCaller;
import posfix.core.Settings;
import posfix.core.entity.Product;
import posfix.core.entity.Purchaser;
import posfix.core.response.ApiPaymentResponse;
import sun.misc.BASE64Encoder;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.List;

public class OneStepPaymentRequest {

    private String mode;
    private String orderId;
    private String cardOwnerName;
    private String cardNumber;
    private String cardAlias;
    private String cardExpireMonth;
    private String cardExpireYear;
    private String cardCvc;
    private String userId;
    private String cardId;
    private String installment;
    private String amount;
    private String echo;
    private String successUrl;
    private String failureUrl;
    private String transactionDate;
    private String version;
    private String deviceUUId;
    private String token;
    private String language;
    private String vendorId;
    private String custField1;
    private Purchaser purchaser;
    private List<Product> products;

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getCardOwnerName() {
        return cardOwnerName;
    }

    public void setCardOwnerName(String cardOwnerName) {
        this.cardOwnerName = cardOwnerName;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getCardExpireMonth() {
        return cardExpireMonth;
    }

    public void setCardExpireMonth(String cardExpireMonth) {
        this.cardExpireMonth = cardExpireMonth;
    }

    public String getCardExpireYear() {
        return cardExpireYear;
    }

    public void setCardExpireYear(String cardExpireYear) {
        this.cardExpireYear = cardExpireYear;
    }

    public String getCardCvc() {
        return cardCvc;
    }

    public void setCardCvc(String cardCvc) {
        this.cardCvc = cardCvc;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCardId() {
        return cardId;
    }

    public void setCardId(String cardId) {
        this.cardId = cardId;
    }

    public String getInstallment() {
        return installment;
    }

    public void setInstallment(String installment) {
        this.installment = installment;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getEcho() {
        return echo;
    }

    public void setEcho(String echo) {
        this.echo = echo;
    }

    public String getSuccessUrl() {
        return successUrl;
    }

    public void setSuccessUrl(String successUrl) {
        this.successUrl = successUrl;
    }

    public String getFailureUrl() {
        return failureUrl;
    }

    public void setFailureUrl(String failureUrl) {
        this.failureUrl = failureUrl;
    }

    public String getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(String transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getDeviceUUId() {
        return deviceUUId;
    }

    public void setDeviceUUId(String deviceUUId) {
        this.deviceUUId = deviceUUId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getVendorId() {
        return vendorId;
    }

    public void setVendorId(String vendorId) {
        this.vendorId = vendorId;
    }


    public String getCustField1() {
        return custField1;
    }

    public void setCustField1(String custField1) {
        this.custField1 = custField1;
    }


    public Purchaser getPurchaser() {
        return purchaser;
    }

    public void setPurchaser(Purchaser purchaser) {
        this.purchaser = purchaser;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }


    public String getCardAlias() {
        return cardAlias;
    }

    public void setCardAlias(String cardAlias) {
        this.cardAlias = cardAlias;
    }




    /*
     *	3D secure Tek Adımında kullanıcı bilgileri alındıktan sonra ilgili servis isteğini temsil eder.
     *	@request 3D secure Tek Adımında gerekli olan servis girdi parametrelerini temsil eder.
     *	@options Kullanıcıya özel olarak belirlenen ayarları temsil eder.
     */

    private static String createToken(OneStepPaymentRequest threeDPayment, Settings settings) throws Exception {
        String hash = settings.privateKey +
                threeDPayment.orderId +
                threeDPayment.amount +
                threeDPayment.mode +
                threeDPayment.cardOwnerName +
                threeDPayment.cardNumber +
                threeDPayment.cardExpireMonth +
                threeDPayment.cardExpireYear +
                threeDPayment.cardCvc+
                threeDPayment.cardAlias +
                threeDPayment.userId +
                threeDPayment.cardId +
                threeDPayment.purchaser.name +
                threeDPayment.purchaser.surname +
                threeDPayment.purchaser.email+
                threeDPayment.transactionDate;
        hash = getSHA1Text(hash);
        threeDPayment.setCardOwnerName(URLEncoder.encode(threeDPayment.getCardOwnerName(), StandardCharsets.UTF_8.toString()));
        return settings.publicKey + ":" + hash;
    }

    private static String getSHA1Text(String hash) throws Exception {
        MessageDigest sha1 = MessageDigest.getInstance("SHA-1");
        return (new BASE64Encoder()).encode(sha1.digest(hash.getBytes("UTF-8")));
    }

    /*
     *	 Diğer fonksiyonların aksine 3D Sınıfı bir formun post edilmesi ile başlar
     *    Bu sebeble bu fonksiyon ilgili HTML formu oluşturur ve geri döndürür.
     *    Bu formu mevcut formun üzerine yazmak ilgili formun Javascript ile post edilmesini sağlar.
     */

    private static String createForm(OneStepPaymentRequest request, Settings settings) {
        Gson gson = new Gson();
        String jsonString = gson.toJson(request);

        String form = "<!DOCTYPE html>" +
                "<html lang='en'>" +
                "<head>" +
                "<meta charset='UTF-8' />" +
                "<meta name='viewport' content='width=device-width, initial-scale=1.0' />" +
                "</head>" +
                "<body>" +
                "<form action='" + settings.oneStepPaymentUrl + "' method='POST' id='PosFixMerchantRequestForm'>"+
                "<input id='token' type='text' name='parameters' value='" + jsonString + "' />" +
                "</form>" +
                "<script>" +
                 "document.getElementById('PosFixMerchantRequestForm').submit();" +
                        "</script>"+
                "</body>"+
                "</html>";
        return form;
    }

    public static String execute(OneStepPaymentRequest request, Settings settings) throws Exception {
        settings.transactionDate = Helper.getTransactionDateString();
        request.setToken(createToken(request, settings));
        return createForm(request,settings);
    }

}
