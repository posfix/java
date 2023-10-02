package posfix.core.response;

import java.util.List;

import posfix.core.CoreResponse;
// Cüzdana kart ekleme servis çıktı parametre alanlarını temsil eder.
public class BankCardCreateResponse extends CoreResponse {

	public String cardId;

	public String maskNumber;

	public String alias;

	public String bankId;

	public String bankName;

	public String cardFamilyName;

	public String supportsInstallment;

	public List<String> supportedInstallments;

	public String type;

	public String serviceProvider;

	public String threeDSecureMandatory;

	public String cvcMandatory;

}
