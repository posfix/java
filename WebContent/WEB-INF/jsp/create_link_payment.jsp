<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="posfix.core.Settings"%>
<%@page import="posfix.core.request.*"%>
<%@ page import="posfix.core.response.LinkPaymentCreateResponse" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>


<jsp:include page="layout.jsp" />



<%@page contentType="text/html" pageEncoding="UTF-8"%>

<form
        method="post"
class="form-horizontal">
<fieldset>
    <!-- Form Name -->
    <legend>Link İle Ödeme (Link Gönderim)</legend>
    <!-- Text input-->
    <div class="form-group">
        <label class="col-md-4 control-label" >Müşteri Adı * :</label>
        <div class="col-md-4">
            <input name="name" type="text" value="Müşteri Ad" class="form-control input-md" required="required">

        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label" >Müşteri Soyadı * :</label>
        <div class="col-md-4">
            <input name="surname" type="text" value="Müşteri Soyad" class="form-control input-md" required="required">

        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label">Müşteri T.C. kimlik Numarası:</label>
        <div class="col-md-4">
            <input name="tcCertificate" type="text" value="" class="form-control input-md">

        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label" >Müşteri vergi Numarası: </label>
        <div class="col-md-4">
            <input name="taxNumber" type="text" value="" class="form-control input-md">

        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label" for="">Müşteri Eposta * : </label>
        <div class="col-md-4">
            <input name="email" type="text" value="mail@example.com" class="form-control input-md" required="required">

        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label" for="">Müşteri Cep Telefonu * : </label>
        <div class="col-md-4">
            <input name="gsm" type="text" value="5881231212" class="form-control input-md" required="required">

        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label" for="">Tahsil Edilecek Tutar (TL) * : </label>
        <div class="col-md-4">
            <input name="amount" type="text" value="1000" class="form-control input-md" required="">
            <label style="font-weight:normal; font-size:small">*Sipariş tutarı kuruş ayracı olmadan gönderilmelidir. Örneğin; 1 TL 100, 12 1200, 130 13000, 1.05 105, 1.2 120 olarak gönderilmelidir.</label>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label" for="">3D Secure * : </label>
        <div class="col-md-4">
            <select name="threeD" class="form-control">
                <option value="true">Evet</option>
                <option value="false">Hayır</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label" for="">Link Geçerlilik Süresi (Gün/Ay/Yıl) * : </label>
        <div class="col-md-4 form-inline">
            <input name="day" type="text" value="15" class="form-control input-md" style="width: 80px; text-align: center;" maxlength="2" required="required">
            <input name="month" type="text" value="01" class="form-control input-md" style="width: 80px; text-align: center;" maxlength="2" required="required">
            <input name="year" type="text" value="2022" class="form-control input-md" style="width: 112px; text-align: center;" maxlength="4" required="required">

        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4 control-label" for="">Ödemenin Yapılabileceği Taksitlerin Listesi: </label>
        <div class="col-md-4">
            <select class="form-control" name="installmentList">
                <option value="2">2</option>
                <option value="3">3</option>

            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4 control-label" for="">Müşteriye Bilgilendirme Mailli Gönder * : </label>
        <div class="col-md-4">
            <select name="sendEmail" class="form-control">
                <option value="true">Evet</option>
                <option value="false">Hayır</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-4 control-label" for="">Komisyon Kime Yansıtılacak : </label>
        <div class="col-md-4">
            <select name="commissionType" class="form-control">
                <option value="1">Satıcı (Varsayılan)</option>
                <option value="2">Müşteri</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" class="btn btn-success">Ödeme Linki Oluştur</button>
        </div>
    </div>
</fieldset>
</form>

<br />

<%
    request.setCharacterEncoding("UTF-8");

    if ("POST".equalsIgnoreCase(request.getMethod())) {


		/* Setting ayarlarımızı alıyoruz. Link oluşturma servisinde gerekli parametreleri alıyoruz.
		   Formdan gelen bilgi ile requestleri ve Setting ayarlarımızı post ediyoruz
		*/

        Settings settings = new Settings();

        LinkPaymentCreateRequest linkPaymentCreateRequest = new LinkPaymentCreateRequest();
        linkPaymentCreateRequest.name = request.getParameter("name");
        linkPaymentCreateRequest.surname = request.getParameter("surname");
        linkPaymentCreateRequest.tcCertificate=request.getParameter("tcCertificate");
        linkPaymentCreateRequest.taxNumber = request.getParameter("taxNumber");
        linkPaymentCreateRequest.email= request.getParameter("email");
        linkPaymentCreateRequest.gsm=request.getParameter("gsm");
        linkPaymentCreateRequest.amount =request.getParameter("amount");
        linkPaymentCreateRequest.threeD =request.getParameter("threeD");
        linkPaymentCreateRequest.expireDate=request.getParameter("year")+"-"+request.getParameter("month")+"-"+request.getParameter("day") +" 23:59:59";
        List<Integer> installmentList = new ArrayList<>();
        installmentList.add(Integer.parseInt(request.getParameter("installmentList")));
        linkPaymentCreateRequest.installmentList=installmentList;
        linkPaymentCreateRequest.sendEmail=request.getParameter("sendEmail");
        linkPaymentCreateRequest.commissionType=request.getParameter("commissionType");
        linkPaymentCreateRequest.clientIp ="127.0.0.1";

        LinkPaymentCreateResponse linkPaymentCreateResponse = LinkPaymentCreateRequest.execute(linkPaymentCreateRequest,settings);
        Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
        out.println("  <h1>Sonuç</h1>");
        out.println("<pre>" + g.toJson(linkPaymentCreateResponse) + "</pre>");



    }
%>

<jsp:include page="footer.jsp" />
