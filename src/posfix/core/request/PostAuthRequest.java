package posfix.core.request;

import posfix.core.*;
import posfix.core.response.PostAuthResponse;

public class PostAuthRequest extends CoreRequest {
    public String orderId;
    public String amount;
    public String clientIp;


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
