package posfix.core.request;

import posfix.core.*;
import posfix.core.response.PostAuthResponse;

//Ön Otorizasyon Kapama servis girdi parametrelerini temsil eder.
public class PostAuthRequest extends CoreRequest {
    public String orderId;
    public String amount;
    public String clientIp;

    /*
     *	Ön Otorizasyon Kapama için gerekli olan servis isteğini temsil eder.
     *	@request Ödeme Onayı sağlamak için gerekli olan girdilerin olduğu sınıfı temsil eder.
     *	settings Kullanıcıya özel olarak belirlenen ayarları temsil eder.
     */
    public static PostAuthResponse execute(PostAuthRequest request, Settings settings) throws Exception {
        settings.transactionDate = Helper.getTransactionDateString();
        settings.hashString = settings.privateKey
                + request.orderId
                + request.amount
                + request.mode
                + request.clientIp
                + settings.transactionDate;
        return RestHttpCaller.getInstance().postJson(settings.baseUrl + "rest/payment/postauth",
                Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8), request,
                PostAuthResponse.class);
    }
}
