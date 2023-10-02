package posfix.core.request;

import posfix.core.*;
import posfix.core.response.CreateRefundInquiryResponse;
import posfix.core.response.PaymentRefundInquiryResponse;

// İade Oluşturma servisleri içerisinde kullanılacak olan servis girdi parametrelerini temsil eder.
public class CreatePaymentRefundRequest extends CoreRequest {
    public String clientIp ;
    public String orderId ;
    public String amount ;
    public String refundHash;

    /*
     *	İade Oluşturma Servis çağrısını temsil eder.
     *	@request İade Oluşturma gerekli olan servis girdi parametrelerini temsil eder.
     *	@options Kullanıcıya özel olarak belirlenen ayarları temsil eder.
     */

    public static CreateRefundInquiryResponse execute(CreatePaymentRefundRequest request, Settings settings) throws Exception {

        settings.transactionDate = Helper.getTransactionDateString();
        settings.hashString = settings.privateKey
                + request.orderId
                + request.clientIp
                + settings.transactionDate;
        return RestHttpCaller.getInstance().postJson(settings.baseUrl + "/corporate/payment/refund",
                Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8),
                request, CreateRefundInquiryResponse.class);

    }
}
