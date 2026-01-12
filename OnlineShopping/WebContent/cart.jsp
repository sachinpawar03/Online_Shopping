<%@ page import="java.util.*, com.online.model.CartItem"%>
<%@ page import="com.online.model.Product"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Your Cart</title>

<style>
body {
	background: #f0f2f5;
	margin: 0;
	font-family: Arial, sans-serif;
}

.cart-container {
	width: 90%;
	max-width: 1100px;
	margin: 30px auto;
}

.cart-box, .payment-box {
	background: #fff;
	padding: 20px;
	border-radius: 12px;
	margin-bottom: 20px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

h2, h3 {
	margin-top: 0;
	text-align: center;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
}

table th {
	background: #222;
	color: white;
	padding: 12px;
	font-size: 15px;
}

table td {
	padding: 12px;
	border-bottom: 1px solid #ddd;
	text-align: center;
	background: white;
}

.total-row {
	font-weight: bold;
	font-size: 17px;
}

input[type=text], input[type=password], input[type=month] {
	width: 100%;
	padding: 10px;
	border-radius: 8px;
	border: 1px solid #aaa;
	margin-bottom: 15px;
}

button {
	width: 100%;
	padding: 12px;
	background: black;
	color: white;
	border: none;
	font-size: 18px;
	border-radius: 8px;
	cursor: pointer;
}

.remove-btn {
	background-color: #ff3b3b;
	color: white;
	border: none;
	padding: 6px 14px;
	border-radius: 6px;
}
</style>
</head>

<body>

<div class="cart-container">

<h2>Your Shopping Cart</h2>

<%
Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
if (cart == null || cart.isEmpty()) {
%>

<div class="cart-box">
	<h3>Your cart is empty.</h3>
</div>

<%
} else {
double grandTotal = 0;
%>

<div class="cart-box">
<table>
<tr>
	<th>Image</th>
	<th>Name</th>
	<th>Price</th>
	<th>Qty</th>
	<th>Total</th>
	<th>Remove</th>
</tr>

<%
for (CartItem item : cart.values()) {
	Product p = item.getProduct();
	int qty = item.getQuantity();
	double total = p.getPrice() * qty;
	grandTotal += total;
%>

<tr>
	<td><img src="<%=request.getContextPath()%>/images/<%=p.getImage()%>" width="80"></td>
	<td><%=p.getName()%></td>
	<td>₹<%=p.getPrice()%></td>
	<td><%=qty%></td>
	<td>₹<%=total%></td>
	<td>
		<form action="<%=request.getContextPath()%>/removeFromCart" method="post">
			<input type="hidden" name="productId" value="<%=p.getProductId()%>">
			<button class="remove-btn">Remove</button>
		</form>
	</td>
</tr>

<% } %>

<tr class="total-row">
	<td colspan="4">Grand Total</td>
	<td>₹<%=grandTotal%></td>
	<td></td>
</tr>

</table>
</div>

<!-- PAYMENT BOX -->
<div class="payment-box">

<form action="<%=request.getContextPath()%>/checkout"
      method="post"
      onsubmit="return validatePayment();">

<h3>Payment Options</h3>

<label>
<input type="radio" name="paymentMode" value="CARD" checked
       onclick="showPayment('CARD')">
Pay with Card
</label><br><br>

<label>
<input type="radio" name="paymentMode" value="UPI"
       onclick="showPayment('UPI')">
Pay with UPI
</label>

<hr>

<!-- CARD -->
<div id="cardSection">
	Card Holder Name:
	<input type="text" name="cardHolder" id="cardHolder">

	Card Number:
	<input type="text" name="cardNumber" id="cardNumber">

	Expiry Date:
	<input type="month" name="expiry" id="expiry">

	CVV:
	<input type="password" name="cvv" id="cvv">
</div>

<!-- UPI -->
<div id="upiSection" style="display:none;">
	UPI ID:
	<input type="text" name="upiId" id="upiId">
</div>

<button type="submit">Pay Now</button>

</form>
</div>

<% } %>

</div>

<script>
function showPayment(type) {
	if (type === 'CARD') {
		cardSection.style.display = "block";
		upiSection.style.display = "none";
	} else {
		cardSection.style.display = "none";
		upiSection.style.display = "block";
	}
}

function validatePayment() {
	const mode = document.querySelector('input[name="paymentMode"]:checked').value;

	if (mode === "CARD") {
		if (!cardHolder.value ||
			!/^\d{16}$/.test(cardNumber.value) ||
			!expiry.value ||
			!/^\d{3}$/.test(cvv.value)) {

			alert("Please enter valid card details");
			return false;
		}
	}

	if (mode === "UPI") {
		if (!/^[a-zA-Z0-9._-]+@[a-zA-Z]+$/.test(upiId.value)) {
			alert("Invalid UPI ID");
			return false;
		}
	}

	return true;
}
</script>

</body>
</html>
