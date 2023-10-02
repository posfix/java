<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="posfix.core.response.BinNumberInquiryResponse"%>
<%@page import="posfix.core.request.BinNumberInquiryRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="posfix.core.Settings"%>
<%@page import="posfix.core.request.*"%>
<%@ page import="posfix.core.response.PaymentRefundInquiryResponse" %>
<%@ page import="posfix.core.response.CreateRefundInquiryResponse" %>

<jsp:include page="layout.jsp" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<form method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend>İade Oluşturma</legend>
        <!-- Text input-->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Sipariş Numarası</label>
            <div class="col-md-4">
                <input id="orderId" name="orderId" type="text" placeholder="" value="" class="form-control input-md"
                       required=""
                >
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">RefundHash</label>
            <div class="col-md-4">
                <input id="refundHash" name="refundHash" type="text" placeholder="" value="" class="form-control input-md"
                       required=""
                >
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Tutar</label>
            <div class="col-md-4">
                <input id="amount" name="amount" type="text" placeholder="" value="100" class="form-control input-md"
                       required=""
                >
                <label style="font-weight:normal; font-size:small">*Sipariş tutarı kuruş ayracı olmadan gönderilmelidir. Örneğin; 1 TL 100, 12 1200, 130 13000, 1.05 105, 1.2 120 olarak gönderilmelidir.</label>
            </div>

        </div>
        <!-- Button -->
        <div class="form-group">
            <label class="col-md-4 control-label" for=""></label>
            <div class="col-md-4">
                <button type="submit" id="" name="" class="btn btn-success">İade Oluştur</button>
            </div>
        </div>
    </fieldset>
</form>
<br />

<%
    request.setCharacterEncoding("UTF-8");

    if ("POST".equalsIgnoreCase(request.getMethod())) {


		/* Setting ayarlarımızı alıyoruz. İade oluşturmak için gerekli parametreleri alıyoruz.
		   Formdan gelen bilgi ile request ve Setting ayarlarımızı post ediyoruz
		*/

        Settings settings = new Settings();
        CreatePaymentRefundRequest createPaymentRefundRequest = new CreatePaymentRefundRequest();
        createPaymentRefundRequest.amount = request.getParameter("amount");
        createPaymentRefundRequest.refundHash=request.getParameter("refundHash");
        createPaymentRefundRequest.orderId=request.getParameter("orderId");
        createPaymentRefundRequest.clientIp="127.0.0.1";
        CreateRefundInquiryResponse paymentRefundCreateResponse = CreatePaymentRefundRequest.execute(createPaymentRefundRequest, settings); // "Bin sorgulama servisinin başlatıldığı kısım"

        Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
        out.println(" <h1>Sonuç</h1>");
        out.println("<pre>" + g.toJson(paymentRefundCreateResponse) + "</pre>"); //"Bin sorgulama servisi sonucunda oluşan çıktı parametrelerinin ekranda gösterildiği kısımdır."

    }
%>

<jsp:include page="footer.jsp" />
