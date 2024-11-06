package posfix.core.response;

import posfix.core.CoreResponse;

// Ön Otorizasyon Kapama servis çıktı parametre alanlarını temsil etmektedir.
public class PostAuthResponse extends CoreResponse {
    public String amount;
    public String orderId;
    public String commissionRate;
}
