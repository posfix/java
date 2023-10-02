package posfix.core.response;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import posfix.core.CoreResponse;
//  Ödeme sorugulama servisi sonucunda oluşan servis çıktı parametrelerini temsil eder.
@XmlRootElement(name = "inquiryResponse")
public class PaymentInquiryResponse extends CoreResponse {

	@XmlElement(name = "amount")
	public String amount;

	@XmlElement(name = "orderId")
	public String orderId;

}
