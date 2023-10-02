package posfix.core.entity;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/*
Bu sınıf 3D secure olmadan ödeme kısmında ürün bilgisinin kullanılacağı yerde ve
3D Secure ile Ödeme'nin 2. adımında ürün bilgisinin istendiği yerde kullanılır.
*/
@XmlRootElement(name = "product")
public class Product {

	@XmlElement(name = "productCode")
	public String code;

	@XmlElement(name = "productName")
	public String title;

	@XmlElement(name = "quantity")
	public String quantity;

	@XmlElement(name = "price")
	public String price;
}
