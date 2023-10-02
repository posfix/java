package posfix.core;

import javax.xml.bind.annotation.XmlElement;

//Tüm cevap sınıflarında kullanılacak olan alanları temsil etmektedir.
public class CoreResponse {

	@XmlElement(name = "result")

	public String result;

	@XmlElement(name = "errorCode")
	public String errorCode;

	@XmlElement(name = "errorMessage")
	public String errorMessage;

	@XmlElement(name = "responseMessage")
	public String responseMessage;

	@XmlElement(name = "mode")
	public String mode;

	@XmlElement(name = "echo")
	public String echo;

	@XmlElement(name = "hash")
	public String hash;

	@XmlElement(name = "transactionDate")
	public String transactionDate;

}
