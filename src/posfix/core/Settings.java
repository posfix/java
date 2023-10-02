package posfix.core;

/*
	Tüm çağrılarda kullanılacak ayarların tutulduğu sınıftır.
	Bu sınıf üzerinde size özel parametreler fonksiyonlar arasında taşınabilir.
	Bu sınıf üzerinde tüm sistemde kullanacağımız ayarları tutar ve bunlara göre işlem yaparız.
	Bu sınıf örnek projemizde BaseController içerisinde kullanılmıştır. Ve tüm ayarların kullanılacağı yerde karşımıza çıkmaktadır.
*/


public class Settings {

	public String echo = "echo";
	public String publicKey  = ""; //"Public Magaza Anahtarı - size mağaza başvurunuz sonucunda gönderilen publik key (açık anahtar) bilgisini kullanınız.",;
	public String privateKey  = ""; //"Private Magaza Anahtarı  - size mağaza başvurunuz sonucunda gönderilen privaye key (gizli anahtar) bilgisini kullanınız.",;
	public String baseUrl = "https://api.posfix.com.tr/"; //"PosFix web servisleri API url'lerinin başlangıç bilgisidir. Restful web servis isteklerini takip eden kodlar halinde bulacaksınız."

	public String oneStepPaymentUrl = "https://api.posfix.com.tr/rest/payment/threed";
	public String mode = "T"; // "Test -> T, entegrasyon testlerinin sırasında "T" modunu, canlı sisteme entegre olarak ödeme almaya başlamak için ise Prod -> "P" modunu kullanınız."
	public String version = "1.0";// "Kullandığınız PosFix API versiyonudur. "
	public String hashString = ""; // "Kullanacağınız hash bilgisini, bağlanmak istediğiniz web servis bilgisine göre doldurulmalıdır. Bu bilgileri Entegrasyon rehberinin ilgili web servise ait bölümde bulabilirsiniz."
	/**
	 * @see Helper#getTransactionDateString()
	 */
	public String transactionDate; //transaction'in yapıldığı tarihi belirtir.
}
