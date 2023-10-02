package posfix.core.request;

import posfix.core.*;
import posfix.core.response.BinNumberInquiryV4Response;

public class BinNumberInquiryV4Request extends CoreRequest {

    public String binNumber;
    public String amount;
    public String threeD = "true";

    /*
     *	Türkiye genelinde tanımlı olan tüm yerli kartlara ait BIN numaraları için sorgulama yapılmasına izin veren servisi temsil eder.
     *	@request Istek olarak gelen bin numarasını temsil etmektedir.
     *	@options Kullanıcıya özel olarak belirlenen ayarları temsil eder.

     */
    public static BinNumberInquiryV4Response execute(BinNumberInquiryV4Request request, Settings settings) throws Exception {

        settings.transactionDate = Helper.getTransactionDateString();
        settings.hashString = settings.privateKey
                + request.binNumber
                + settings.transactionDate;
        return RestHttpCaller.getInstance().postJson(settings.baseUrl + "rest/payment/bin/lookup/v4",
                Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8),
                request, BinNumberInquiryV4Response.class);

    }

}
