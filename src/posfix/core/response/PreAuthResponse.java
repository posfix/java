package posfix.core.response;

import posfix.core.CoreResponse;

// Ön Otorizasyon Açma servis çıktı parametre alanlarını temsil etmektedir.
public class PreAuthResponse extends CoreResponse {
    public String amount;
    public String orderId;
    public String commissionRate;
}
