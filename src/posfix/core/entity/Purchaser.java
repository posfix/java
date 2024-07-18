package posfix.core.entity;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/*
 Bu sınıf 3D secure olmadan ödeme kısmında müşteri bilgilerinin kullanılacağı yerde ve
 3D Secure ile Ödeme'nin 2. adımında müşteri bilgilerinin istendiği yerde kullanılır.

*/
@XmlRootElement(name = "purchaser")
public class Purchaser {

	@XmlElement(name = "name")
	public String name;

	@XmlElement(name = "surname")
	public String surname;

	@XmlElement(name = "birthDate")
	public String birthDate;

	@XmlElement(name = "email")
	public String email;

	@XmlElement(name = "gsmNumber")
	public String gsmNumber;

	@XmlElement(name = "tcCertificate")
	public String tcCertificate;

	@XmlElement(name = "clientIp")
	public String clientIp;

	@XmlElement(name = "invoiceAddress")
	public PurchaserAddress invoiceAddress;

	@XmlElement(name = "shippingAddress")
	public PurchaserAddress shippingAddress;

}
