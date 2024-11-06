<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.UUID"%>
<%@page import="posfix.core.entity.Purchaser"%>
<%@page import="posfix.core.entity.PurchaserAddress"%>
<%@page import="java.util.ArrayList"%>
<%@page import="posfix.core.entity.Product"%>
<%@page import="posfix.core.Settings"%>
<%@ page import="posfix.core.request.PreAuthRequest" %>
<%@ page import="posfix.core.response.PreAuthResponse" %>

<%@page
		contentType="text/html"
		pageEncoding="UTF-8"
%>

<jsp:include page="layout.jsp" />

<fieldset>
	<legend>
		<label style="font-weight: bold; width: 250px;">Sepet Bilgileri</label>
	</legend>
	<table class="table">
		<thead>
		<tr>
			<th>Ürün</th>
			<th>Kod</th>
			<th>Adet</th>
			<th>Birim Fiyat</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td>Telefon</td>
			<td>TLF0001</td>
			<td>1</td>
			<td>50.00 TL</td>
		</tr>
		<tr>
			<td>Bilgisayar</td>
			<td>BLG0001</td>
			<td>1</td>
			<td>50.00 TL</td>
		</tr>

		<tr>
			<td colspan="3">Toplam Tutar</td>

			<td>100.00 TL</td>
		</tr>
		</tbody>
	</table>
</fieldset>
<fieldset>
	<legend>
		<label style="font-weight: bold; width: 250px;">Kargo Adresi Bilgileri</label>
	</legend>
	<label style="font-weight: bold;">Ad :</label> Ahmet<br> <label style="font-weight: bold;">Soyad :</label> Veli <br>
	<label style="font-weight: bold;">Adres :</label> Mevlüt Pehlivan Mah. PosFix Plaza Şişli <br> <label
		style="font-weight: bold;"
>Posta Kodu :</label> 34782 <br> <label style="font-weight: bold;">Şehir :</label> İstanbul <br> <label
		style="font-weight: bold;"
>Ülke :</label> Türkiye <br> <label style="font-weight: bold;">Telefon Numarası:</label> 2123886600 <br>
</fieldset>
<fieldset>
	<legend>
		<label style="font-weight: bold; width: 250px;">Fatura Adresi Bilgileri</label>
	</legend>
	<label style="font-weight: bold;">Ad :</label> Ahmet<br> <label style="font-weight: bold;">Soyad :</label> Veli<br>
	<label style="font-weight: bold;">Adres :</label> Mevlüt Pehlivan Mah. PosFix Plaza Şişli<br> <label
		style="font-weight: bold;"
>Posta Kodu :</label> 34782<br> <label style="font-weight: bold;">Şehir :</label> İstanbul<br> <label
		style="font-weight: bold;"
>Ülke :</label> Türkiye<br> <label style="font-weight: bold;">TC Kimlik Numarası :</label> 1234567890<br> <label
		style="font-weight: bold;"
>Telefon Numarası:</label> 2123886600<br> <label style="font-weight: bold;">Vergi Numarası :</label> 123456<br> <label
		style="font-weight: bold;"
>Vergi Dairesi Adı :</label> Kozyatağı<br> <label style="font-weight: bold;">Firma Adı:</label> PosFix
</fieldset>
<form
		method="post"
		class="form-horizontal"
>
	<fieldset>
		<!-- Form Name -->
		<legend>
			<label style="font-weight: bold; width: 250px;">Kart Bilgileriyle Ödeme</label>
		</legend>
		<!-- Text input-->
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
				> <input
					value="25"
					name="year"
					class="form-control input-md"
					width="50px"
			>
			</div>
		</div>
		<div class="form-group">
			<label
					class="col-md-4 control-label"
					for=""
			> CVC: </label>
			<div class="col-md-4">
				<input
						value="000"
						name="cvc"
						class="form-control input-md"
				>
			</div>
		</div>
	</fieldset>
	Taksit Sayısı <select name="installment">
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
</select>
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
			>Ön Otorizasyon Açma</button>
		</div>
	</div>
</form>

<%
	request.setCharacterEncoding("UTF-8");
	/* Ön Otorizasyon Açma için gerekli olan parametrelerin doldurulduğu kısımdır. setting ayarlarımızı alıp, PreAuthRequest alanlarının formdan gelen verilere göre doldurup post edildiği kısımdır.
	  Post işlemi sonucunda oluşan sonucu ekranda gösteriyoruz.
	*/

	if ("POST".equalsIgnoreCase(request.getMethod())) {
		Settings settings = new Settings();

		PreAuthRequest preAuthRequest = new PreAuthRequest();
		UUID uuid = UUID.randomUUID();

		preAuthRequest.orderId = uuid.toString();
		preAuthRequest.echo = "Echo";
		preAuthRequest.mode = settings.mode;
		preAuthRequest.amount = "10000"; // 100 tL
		preAuthRequest.cardOwnerName = request.getParameter("nameSurname");
		preAuthRequest.cardNumber = request.getParameter("cardNumber");
		preAuthRequest.cardExpireMonth = request.getParameter("month");
		preAuthRequest.cardExpireYear = request.getParameter("year");
		preAuthRequest.installment = request.getParameter("installment");
		preAuthRequest.cardCvc = request.getParameter("cvc");
		preAuthRequest.cardId = "";
		preAuthRequest.userId = "";
		preAuthRequest.threeD = "false";
		preAuthRequest.waitingConfirmation ="false";

		preAuthRequest.purchaser = new Purchaser();
		preAuthRequest.purchaser.name = "Ahmet";
		preAuthRequest.purchaser.surname = "Veli";
		preAuthRequest.purchaser.birthDate = "1986-07-11";
		preAuthRequest.purchaser.email = "ahmet@veli.com";
		preAuthRequest.purchaser.gsmNumber = "5881231212";
		preAuthRequest.purchaser.tcCertificate = "1234567890";
		preAuthRequest.purchaser.clientIp = "127.0.0.1";

		preAuthRequest.purchaser.invoiceAddress = new PurchaserAddress();
		preAuthRequest.purchaser.invoiceAddress.name = "Ahmet";
		preAuthRequest.purchaser.invoiceAddress.surname = "Veli";
		preAuthRequest.purchaser.invoiceAddress.address = "Mevlüt Pehlivan Mah. PosFix Plaza Şişli";
		preAuthRequest.purchaser.invoiceAddress.zipcode = "34782";
		preAuthRequest.purchaser.invoiceAddress.city = "34";
		preAuthRequest.purchaser.invoiceAddress.tcCertificate = "1234567890";
		preAuthRequest.purchaser.invoiceAddress.country = "TR";
		preAuthRequest.purchaser.invoiceAddress.taxNumber = "123456";
		preAuthRequest.purchaser.invoiceAddress.taxOffice = "Kozyatağı";
		preAuthRequest.purchaser.invoiceAddress.companyName = "PosFix";
		preAuthRequest.purchaser.invoiceAddress.phoneNumber = "2122222222";

		preAuthRequest.purchaser.shippingAddress = new PurchaserAddress();
		preAuthRequest.purchaser.shippingAddress.name = "Ahmet";
		preAuthRequest.purchaser.shippingAddress.surname = "Veli";
		preAuthRequest.purchaser.shippingAddress.address = "Mevlüt Pehlivan Mah. PosFix Plaza Şişli";
		preAuthRequest.purchaser.shippingAddress.zipcode = "34782";
		preAuthRequest.purchaser.shippingAddress.city = "34";
		preAuthRequest.purchaser.shippingAddress.tcCertificate = "1234567890";
		preAuthRequest.purchaser.shippingAddress.country = "TR";
		preAuthRequest.purchaser.shippingAddress.phoneNumber = "2122222222";

		preAuthRequest.products = new ArrayList<Product>();
		Product product1 = new Product();
		product1.title = "Telefon";
		product1.code = "TLF0001";
		product1.price = "5000";
		product1.quantity = "1";
		preAuthRequest.products.add(product1);

		PreAuthResponse preAuthResponse = PreAuthRequest.execute(preAuthRequest, settings); // "Ön Otorizasyon Açma servis çağrısının yapıldığı kısımdır."

		Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
		out.println("  <h1>Sonuç</h1>");

		out.println("<pre>" + g.toJson(preAuthResponse) + "</pre>");//"Ön Otorizasyon Açma servis çağırısı sonucunda servis çıktı parametrelerinin ekranda gösterildiği kısımdır."
	}
%>

<jsp:include page="footer.jsp" />
