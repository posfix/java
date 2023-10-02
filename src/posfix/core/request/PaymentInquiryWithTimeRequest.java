package posfix.core.request;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import posfix.core.Constants;
import posfix.core.CoreRequest;
import posfix.core.Helper;
import posfix.core.RestHttpCaller;
import posfix.core.Settings;
import posfix.core.response.PaymentInquiryResponse;
import posfix.core.response.PaymentInquiryWithTimeResponse;

//  Ödeme sorugulama servisi için gerekli olan servis girdi parametrelerini temsil eder.
@XmlRootElement(name = "inquiry")
public class PaymentInquiryWithTimeRequest extends CoreRequest{

	@XmlElement(name = "endDate")
	public String endDate;
	@XmlElement(name ="startDate")
	public  String startDate;

	/*
	 *	Bu servise sorgulanmak istenen ödemenin mağaza sipariş numarası ve mode değeri iletilerek, ödemenin durumu ve ödemenin tutarı öğrenilebileceği servisi temsil eder.
	 *	@request Ödeme sorgulama servisi için gerekli olan girdilerin olduğu sınıfı temsil eder.
	 *	@options Kullanıcıya özel olarak belirlenen ayarları temsil eder.
	*/
	public static PaymentInquiryResponse execute(PaymentInquiryWithTimeRequest request, Settings settings) throws Exception {

		settings.transactionDate = Helper.getTransactionDateString();
		settings.hashString = settings.privateKey + settings.mode + settings.transactionDate;
		return RestHttpCaller.getInstance().postXML(settings.baseUrl + "rest/payment/inquiry",
				Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_XML_UTF8), request,
				PaymentInquiryResponse.class);

	}

	public static PaymentInquiryWithTimeResponse execute1(PaymentInquiryWithTimeRequest request, Settings settings) throws Exception {

		settings.transactionDate = Helper.getTransactionDateString();
		settings.hashString = settings.privateKey + settings.mode + settings.transactionDate;
		return RestHttpCaller.getInstance().postJson(settings.baseUrl + "rest/payment/search",
				Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8),
				request, PaymentInquiryWithTimeResponse.class);
	}

}
