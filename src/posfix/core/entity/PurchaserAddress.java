package posfix.core.entity;

import javax.xml.bind.annotation.XmlElement;

/*
Bu sınıf 3D secure olmadan ödeme kısmında müşteri adres bilgisinin kullanılacağı yerde ve
3D Secure ile Ödeme'nin 2. adımında müşteri adres bilgisinin istendiği yerde kullanılır.
*/
public class PurchaserAddress {

	@XmlElement(name = "name")
	public String name;

	@XmlElement(name = "surname")
	public String surname;

	@XmlElement(name = "address")
	public String address;

	@XmlElement(name = "zipcode")
	public String zipcode;

	@XmlElement(name = "city")
	public String city;

	@XmlElement(name = "tcCertificate")
	public String tcCertificate;

	@XmlElement(name = "country")
	public String country;

	@XmlElement(name = "taxNumber")
	public String taxNumber;

	@XmlElement(name = "taxOffice")
	public String taxOffice;

	@XmlElement(name = "companyName")
	public String companyName;

	@XmlElement(name = "phoneNumber")
	public String phoneNumber;

}
