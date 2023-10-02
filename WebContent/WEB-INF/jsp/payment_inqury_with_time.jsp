<%@page import="posfix.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="posfix.core.response.PaymentInquiryResponse"%>
<%@page import="posfix.core.request.PaymentInquiryWithTimeRequest"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="posfix.core.Settings"%>
<%@ page import="org.springframework.util.StringUtils" %>
<%@ page import="posfix.core.response.PaymentInquiryWithTimeResponse" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="layout.jsp" />

<form method="post" class="form-horizontal">
	<fieldset>
		<!-- Form Name -->
		<legend>Ödeme Sorgulama (Tarih Aralığında) </legend>
		<!-- Text input-->
		<!--<div class="form-group">
			<label class="col-md-4 control-label" for="">Sipariş Numarası:</label>
			<div class="col-md-4">
				<input name="orderId" type="text" value="2dc6d77e-21be-4557-9551-89cd2feead0c" class="form-control input-md" required>
			</div>
		</div>-->
		<div class="form-group">
			<label class="col-md-4 control-label" for=""
			>Başlangıç Tarihi (Gün/Ay/Yıl) (*):</label
			>
			<div class="col-md-1">
				<input
						name="startDay"
						type="text"
						value="07"
						class="form-control input-md"
						required
				/>
			</div>
			<div class="col-md-1">
				<input
						name="startMonth"
						type="text"
						value="11"
						class="form-control input-md"
						required
				/>
			</div>
			<div class="col-md-1">
				<input
						name="startYear"
						type="text"
						value="2021"
						class="form-control input-md"
						required
				/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-4 control-label" for=""
			>Bitiş Tarihi (Gün/Ay/Yıl) (*):</label
			>
			<div class="col-md-1">
				<input
						name="endDay"
						type="text"
						value="09"
						class="form-control input-md"
						required
				/>
			</div>
			<div class="col-md-1">
				<input
						name="endMonth"
						type="text"
						value="11"
						class="form-control input-md"
						required
				/>
			</div>
			<div class="col-md-1">
				<input
						name="endYear"
						type="text"
						value="2021"
						class="form-control input-md"
						required
				/>
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

		PaymentInquiryWithTimeRequest paymentInquiryWithTimeRequest = new PaymentInquiryWithTimeRequest();
		if (!StringUtils.isEmpty(request.getParameter("startDay")) && request.getParameter("startDay") != null) { // Eğer başlangıç tarihi girildiyse, bitiş tarihi de girilmelidir.
			paymentInquiryWithTimeRequest.startDate = request.getParameter("startYear") + "-" + request.getParameter("startMonth") + "-" + request.getParameter("startDay") + " 00:00:00";
			paymentInquiryWithTimeRequest.endDate = request.getParameter("endYear") + "-" +request.getParameter("endMonth")  + "-" + request.getParameter("endDay") + " 23:59:59";
		} else
		{
			paymentInquiryWithTimeRequest.startDate = null;
			paymentInquiryWithTimeRequest.endDate = null;
		}
		paymentInquiryWithTimeRequest.echo = "Echo";
		paymentInquiryWithTimeRequest.mode = settings.mode;
		PaymentInquiryWithTimeResponse paymnentInquiryResponse = PaymentInquiryWithTimeRequest.execute1(paymentInquiryWithTimeRequest,
				settings); //"Ödeme sorgulama servisi başlatılması için gerekli servis çağırısını temsil eder."

		    StringWriter sw = new StringWriter();
                 JAXB.marshal(paymnentInquiryResponse, sw);

		Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
		out.println("  <h1>Sonuç</h1>");
		out.println("<pre>" + g.toJson(paymnentInquiryResponse) + "</pre>"); //"Ödeme sorgulama servis çağrısı sonucunda oluşan servis çıktı parametrelerinin ekranda gösterilmesini sağlar"
	}
%>

<jsp:include page="footer.jsp" />
