<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="posfix.core.response.BinNumberInquiryResponse"%>
<%@page import="posfix.core.request.BinNumberInquiryRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="posfix.core.Settings"%>
<%@page import="posfix.core.request.*"%>
<%@ page import="posfix.core.response.PaymentRefundInquiryResponse" %>

<jsp:include page="layout.jsp" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<form method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend>İade Sorgulama</legend>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Sipariş Numarası:</label>
            <div class="col-md-4">
                <input name="orderId" type="text" value="" class="form-control input-md" required="">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Tutar:</label>
            <div class="col-md-4">
                <input name="amount" type="text" value="" class="form-control input-md" required="">
                <label style="font-weight:normal; font-size:small">*Sipariş tutarı kuruş ayracı olmadan gönderilmelidir. Örneğin; 1 TL 100, 12 1200, 130 13000, 1.05 105, 1.2 120 olarak gönderilmelidir.</label>
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
<br />

<%
    request.setCharacterEncoding("UTF-8");

    if ("POST".equalsIgnoreCase(request.getMethod())) {


		/* Setting ayarlarımızı alıyoruz. İade oluşturmak için gerekli parametreleri İade sorgulamadan alıyoruz.
		   Formdan gelen bilgi ile request ve Setting ayarlarımızı post ediyoruz
		*/

        Settings settings = new Settings();

        PaymentRefundInquiryRequest paymentRefundInquiryRequest = new PaymentRefundInquiryRequest();
        paymentRefundInquiryRequest.orderId = request.getParameter("orderId");
        paymentRefundInquiryRequest.amount = request.getParameter("amount");
        paymentRefundInquiryRequest.clientIp="127.0.0.1";
        PaymentRefundInquiryResponse paymentRefundInquiryResponse = PaymentRefundInquiryRequest.execute(paymentRefundInquiryRequest, settings); // "Bin sorgulama servisinin başlatıldığı kısım"

        Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
        out.println("  <h1>Sonuç</h1>");
        out.println("<pre>" + g.toJson(paymentRefundInquiryResponse) + "</pre>"); //"Bin sorgulama servisi sonucunda oluşan çıktı parametrelerinin ekranda gösterildiği kısımdır."

    }
%>

<jsp:include page="footer.jsp" />
