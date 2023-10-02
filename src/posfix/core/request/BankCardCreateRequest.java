package posfix.core.request;

import posfix.core.Constants;
import posfix.core.CoreRequest;
import posfix.core.Helper;
import posfix.core.RestHttpCaller;
import posfix.core.Settings;
import posfix.core.response.BankCardCreateResponse;

// Cüzdana kart ekleme servisi içerisinde kullanılacak alanları temsil etmektedir.
public class BankCardCreateRequest extends CoreRequest {

	public String userId;
	public String cardOwnerName;
	public String cardNumber;
	public String cardAlias;
	public String cardExpireMonth;
	public String cardExpireYear;
	public String clientIp;


	/*
	 *	Cüzdana kart ekleme istek metodur. Bu metod çeşitli kart bilgilerini ve settings sınıfı içerisinde bize özel olarak oluşan alanları kullanarak cüzdana
	 *	bir kartı kaydetmemizi sağlar.
	 *	@request  Cüzdana kart eklemek için gerekli olan girdilerin olduğu sınıfı temsil eder.
	 *	@options Kullanıcıya özel olarak belirlenen ayarları temsil eder.
	*/
	public static BankCardCreateResponse execute(BankCardCreateRequest request, Settings settings) throws Exception {

		settings.transactionDate = Helper.getTransactionDateString();
		settings.hashString = settings.privateKey
				+ request.userId
				+ request.cardOwnerName
				+ request.cardNumber
				+ request.cardExpireMonth
				+ request.cardExpireYear
				+ request.clientIp
				+ settings.transactionDate;
		return RestHttpCaller.getInstance().postJson(settings.baseUrl + "/bankcard/create",
				Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8), request,
				BankCardCreateResponse.class);
	}

}
