package posfix.core.request;

import posfix.core.*;
import posfix.core.response.PaymentRefundInquiryResponse;

public class PaymentRefundInquiryRequest extends CoreRequest {
    public String clientIp ;
    public String orderId ;
    public String amount ;

    /*
     *	İade Sorgulama Servis çağrısını temsil eder.
     *	@request İade Sorgulama gerekli olan servis girdi parametrelerini temsil eder.
     *	@options Kullanıcıya özel olarak belirlenen ayarları temsil eder.
     */

    public static PaymentRefundInquiryResponse execute(PaymentRefundInquiryRequest request, Settings settings) throws Exception {

        settings.transactionDate = Helper.getTransactionDateString();
        settings.hashString = settings.privateKey
                + request.orderId
                + request.clientIp
                + settings.transactionDate;
        return RestHttpCaller.getInstance().postJson(settings.baseUrl + "/corporate/payment/refund/inquiry",
                Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8),
                request, PaymentRefundInquiryResponse.class);

    }
}
