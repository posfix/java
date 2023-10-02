<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="posfix.core.response.BankCardCreateResponse"%>
<%@page import="posfix.core.request.BankCardCreateRequest"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="posfix.core.Settings"%>
<%@page
	contentType="text/html"
	pageEncoding="UTF-8"
%>

<jsp:include page="layout.jsp" />

<form
	method="post"
	class="form-horizontal">
	<fieldset>
		<!-- Form Name -->
		<legend>Cüzdana Kart Ekleme</legend>
		<!-- Text input-->
		<div class="form-group">
			<label
				class="col-md-4 control-label"
				for=""
			>Kullanıcı Id:</label>
			<div class="col-md-4">
				<input
					name="userId"
					type="text"
					value="123456"
					class="form-control input-md"
					required
				>
			</div>
		</div>
		<div class="form-group">
			<label
				class="col-md-4 control-label"
				for=""
			>Kart Sahibi Adı Soyadı:</label>
			<div class="col-md-4">
				<input
					value="Fatih Coskun"
					name="nameSurname"
					class="form-control input-md"
					required
				>
			</div>
		</div>
		<div class="form-group">
			<label
				class="col-md-4 control-label"
				for=""
			> Kart Numarası:</label>
			<div class="col-md-4">
				<input
					value="4662803300111364"
					name="cardNumber"
					class="form-control input-md"
					required
				>
			</div>
		</div>
		<div class="form-group">
			<label
				class="col-md-4 control-label"
				for=""
			> Kart Kısa Adı: </label>
			<div class="col-md-4">
				<input
					value="Kredi Karti"
					name="cardAlias"
					class="form-control input-md"
					required
				>
			</div>
		</div>
		<div class="form-group">
			<label
				class="col-md-4 control-label"
				for=""
			> Son Kullanma Tarihi Ay/Yıl: </label>
			<div class="col-md-4">
				<input
					value="10"
					name="month"
					class="form-control input-md"
					width="50px"
					required
				> <input
					value="25"
					name="year"
					class="form-control input-md"
					width="50px"
					required
				>
			</div>
		</div>
		<!-- Button -->
		<div class="form-group">
			<label
				class="col-md-4 control-label"
				for=""
			></label>
			<div class="col-md-4">
				<button
					type="submit"
					id=""
					name=""
					class="btn btn-success"
				>Kart Ekle</button>
			</div>
		</div>
	</fieldset>
</form>




<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {

	/*
	   Cüzdana kart ekleme servisi için gerekli olan parametrelerin doldurulduğu kısımdır.
	   Setting ayarlarımızı alıp BankCardCreateRequest alanlarının formdan gelen verilere göre doldurulup post edildiği kısımdır.
	 */

		Settings settings = new Settings();

		BankCardCreateRequest bankCardCreateRequest = new BankCardCreateRequest();
		bankCardCreateRequest.userId = request.getParameter("userId");
		bankCardCreateRequest.cardOwnerName = request.getParameter("nameSurname");
		bankCardCreateRequest.cardNumber = request.getParameter("cardNumber");
		bankCardCreateRequest.cardAlias = request.getParameter("cardAlias");
		bankCardCreateRequest.cardExpireMonth = request.getParameter("month");
		bankCardCreateRequest.cardExpireYear = request.getParameter("year");
		bankCardCreateRequest.clientIp = "127.0.0.1";
		BankCardCreateResponse bankCardCreateresponse = BankCardCreateRequest.execute(bankCardCreateRequest,settings); //"Cüzdana kart ekleme servisi için istek çağrısının yapıldığı kısımdır."
		Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
		out.println("  <h1>Sonuç</h1>");
		out.println("<pre>" + g.toJson(bankCardCreateresponse) + "</pre>"); //"Cüzdana kart ekleme servisi için yapılan servis çağırısı sonucunda servis çıktı parametrelerinin ekranda gösterildiği kısımdır."
	}
%>

<jsp:include page="footer.jsp" />
