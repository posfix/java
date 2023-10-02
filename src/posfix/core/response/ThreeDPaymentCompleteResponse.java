package posfix.core.response;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import posfix.core.CoreResponse;
//  3D Secure ile ödeme 2. adımı sonucunda oluşan servis çıktı parametrelerini temsil etmektedir.
@XmlRootElement(name = "authResponse")
public class ThreeDPaymentCompleteResponse extends CoreResponse {

	@XmlElement(name = "amount")
	public String amount;

	@XmlElement(name = "orderId")
	public String orderId;

}
