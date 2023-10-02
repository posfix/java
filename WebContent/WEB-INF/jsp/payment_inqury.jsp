<%@page import="posfix.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="posfix.core.response.PaymentInquiryResponse"%>
<%@page import="posfix.core.request.PaymentInquiryRequest"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="posfix.core.Settings"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="layout.jsp" />

<form method="post" class="form-horizontal">
	<fieldset>
		<!-- Form Name -->
		<legend>Ödeme Sorgulama</legend>
		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="">Sipariş Numarası:</label>
			<div class="col-md-4">
				<input name="orderId" type="text" value="2dc6d77e-21be-4557-9551-89cd2feead0c" class="form-control input-md" required>
			</div>
		</div>
		<!-- Button -->
		<div class="form-group">
			<label class="col-md-4 control-label" for=""></label>
			<div class="col-md-4">
				<button type="submit" id="" name="" class="btn btn-success">Sorgula</button>
			</div>
		</div>
	</fieldset>
</form>

<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {


		/*
		   Setting ayarlarımızı alıyoruz. Formdan gelen bilgilerle PaymentInquiryRequest sınıfımızı dolduruyoruz.
		   PaymentInquiryRequest ve Setting ayarlarımızla sayfamızı post ediyoruz.
		*/
		Settings settings = new Settings();

		PaymentInquiryRequest paymentInquiryRequest = new PaymentInquiryRequest();
		paymentInquiryRequest.orderId = request.getParameter("orderId");
		paymentInquiryRequest.echo = "Echo";
		paymentInquiryRequest.mode = settings.mode;
		PaymentInquiryResponse paymnentInquiryResponse = PaymentInquiryRequest.execute(paymentInquiryRequest,
				settings); //"Ödeme sorgulama servisi başlatılması için gerekli servis çağırısını temsil eder."

		StringWriter sw = new StringWriter();
		JAXB.marshal(paymnentInquiryResponse, sw);

		out.println("  <h1>Sonuç</h1>");
		out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ödeme sorgulama servis çağrısı sonucunda oluşan servis çıktı parametrelerinin ekranda gösterilmesini sağlar"
	}
%>

<jsp:include page="footer.jsp" />
