package posfix.core.response;

import java.util.List;

import posfix.core.CoreResponse;
import posfix.core.entity.BankCard;
// Cüzdanda bulunan kartları getirmek için kullanılan servis çıktı parametrelerini temsil etmektedir.
public class BankCardInquryResponse extends CoreResponse {

	public List<BankCard> cards;

}
