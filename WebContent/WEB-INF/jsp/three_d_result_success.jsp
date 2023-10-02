<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="posfix.core.entity.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="posfix.core.entity.PurchaserAddress"%>
<%@page import="posfix.core.entity.Purchaser"%>
<%@page import="posfix.core.request.ThreeDPaymentCompleteRequest"%>
<%@page import="posfix.core.Helper"%>
<%@page import="java.util.UUID"%>
<%@page import="posfix.core.Settings"%>
<%@page import="posfix.core.response.*"%>
<%@page import="com.google.gson.Gson"%>

<%@page
	contentType="text/html"
	pageEncoding="UTF-8"
%>

<%!ThreeDPaymentCompleteResponse completeResponse = new ThreeDPaymentCompleteResponse();%>

<jsp:include page="layout.jsp" />

<%
	request.setCharacterEncoding("UTF-8");
	Settings settings = new Settings();

	ThreeDPaymentInitResponse paymentResponse = new ThreeDPaymentInitResponse();
	paymentResponse.orderId = request.getParameter("orderId");
	paymentResponse.result = request.getParameter("result");
	paymentResponse.mode = request.getParameter("mode");
	paymentResponse.amount = request.getParameter("amount");

	if (request.getParameter("errorCode") != null) {
		paymentResponse.errorCode = request.getParameter("errorCode");
	}

	if (request.getParameter("errorMessage") != null) {
		paymentResponse.errorMessage = request.getParameter("errorMessage");
	}

	if (request.getParameter("transactionDate") != null) {
		paymentResponse.transactionDate = request.getParameter("transactionDate");
	}

	if (request.getParameter("hash") != null) {
		paymentResponse.hash = request.getParameter("hash");
	}

	if (Helper.validate3DReturn(paymentResponse, settings)) {

		//3D secure 2. Adımında eğer 1. adım başarılı olarak geçtiyse ThreeDPaymentCompleteRequest datalarını formdan gelen bilgilerle dolduruyor ve post ediyoruz.
		ThreeDPaymentCompleteRequest completeRequest = new ThreeDPaymentCompleteRequest();
		completeRequest.orderId = request.getParameter("orderId");
		completeRequest.echo = "Echo";
		completeRequest.mode = settings.mode;
		completeRequest.amount = "10000"; // 100 tL
		completeRequest.cardOwnerName = "Fatih Coşkun";
		completeRequest.cardNumber = "4662803300111364";
		completeRequest.cardExpireMonth = "10";
		completeRequest.cardExpireYear = "25";
		completeRequest.installment = "1";
		completeRequest.cvc = "000";
		completeRequest.threeD = "true";
		completeRequest.threeDSecureCode = request.getParameter("threeDSecureCode");

		completeRequest.purchaser = new Purchaser();
		completeRequest.purchaser.birthDate = "1986-07-11";
		completeRequest.purchaser.gsmNumber = "5881231212";
		completeRequest.purchaser.tcCertificate = "1234567890";

		completeRequest.purchaser.invoiceAddress = new PurchaserAddress();
		completeRequest.purchaser.invoiceAddress.name = "Ahmet";
		completeRequest.purchaser.invoiceAddress.surname = "Veli";
		completeRequest.purchaser.invoiceAddress.address = "Mevlüt Pehlivan Mah. PosFix Plaza Şişli";
		completeRequest.purchaser.invoiceAddress.zipcode = "34782";
		completeRequest.purchaser.invoiceAddress.city = "34";
		completeRequest.purchaser.invoiceAddress.tcCertificate = "1234567890";
		completeRequest.purchaser.invoiceAddress.country = "TR";
		completeRequest.purchaser.invoiceAddress.taxNumber = "123456";
		completeRequest.purchaser.invoiceAddress.taxOffice = "Kozyatağı";
		completeRequest.purchaser.invoiceAddress.companyName = "PosFix";
		completeRequest.purchaser.invoiceAddress.phoneNumber = "2122222222";

		completeRequest.purchaser.shippingAddress = new PurchaserAddress();
		completeRequest.purchaser.shippingAddress.name = "Ahmet";
		completeRequest.purchaser.shippingAddress.surname = "Veli";
		completeRequest.purchaser.shippingAddress.address = "Mevlüt Pehlivan Mah. PosFix Plaza Şişli";
		completeRequest.purchaser.shippingAddress.zipcode = "34782";
		completeRequest.purchaser.shippingAddress.city = "34";
		completeRequest.purchaser.shippingAddress.tcCertificate = "1234567890";
		completeRequest.purchaser.shippingAddress.country = "TR";
		completeRequest.purchaser.shippingAddress.phoneNumber = "2122222222";

		completeRequest.products = new ArrayList<>();
		Product product1 = new Product();
		product1.title = "Telefon";
		product1.code = "TLF0001";
		product1.price = "5000";
		product1.quantity = "1";
		completeRequest.products.add(product1);
		Product product2 = new Product();
		product2.title = "Bilgisayar";
		product2.code = "BLG0001";
		product2.price = "5000";
		product2.quantity = "1";
		completeRequest.products.add(product2);
		completeResponse = ThreeDPaymentCompleteRequest.execute(completeRequest, settings); //"3D secure 2. adımının başlatılması için gerekli servis çağrısını temsil eder."
	}
%>

<h1>3d Başarılı!</h1>


    <%
    	       StringWriter sw = new StringWriter();
                 JAXB.marshal(completeResponse, sw);
		out.println("  <h1>Sonuç</h1>");
		out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ödeme işlemi sonucunda ekranda gösterilecek servis çıktı parametrelerinin yer aldığı kısmı temsil etmektedir.
    %>

<jsp:include page="footer.jsp" />
