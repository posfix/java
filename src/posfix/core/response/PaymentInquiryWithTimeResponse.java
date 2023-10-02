package posfix.core.response;

import posfix.core.CoreResponse;

import java.util.List;

public class PaymentInquiryWithTimeResponse extends CoreResponse {
    private List<Payment> payments;
    private String totalPayments;

}
