package posfix.core.request;

import posfix.core.Constants;
import posfix.core.CoreRequest;
import posfix.core.Helper;
import posfix.core.RestHttpCaller;
import posfix.core.Settings;
import posfix.core.response.BankCardInquryResponse;

// Cüzdanda bulunan kartları getirmek için gerekli olan servis girdi parametrelerini temsil eder.
public class BankCardInquiryRequest extends CoreRequest {

	public String userId;
	public String clientIp;
	public String cardId;

	/*
	 *	Mağazanın, kullanıcının bir kartını veya kayıtlı olan kartları getirmek istediği zaman kullanabileceği servisi temsil eder.
	 *	@request Cüzdanda bulunan kartları getirmek için gerekli olan girdilerin olduğu sınıfı temsil eder.
	 *	@options Kullanıcıya özel olarak belirlenen ayarları temsil eder.
	*/
	public static BankCardInquryResponse execute(BankCardInquiryRequest request, Settings settings) throws Exception {
		settings.transactionDate = Helper.getTransactionDateString();
		settings.hashString = settings.privateKey
				+ request.userId
				+ request.cardId
				+ request.clientIp
				+ settings.transactionDate;
		return RestHttpCaller.getInstance().postJson(settings.baseUrl + "/bankcard/inquiry",
				Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8), request,
				BankCardInquryResponse.class);
	}

}
