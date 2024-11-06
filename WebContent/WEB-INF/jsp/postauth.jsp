<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="posfix.core.Settings"%>
<%@ page import="posfix.core.request.PostAuthRequest" %>
<%@ page import="posfix.core.response.PostAuthResponse" %>

<%@page
		contentType="text/html"
		pageEncoding="UTF-8"
%>

<jsp:include page="layout.jsp" />

<form
		method="post"
		class="form-horizontal"
>
	<fieldset>
		<!-- Form Name -->
		<legend>
			<label style="font-weight: bold; width: 250px;">Ödeme Bilgileri</label>
		</legend>
		<!-- Text input-->
		<div class="form-group">
			<label
					class="col-md-4 control-label"
					for=""
			>Order Id:</label>
			<div class="col-md-4">
				<input
						value=""
						name="orderId"
						class="form-control input-md"
				>
			</div>
		</div>

		<div class="form-group">
			<label
					class="col-md-4 control-label"
					for=""
			>Amount:</label>
			<div class="col-md-4">
				<input
						value=""
						name="amount"
						class="form-control input-md"
				>
			</div>
		</div>

	</fieldset>

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
			>Ön Otorizasyon Kapama</button>
		</div>
	</div>
</form>

<%
	request.setCharacterEncoding("UTF-8");
	/* Ön Otorizasyon Kapama için gerekli olan parametrelerin doldurulduğu kısımdır. setting ayarlarımızı alıp, PostAuthRequest alanlarının formdan gelen verilere göre doldurup post edildiği kısımdır.
	  Post işlemi sonucunda oluşan sonucu ekranda gösteriyoruz.
	*/

	if ("POST".equalsIgnoreCase(request.getMethod())) {

		Settings settings = new Settings();

		PostAuthRequest postAuthRequest = new PostAuthRequest();

		postAuthRequest.orderId = request.getParameter("orderId");
		postAuthRequest.mode = settings.mode;
		postAuthRequest.amount = request.getParameter("amount"); // 100 tL
		postAuthRequest.clientIp = "127.0.0.1";


		PostAuthResponse postAuthResponse = PostAuthRequest.execute(postAuthRequest, settings); // "Ön Otorizasyon Kapama servis çağrısının yapıldığı kısımdır."

		Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
		out.println("  <h1>Sonuç</h1>");

		out.println("<pre>" + g.toJson(postAuthResponse) + "</pre>");//"Ön Otorizasyon Kapama servis çağırısı sonucunda servis çıktı parametrelerinin ekranda gösterildiği kısımdır."
	}
%>

<jsp:include page="footer.jsp" />
