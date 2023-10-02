package posfix.core.request;

import posfix.core.*;
import posfix.core.response.LinkPaymentCreateResponse;

import java.util.List;

public class LinkPaymentCreateRequest extends CoreRequest {
    public String name;
    public String surname;
    public String tcCertificate;
    public String taxNumber;
    public String email;
    public String gsm;
    public String amount;
    public String threeD;
    public String expireDate;
    public List<Integer> installmentList;
    public String sendEmail;
    public String commissionType;
    public String clientIp;

    /*
     *	Link ile Ödeme Servis çağrısını temsil eder.
     *	@request Link ile Ödeme gerekli olan servis girdi parametrelerini temsil eder.
     *	@options Kullanıcıya özel olarak belirlenen ayarları temsil eder.
     */


    public static LinkPaymentCreateResponse execute(LinkPaymentCreateRequest request, Settings settings) throws Exception {

        settings.transactionDate = Helper.getTransactionDateString();
        settings.hashString = settings.privateKey
                +request.name
                +request.surname
                +request.email
                +request.amount
                +request.clientIp
                +settings.transactionDate;
        return RestHttpCaller.getInstance().postJson(settings.baseUrl + "corporate/merchant/linkpayment/create",
                Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8),
                request, LinkPaymentCreateResponse.class);

    }
}
