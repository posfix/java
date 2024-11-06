<%@page import="posfix.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="posfix.core.response.ApiPaymentResponse"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.ArrayList"%>
<%@page import="posfix.core.request.ApiPaymentRequest"%>
<%@page import="posfix.core.Settings"%>
<%@ page import="posfix.core.request.OneStepPaymentRequest" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="posfix.core.entity.*" %>
<%@ page import="java.util.List" %>

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
      >Tek Adımda 3D Ödeme</button>
    </div>
  </div>
</form>

<%
  request.setCharacterEncoding("UTF-8");
	/* 3D secure Tek Adımlı ödeme işlemleri için gerekli olan parametrelerin doldurulduğu kısımdır. setting ayarlarımızı alıp, OneStepPaymentRequest alanlarının formdan gelen verilere göre doldurup post edildiği kısımdır.
	  Post işlemi sonucunda oluşan sonucu ekranda gösteriyoruz.
	*/

  if ("POST".equalsIgnoreCase(request.getMethod())) {

    Settings settings = new Settings();
    String SIMPLE_DATE_FORMAT = "yyyy-MM-dd";
    String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";

    OneStepPaymentRequest dto = new OneStepPaymentRequest();
    UUID uuid = UUID.randomUUID();

    dto.setOrderId(uuid.toString());
    dto.setAmount("100");
    dto.setCardOwnerName(request.getParameter("nameSurname"));
    dto.setCardNumber(request.getParameter("cardNumber"));
    dto.setCardExpireMonth(request.getParameter("month"));
    dto.setCardExpireYear(request.getParameter("year"));
    dto.setCardCvc(request.getParameter("cvc"));
    dto.setInstallment(request.getParameter("installment"));
    dto.setLanguage("tr-TR");
    dto.setMode(settings.mode);

    Purchaser purchaser = new Purchaser();
    purchaser.name ="Ahmet";
    purchaser.surname = "Veli";
    purchaser.email = "ahmet@veli.com";
    purchaser.birthDate = new SimpleDateFormat(SIMPLE_DATE_FORMAT).format(new Date());
    purchaser.gsmNumber = "5400343434";
    purchaser.clientIp ="192.168.0.54";
    purchaser.tcCertificate = "99999999999";

    PurchaserAddress invoiceAddress = new PurchaserAddress();
    invoiceAddress.name = "Ahmet";
    invoiceAddress.surname = "Veli";
    invoiceAddress.address = "Mevlüt Pehlivan Mah. PosFix Plaza Şişli";
    invoiceAddress.zipcode = "34782";
    invoiceAddress.city = "34";
    invoiceAddress.country = "TR";
    invoiceAddress.tcCertificate = "1234567890";
    invoiceAddress.taxNumber = "9999999999";
    invoiceAddress.taxOffice="Kozyatağı";
    invoiceAddress.companyName = "PosFix";
    invoiceAddress.phoneNumber="2122222222";

    PurchaserAddress shippingAddress = new PurchaserAddress();
    shippingAddress.name ="Ahmet";
    shippingAddress.surname = "Veli";
    shippingAddress.address = "Mevlüt Pehlivan Mah. PosFix Plaza Şişli";
    shippingAddress.zipcode = "34782";
    shippingAddress.city ="34";
    shippingAddress.country = "TR";
    shippingAddress.phoneNumber = "2122222222";

    purchaser.invoiceAddress=invoiceAddress;
    purchaser.shippingAddress=shippingAddress;

    dto.setPurchaser(purchaser);
    String url = request.getRequestURL().toString();
    String baseURL = url.substring(0, url.length() - request.getRequestURI().length())
            + request.getContextPath()
            + "/";

    dto.setSuccessUrl("https://api.posfix.com.tr/rest/payment/threed/test/result");
    dto.setFailureUrl("https://api.posfix.com.tr/rest/payment/threed/test/result");
    dto.setEcho("Echo");
    dto.setVersion("1.0");
    dto.setDeviceUUId("android-20013fea6bcc820c");
    dto.setTransactionDate(new SimpleDateFormat(DATE_FORMAT).format(new Date()));
    dto.setUserId("");
    dto.setCardId("");
    dto.setVendorId("");
    dto.setCardAlias("mycardOneStep");

    List<Product> products = new ArrayList<>();
    Product p = new Product();
    p.price="5000";
    p.code="TLF0001";
    p.title="Telefon";
    p.quantity="1";
    products.add(p);
    Product p1 = new Product();
    p1.price="5000";
    p1.code="BLG0001";
    p1.title="Bilgisayar";
    p1.quantity="1";
    products.add(p1);

    dto.setProducts(products);


    String form = dto.execute(dto, settings); // "3D secure Tek adımlı ödeme yapma servis çağrısının yapıldığı kısımdır."
    out.println(form);
     //"3D secure Tek adımlı ödeme yapma servis çağırısı sonucunda servis çıktı parametrelerinin ekranda gösterildiği kısımdır."
  }
%>

<jsp:include page="footer.jsp" />
