package posfix.core.request;

import posfix.core.*;
import posfix.core.entity.Product;
import posfix.core.entity.Purchaser;
import posfix.core.response.PreAuthResponse;

import java.util.List;

public class PreAuthRequest extends CoreRequest {
    public String threeD;
    public String orderId;
    public String amount;
    public String cardOwnerName;
    public String cardNumber;
    public String cardExpireMonth;
    public String cardExpireYear;
    public String installment;
    public String cardCvc;

    public String vendorId;

    public String userId;

    public String cardId;

    public String waitingConfirmation;

    public List<Product> products;

    public Purchaser purchaser;

    public static PreAuthResponse execute(PreAuthRequest request, Settings settings) throws Exception {
        settings.transactionDate = Helper.getTransactionDateString();
        settings.hashString = settings.privateKey
                + request.orderId
                + request.amount
                + request.mode
                + request.cardOwnerName
                + request.cardNumber
                + request.cardExpireMonth
                + request.cardExpireYear
                + request.cardCvc
                + request.userId
                + request.cardId
                + request.purchaser.name
                + request.purchaser.surname
                + request.purchaser.email
                + settings.transactionDate;
        return RestHttpCaller.getInstance().postJson(settings.baseUrl + "rest/payment/preauth",
                Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8), request,
                PreAuthResponse.class);
    }
}
