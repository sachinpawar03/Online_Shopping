<%@ page import="java.util.*, com.online.model.CartItem"%>
<%@ page import="com.online.model.Product"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.online.model.CartItem" %>

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
	background: #f9f9f9;
	font-weight: bold;
	font-size: 17px;
}

input[type=text], input[type=password], input[type=month] {
	width: 100%;
	padding: 10px;
	border-radius: 8px;
	border: 1px solid #aaa;
	margin-top: 5px;
	margin-bottom: 15px;
}

input[type=radio] {
	margin-right: 5px;
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
	margin-top: 20px;
}

button:hover {
	opacity: 0.9;
}

.payment-title {
	margin-bottom: 8px;
	font-size: 18px;
}

/* 🔴 REMOVE BUTTON */
.remove-btn {
	background-color: #ff3b3b;
	color: white;
	border: none;
	padding: 6px 14px;
	font-size: 14px;
	border-radius: 6px;
	cursor: pointer;
}

.remove-btn:hover {
	background-color: #cc0000;
}
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
				double grandTotal = 0;
				for (CartItem item : cart.values()) {
					Product p = item.getProduct();
					int qty = item.getQuantity();
					double total = p.getPrice() * qty;
					grandTotal += total;
				%>

				<tr>
					<td><img
						src="<%=request.getContextPath()%>/images/<%=p.getImage()%>"
						width="80" height="80"></td>
					<td><%=p.getName()%></td>
					<td>₹<%=p.getPrice()%></td>
					<td><%=qty%></td>
					<td>₹<%=total%></td>

					<!-- 🔴 REMOVE BUTTON HERE -->
					<td>
						<form action="removeFromCart" method="post">
							<input type="hidden" name="productId"
								value="<%=p.getProductId()%>">
							<button type="submit" class="remove-btn">Remove</button>
						</form>

					</td>
				</tr>

				<%
				}
				%>

				<tr class="total-row">
					<td colspan="4" align="right">Grand Total:</td>
					<td>₹<%=grandTotal%></td>
					<td></td>
				</tr>

			</table>
		</div>


		<!-- PAYMENT BOX -->
		<div class="payment-box">
			<form action="placeOrder" method="post">

				<input type="hidden" name="userId"
					value="<%=session.getAttribute("userId")%>"> <input
					type="hidden" name="total" value="<%=grandTotal%>">

				<h3 class="payment-title">Payment Options</h3>

				<label> <input type="radio" name="paymentOption"
					value="card" checked onclick="showPayment('card')"> Pay
					with Card
				</label> <br> <br> <label> <input type="radio"
					name="paymentOption" value="upi" onclick="showPayment('upi')">
					Pay with UPI
				</label>

				<hr>

				<!-- CARD SECTION -->
				<div id="cardSection">
					<h4>Card Payment Details</h4>

					Card Number: <input type="text" name="cardNumber"> Card
					Holder Name: <input type="text" name="cardName"> Expiry
					Date: <input type="month" name="expiry"> CVV: <input
						type="password" name="cvv">
				</div>

				<!-- UPI SECTION -->
				<div id="upiSection" style="display: none;">
					<h4>UPI Payment</h4>

					Enter UPI ID: <input type="text" name="upiId"
						placeholder="name@upi">

					<p>You will receive a payment request on your UPI app.</p>
				</div>

				<button type="submit">Pay Now</button>

			</form>
		</div>

		<%
		}
		%>

	</div>


	<script>
		function showPayment(type) {
			if (type === 'card') {
				document.getElementById('cardSection').style.display = 'block';
				document.getElementById('upiSection').style.display = 'none';
			} else {
				document.getElementById('cardSection').style.display = 'none';
				document.getElementById('upiSection').style.display = 'block';
			}
		}
	</script>

</body>
</html>
