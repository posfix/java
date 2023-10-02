package posfix.core.request;

import posfix.core.Constants;
import posfix.core.CoreRequest;
import posfix.core.Helper;
import posfix.core.RestHttpCaller;
import posfix.core.Settings;
import posfix.core.response.BankCardDeleteResponse;

//Cüzdanda kayıtlı olan kartı silmek için gerekli olan servis girdi parametrelerini temsil eder.
public class BankCardDeleteRequest extends CoreRequest {

	public String userId;
	public String cardId;
	public String clientIp;

	/*
	 *	Mağazanın, kullanıcının bir kartını veya kayıtlı olan tüm kartlarını silmek istediği zaman kullanabileceği servisi temsil eder.
	 *	@request Banka kartı silmek için gerekli olan girdilerin olduğu sınıfı temsil eder.
	 *	@options Kullanıcıya özel olarak belirlenen ayarları temsil eder.
	*/
	public static BankCardDeleteResponse execute(BankCardDeleteRequest request, Settings settings) throws Exception {

		settings.transactionDate = Helper.getTransactionDateString();
		settings.hashString = settings.privateKey
				+ request.userId
				+ request.cardId
				+ request.clientIp
				+ settings.transactionDate;
		return RestHttpCaller.getInstance().postJson(settings.baseUrl + "/bankcard/delete",
				Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8), request,
				BankCardDeleteResponse.class);

	}

}
