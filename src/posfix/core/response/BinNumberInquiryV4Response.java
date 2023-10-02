package posfix.core.response;

import posfix.core.CoreResponse;

import java.io.Serializable;
import java.util.List;

public class BinNumberInquiryV4Response extends CoreResponse {

    private Integer bankId;
    private String bankName;
    private Integer cardFamilyId;
    private String cardFamilyName;
    private Integer supportsInstallment;
    private Integer[] supportedInstallments;
    private Integer type;
    private Integer serviceProvider;
    private Integer cardThreeDSecureMandatory;
    private Integer merchantThreeDSecureMandatory;
    private Integer cvcMandatory;
    private Integer businessCard;
    private List<RequiredAmountWithCCommDTO> installmentDetailWithCComm;
    private Integer supportsAgriculture;

    public List<RequiredAmountWithCCommDTO> getInstallmentDetailWithCComm() {
        return installmentDetailWithCComm;
    }

    class RequiredAmountWithCCommDTO implements Serializable {
        private String requiredAmount;
        private String requiredCommissionAmount;
        private int installment;
        private String commissionAmount;
        private String merchantCommissionRate;
        private String customizedRequiredAmount;
        private String customizedRequiredCommissionAmount;
        private String customizedMerchantCommissionRate;

        private Double commissionAmountTransient;
        private Double requiredAmountTransient;
        private Double merchantCommissionRateTransient;
        private Double requiredCommissionAmountTransient;
        private Double customizedRequiredAmountTransient;
        private Double customizedRequiredCommissionAmountTransient;
        private Double customizedMerchantCommissionRateTransient;
    }

}
