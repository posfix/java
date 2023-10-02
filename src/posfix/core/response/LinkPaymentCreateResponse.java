package posfix.core.response;

import posfix.core.CoreResponse;

// Link ile Ödeme Link Olusturma servis çıktı parametre alanlarını temsil etmektedir.
import javax.xml.bind.annotation.XmlElement;

public class LinkPaymentCreateResponse extends CoreResponse {

    @XmlElement(name = "amount")
    public String amount;

    @XmlElement(name = "link")
    public String link;

    @XmlElement(name = "linkPaymentId")
    public String linkPaymentId;

}
