package posfix.core.response;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import posfix.core.CoreResponse;

// 3D secure olmadan ödeme servis çıktı parametre alanlarını temsil etmektedir.
@XmlRootElement(name = "authResponse")
public class ApiPaymentResponse extends CoreResponse {

	@XmlElement(name = "amount")
	public String amount;

	@XmlElement(name = "orderId")
	public String orderId;

	@XmlElement(name = "commissionRate")
	public String commissionRate;

}
