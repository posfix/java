<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="posfix.core.response.BinNumberInquiryResponse"%>
<%@page import="posfix.core.request.BinNumberInquiryRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="posfix.core.Settings"%>
<%@page import="posfix.core.request.*"%>
<%@ page import="posfix.core.response.LinkPaymentCreateResponse" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.springframework.util.StringUtils" %>
<%@ page import="posfix.core.response.LinkPaymentListResponse" %>


<jsp:include page="layout.jsp" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<form
        method="post"
        class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend>Link İle Ödeme (Link Sorgulama)</legend>
        <!-- Text input-->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Müşteri Eposta : </label>
            <div class="col-md-4">
                <input type="text" name="email" value="mail@example.com" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Müşteri Cep Telefonu * : </label>
            <div class="col-md-4">
                <input name="gsm" type="text" value="" class="form-control input-md" >

            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Link Durumu : </label>
            <div class="col-md-4">
                <select name="linkState" class="form-control">
                    <option value="-1">Seçiniz</option>
                    <option value="0">Link İsteği Alındı</option>
                    <option value="1">Link URL’i yaratıldı</option>
                    <option value="2">Link Gönderildi, Ödeme Bekleniyor</option>
                    <option value="3">Link ile Ödeme Başarılı</option>
                    <option value="98">Link Zaman Aşımına Uğradı</option>
                    <option value="99">Link Silindi</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Link Oluşturma Alanına Ait Arama Başlangıç Tarihi : </label>
            <div class="col-md-4 form-inline">
                <input type="text" name="startDay" value="01" class="form-control input-md" style="width: 80px; text-align: center;" maxlength="2">
                <input type="text" name="startMonth" value="11" class="form-control input-md" style="width: 80px; text-align: center;" maxlength="2">
                <input type="text" name="startYear" value="2021" class="form-control input-md" style="width: 112px; text-align: center;" maxlength="4">

            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Link Oluşturma Alanına Ait Arama Bitiş Tarihi : </label>
            <div class="col-md-4 form-inline">
                <input type="text" name="endDay" value="01" class="form-control input-md" style="width: 80px; text-align: center;" maxlength="2">
                <input type="text" name="endMonth" value="01" class="form-control input-md" style="width: 80px; text-align: center;" maxlength="2">
                <input type="text" name="endYear" value="2022" class="form-control input-md" style="width: 112px; text-align: center;" maxlength="4">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Ödeme Linki ID : </label>
            <div class="col-md-4">
                <input type="text" name="linkId" class="form-control input-md">

            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">Toplam Gösterilebilecek Sayfa Sayısı * : </label>
            <div class="col-md-4">
                <select name="pageSize" class="form-control">
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-md-4 control-label" for="">Gösterilecek Sayfa Numarası * : </label>
            <div class="col-md-4">
                <input type="text" name="pageIndex" value="1" class="form-control input-md" required="">
            </div>
        </div>
        <!-- Button -->
        <div class="form-group">
            <label class="col-md-4 control-label" for=""></label>
            <div class="col-md-4">
                <button type="submit" class="btn btn-success">Ödeme Linklerini Listele</button>
            </div>
        </div>
    </fieldset>
</form>

<br />

<%
    request.setCharacterEncoding("UTF-8");

    if ("POST".equalsIgnoreCase(request.getMethod())) {


		/* Setting ayarlarımızı alıyoruz. Link oluşturma Link Listeleme servisinde gerekli parametreleri alıyoruz.
		   Formdan gelen bilgi ile requestleri ve Setting ayarlarımızı post ediyoruz
		*/

        Settings settings = new Settings();

        LinkPaymentListRequest linkPaymentListRequest = new LinkPaymentListRequest();

        linkPaymentListRequest.email= request.getParameter("email");
        linkPaymentListRequest.gsm=request.getParameter("gsm");
        linkPaymentListRequest.linkState = !request.getParameter("linkState").equals("-1")  ? request.getParameter("linkState") : null;
        if (!StringUtils.isEmpty(request.getParameter("startDay")) && request.getParameter("startDay") != null) { // Eğer başlangıç tarihi girildiyse, bitiş tarihi de girilmelidir.
            linkPaymentListRequest.startDate = request.getParameter("startYear") + "-" + request.getParameter("startMonth") + "-" + request.getParameter("startDay") + " 00:00:00";
            linkPaymentListRequest.endDate = request.getParameter("endYear") + "-" +request.getParameter("endMonth")  + "-" + request.getParameter("endDay") + " 23:59:59";
        } else
        {
            linkPaymentListRequest.startDate = null;
            linkPaymentListRequest.endDate = null;
        }
        if(request.getParameter("linkId") !=null && request.getParameter("linkId") != "" ){
            linkPaymentListRequest.linkId =   request.getParameter("linkId");
        }
        linkPaymentListRequest.pageSize = request.getParameter("pageSize");
        linkPaymentListRequest.pageIndex = request.getParameter("pageIndex");
        linkPaymentListRequest.clientIp = "127.0.0.1";

        LinkPaymentListResponse linkPaymentListResponse = LinkPaymentListRequest.execute(linkPaymentListRequest,settings);
        Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
        out.println("  <h1>Sonuç</h1>");
        out.println("<pre>" + g.toJson(linkPaymentListResponse) + "</pre>");



    }
%>

<jsp:include page="footer.jsp" />
