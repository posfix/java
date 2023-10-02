<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="posfix.core.response.BankCardDeleteResponse"%>
<%@page import="posfix.core.request.BankCardDeleteRequest"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="posfix.core.Settings"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="layout.jsp" />

<form method="post" class="form-horizontal">
	<fieldset>
		<!-- Form Name -->
		<legend>Cüzdan Kart Sil</legend>
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
				<button type="submit" id="" name="" class="btn btn-success">Sil</button>
			</div>
		</div>
	</fieldset>
</form>

<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {

		/*  Cüzdandaki kartları silmek için kullanılan sayfadır. Setting ayarlarımızı alıyoruz.
        	    Formdan gelen bilgilerle BankCardDeleteRequest sınıfımızı dolduruyoruz. BankCardDeleteRequest ve Setting ayarlarımızla sayfamızı post ediyoruz.
		*/

		Settings settings = new Settings();

		BankCardDeleteRequest bankCardDeleteRequest = new BankCardDeleteRequest();
		bankCardDeleteRequest.userId = request.getParameter("userId");
		bankCardDeleteRequest.cardId = request.getParameter("cardId");
		bankCardDeleteRequest.clientIp = "127.0.0.1";
		BankCardDeleteResponse bankCardDeleteResponse = BankCardDeleteRequest.execute(bankCardDeleteRequest,settings); //"Cüzdandaki kartları silmek için servis çağrısının yapıldığı kısımdır."

		Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
		out.println("  <h1>Sonuç</h1>");

		out.println("<pre>" + g.toJson(bankCardDeleteResponse) + "</pre>"); //"Cüzdandaki kartları silmek için yapılan servis çağrısının sonucunda oluşan servis çıktı parametrelerinin ekranda gösterildiği kısımdır."

	}
%>

<jsp:include page="footer.jsp" />
