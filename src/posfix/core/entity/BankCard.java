package posfix.core.entity;

import java.util.List;

/*
Bu sınıf cüzdana kart ekleme servisi isteği sonucunda ve cüzdandaki kartları getir isteği sonucunda bize döndürülen
alanları temsil etmektedir.
*/
public class BankCard {

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
