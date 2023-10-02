<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="posfix.core.response.BankCardInquryResponse"%>
<%@page import="posfix.core.request.BankCardInquiryRequest"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="posfix.core.Settings"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="layout.jsp" />

<form method="post" class="form-horizontal">
	<fieldset>
		<!-- Form Name -->
		<legend>Cüzdandaki Kartları Listele</legend>
		<!-- Text input-->
		<div class="form-group">
			<label class="col-md-4 control-label" for="">Kullanıcı Id:</label>
			<div class="col-md-4">
				<input name="userId" type="text" value="123456" class="form-control input-md" required="">
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-4 control-label" for=""> Kart ID (Opsiyonel):</label>
			<div class="col-md-4">
				<input value="" name="cardId" class="form-control input-md">
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
		    Cüzdandaki kartları listelemek için kullanıclan sayfadır. Setting ayarlarımızı alıyoruz.
		    Formdan gelen bilgilerle BankCardInquiryRequest sınıfımızı dolduruyoruz.BankCardInquiryRequest ve Setting ayarlarımızla sayfamızı post ediyoruz.
		*/

		Settings settings = new Settings();

		BankCardInquiryRequest bankCardInquiryRequest = new BankCardInquiryRequest();
		bankCardInquiryRequest.userId = request.getParameter("userId");
		bankCardInquiryRequest.cardId = request.getParameter("cardId");
		bankCardInquiryRequest.clientIp = "127.0.0.1";
		BankCardInquryResponse bankCardInquiryResponse = BankCardInquiryRequest.execute(bankCardInquiryRequest,settings); // "Cüzdandaki kartları listelemek için servis çağrısının yapıldığı kısımdır."

		out.println("  <h1>Sonuç</h1>");
		Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
		out.println("<pre>" + g.toJson(bankCardInquiryResponse) + "</pre>"); //"Cüzdandaki kartları listelemek için yapılan servis çağırısı sonucunda servis çıktı parametrelerinin ekranda gösterildiği kısımdır."

	}
%>

<jsp:include page="footer.jsp" />
