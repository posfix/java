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
<%@ page import="posfix.core.response.LinkPaymentDeleteResponse" %>


<jsp:include page="layout.jsp" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<form
        method="post"
        class="form-horizontal">

    <fieldset>

        <!-- Form Name -->
        <legend>Link İle Ödeme (Link Silme)</legend>

        <div class="form-group">
            <label class="col-md-4 control-label" for="">Ödeme Linki ID : </label>
            <div class="col-md-4">
                <input type="text" name="linkId" class="form-control input-md" required="">

            </div>
        </div>

        <!-- Button -->
        <div class="form-group">
            <label class="col-md-4 control-label" for=""></label>
            <div class="col-md-4">
                <button type="submit" class="btn btn-success">Ödeme Linkini Sil</button>
            </div>
        </div>

    </fieldset>
</form>

<br />

<%
    request.setCharacterEncoding("UTF-8");

    if ("POST".equalsIgnoreCase(request.getMethod())) {


		/* Setting ayarlarımızı alıyoruz.
		   Formdan gelen linkId ile clientIp ve Setting ayarlarımızı post ediyoruz
		*/

        Settings settings = new Settings();

        LinkPaymentDeleteRequest linkPaymentDeleteRequest = new LinkPaymentDeleteRequest();
        linkPaymentDeleteRequest.linkId = request.getParameter("linkId");
        linkPaymentDeleteRequest.clientIp = "127.0.0.1";

        LinkPaymentDeleteResponse linkPaymentDeleteResponse = LinkPaymentDeleteRequest.execute(linkPaymentDeleteRequest,settings);
        Gson g = new GsonBuilder().disableHtmlEscaping().setPrettyPrinting().create();
        out.println("  <h1>Sonuç</h1>");
        out.println("<pre>" + g.toJson(linkPaymentDeleteResponse) + "</pre>");

    }
%>

<jsp:include page="footer.jsp" />
