
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@page
	contentType="text/html"
	pageEncoding="UTF-8"
%>
<title>PosFix Developer Portal</title>
<link
	href="<%=request.getContextPath()%>/Content/bootstrap.css"
	rel="stylesheet"
	type="text/css"
/>
<link
	href="<%=request.getContextPath()%>/Content/site.css"
	rel="stylesheet"
	type="text/css"
/>
</head>
<body>
	<!-- body tag is closed at footer.jsp -->
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button
					type="button"
					class="navbar-toggle"
					data-toggle="collapse"
					data-target=".navbar-collapse"
				>
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
			</div>
			<div class="navbar-collapse collapse">
				<img
						src="<%=request.getContextPath()%>/Content/posfix-logo.png"
						width="9%"
						height="9%"
				/>
				<ul class="nav navbar-nav">
					<li><a href="one_step_payment.htm">Tek Adımda 3D Ödeme</a></li>
					<li><a href="preauth.htm">Ön Otorizasyon Açma</a></li>
					<li><a href="api_payment.htm">(Non-3d) Ödeme</a></li>
					<li><a href="postauth.htm">Ön Otorizasyon Kapatma</a></li>
					<li><a href="payment_inqury.htm">Ödeme Sorgulama</a></li>
					<li><a href="payment_inqury_with_time.htm">Ödeme Sorgulama(Tarih Aralığında)</a></li>
					<li><a href="payment_refund_inquiry.htm">İade Sorgulama</a></li>
					<li><a href="create_payment_refund.htm">İade Oluşturma</a></li>
					<li><a href="bin_inquiry.htm">Bin Sorgulama</a></li>
					<li><a href="bin_inquiry_v4.htm">Bin Sorgulama (V4)</a></li>
					<li><a href="add_card_to_wallet.htm">Cüzdana Kart Ekle </a></li>
					<li><a href="get_card_from_wallet.htm">Cüzdandaki Kartları Listele</a></li>
					<li><a href="delete_card_from_wallet.htm">Cüzdandan Kart Sil</a></li>
					<li><a href="api_payment_with_wallet.htm">Cüzdandaki Kart (Tek Tıkla) İle Ödeme</a></li>
					<li><a href="create_link_payment.htm" >Link İle Ödeme (Link Gönderim)</a></li>
					<li><a href="link_payment_list.htm">Link İle Ödeme (Link Sorgulama)</a></li>
					<li><a href="link_payment_delete.htm">Link İle Ödeme (Link Silme)</a></li>
					<li><a href="checkout_form_create.htm">Checkout Form Oluşturma</a></li>


				</ul>
			</div>
		</div>
	</div>
	<div class="container body-content">
		<br /> <br/> <br/>
	</div>