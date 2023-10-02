package posfix.core.request;

import java.util.List;
import java.util.Set;

import posfix.core.Constants;
import posfix.core.CoreRequest;
import posfix.core.Helper;
import posfix.core.RestHttpCaller;
import posfix.core.Settings;
import posfix.core.entity.Product;
import posfix.core.entity.Purchaser;
import posfix.core.response.CheckoutFormCreateResponse;

public class CheckoutFormCreateRequest extends CoreRequest {

    // Request headers
    public String token;
    public String version;
    public String transactionDate;

    // Request data
    public Boolean threed;
    public Double amount;
    public String orderId;
    public String vendorId;
    public Set<String> allowedInstallments;
    public String callbackUrl;
    public Purchaser purchaser;
    public List<Product> products;
    private String custField1;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(String transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }

    public Boolean getThreed() {
        return threed;
    }

    public void setThreed(Boolean threed) {
        this.threed = threed;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getVendorId() {
        return vendorId;
    }

    public void setVendorId(String vendorId) {
        this.vendorId = vendorId;
    }

    public Set<String> getAllowedInstallments() {
        return allowedInstallments;
    }

    public void setAllowedInstallments(Set<String> allowedInstallments) {
        this.allowedInstallments = allowedInstallments;
    }

    public String getEcho() {
        return echo;
    }

    public void setEcho(String echo) {
        this.echo = echo;
    }

    public String getCallbackUrl() {
        return callbackUrl;
    }

    public void setCallbackUrl(String callbackUrl) {
        this.callbackUrl = callbackUrl;
    }

    public Purchaser getPurchaser() {
        return purchaser;
    }

    public void setPurchaser(Purchaser purchaser) {
        this.purchaser = purchaser;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public String getCustField1() {
        return custField1;
    }

    public void setCustField1(String custField1) {
        this.custField1 = custField1;
    }

    public static CheckoutFormCreateResponse execute(CheckoutFormCreateRequest request, Settings settings) throws Exception {
        settings.transactionDate = Helper.getTransactionDateString();
        settings.hashString = settings.privateKey
                + request.mode
                + request.getPurchaser().getName()
                + request.getPurchaser().getSurname()
                + request.getPurchaser().getEmail()
                + request.transactionDate;
        return RestHttpCaller.getInstance().postJson(settings.baseUrl + "rest/checkoutForm/create",
                Helper.getHttpHeaders(settings, Constants.ContentTypes.APPLICATION_JSON_UTF8),
                request, CheckoutFormCreateResponse.class);
    }
}
