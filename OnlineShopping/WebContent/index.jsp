<%@ page
	import="java.util.*, com.online.dao.ProductDAO, com.online.model.Product"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.online.model.CartItem"%>

<%
ProductDAO dao = new ProductDAO();
List<Product> products = dao.getAll();

String search = request.getParameter("search");
String cat = request.getParameter("category");

List<Product> filtered = new ArrayList<>();

for (Product p : products) {
	boolean match = true;

	if (search != null && !search.trim().isEmpty()) {
		match = p.getName().toLowerCase().contains(search.toLowerCase());
	}

	if (cat != null && !cat.equals("all")) {
		match = match && p.getCategory() != null && p.getCategory().equals(cat);
	}

	if (match)
		filtered.add(p);
}
%>

<!DOCTYPE html>
<html>
<head>
<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background: #f0f2f5;
}

/* NAV BAR */
.navbar {
	width: 100%;
	background: #fff;
	padding: 12px 20px;
	display: flex;
	justify-content: flex-end;
	align-items: center;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	position: sticky;
	top: 0;
	z-index: 1000;
}

.nav-links a {
	margin-left: 20px;
	text-decoration: none;
	color: #0077ee;
	font-size: 18px;
}

.dropdown {
	position: relative;
	display: inline-block;
	margin-left: 20px;
}

.dropbtn {
	cursor: pointer;
	color: #0077ee;
	font-size: 18px;
}

.dropdown-content {
	display: none;
	position: absolute;
	right: 0;
	background: #fff;
	min-width: 160px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
	border-radius: 8px;
	padding: 10px 0;
	z-index: 10;
}

.dropdown-content a {
	display: block;
	padding: 10px 20px;
	text-decoration: none;
	color: #333;
}

.dropdown:hover .dropdown-content {
	display: block;
}

/* CART */
.cart-icon {
	position: relative;
	margin-right: 20px;
	font-size: 22px;
	cursor: pointer;
}

.cart-count {
	position: absolute;
	top: -8px;
	right: -10px;
	background: red;
	color: white;
	border-radius: 50%;
	padding: 2px 7px;
	font-size: 12px;
	font-weight: bold;
}

/* PREMIUM SLIDER */
.slider {
	width: 100%;
	height: 350px;
	margin: 20px auto;
	position: relative;
	overflow: hidden;
	border-radius: 12px;
	background: #fff;
}

.slide {
	width: 100%;
	height: 350px;
	position: absolute;
	opacity: 0;
	transition: opacity 1.5s ease-in-out;
}

.slide img {
	width: 100%;
	height: 100%;
	object-fit: contain; /* No cropping */
	background: white;
}

.active {
	opacity: 1;
}

/* ARROWS */
.arrow {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	font-size: 35px;
	color: white;
	background: rgba(0, 0, 0, 0.4);
	padding: 8px 14px;
	border-radius: 50%;
	cursor: pointer;
	user-select: none;
}

#prev {
	left: 20px;
}

#next {
	right: 20px;
}

/* DOTS */
.dots {
	position: absolute;
	bottom: 12px;
	width: 100%;
	text-align: center;
}

.dots span {
	height: 12px;
	width: 12px;
	margin: 0 4px;
	display: inline-block;
	background: #bbb;
	border-radius: 50%;
	cursor: pointer;
}

.active-dot {
	background: #333;
}

/* FILTERS */
.filters {
	width: 90%;
	margin: 20px auto;
	text-align: center;
}

.filters input, .filters select {
	padding: 10px;
	width: 250px;
	margin-right: 10px;
	border-radius: 8px;
	border: 1px solid #999;
}

.filters button {
	padding: 10px 15px;
	background: black;
	color: white;
	border-radius: 8px;
	border: none;
	cursor: pointer;
}

/* PRODUCT GRID */
.container {
	width: 90%;
	margin: auto;
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 20px;
}

.card {
	background: white;
	padding: 15px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	text-align: center;
	transition: 0.3s;
}

.card:hover {
	transform: scale(1.03);
}

.card img {
	width: 100%;
	height: 180px;
	object-fit: contain;
}

.name {
	font-size: 18px;
	font-weight: bold;
}

.price {
	font-size: 16px;
	color: green;
	font-weight: bold;
}

.btn-row {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 12px;
}

.btn-small {
	background: #007bff;
	color: white;
	border: none;
	padding: 8px 14px;
	border-radius: 6px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 600;
	width: 120px;
}

.btn-small:hover {
	background: #0056b3;
}

.buy {
	background: #0069d9;
}
}
</style>
</head>

<body>

	<%@ page import="com.online.model.User"%>

	<%
User loggedUser = (User) session.getAttribute("user");
Map<Integer, CartItem> cart2 = (Map<Integer, CartItem>) session.getAttribute("cart");
int cartCount2 = (cart2 == null) ? 0 : cart2.size();
%>

	<!-- NAVBAR -->
	<div class="navbar">
		<div class="nav-links">

			<%
			if (loggedUser != null && !"admin@gmail.com".equals(loggedUser.getEmail())) {
			%>
			<a href="cart" class="cart-icon"> 🛒 <span class="cart-count"><%=cartCount2%></span>
			</a>
			<%
			}
			%>

			<%
			if (loggedUser != null && "admin@gmail.com".equals(loggedUser.getEmail())) {
			%>
			<a href="products">View Products</a>
			<%
			}
			%>

			<%
			if (loggedUser == null) {
			%>
			<a href="register.jsp">Register</a> <a href="admin/login.jsp">Login</a>
			<%
			} else {
			%>
			<div class="dropdown">
				<span class="dropbtn">Hi, <%=loggedUser.getName()%> ▼
				</span>
				<div class="dropdown-content">
					<a href="profile.jsp">My Profile</a> <a href="orders.jsp">My
						Orders</a> <a href="#" onclick="confirmLogout()">Logout</a>
				</div>
			</div>
			<%
			}
			%>

		</div>
	</div>

	<!-- TITLE -->
	<h1 style="text-align: center; margin-top: 20px;">Welcome to
		Online Shopping Mart</h1>

	<!-- PREMIUM SLIDER -->
	<div class="slider">
		<div class="slide active">
			<img src="images/slide1.jpeg">
		</div>
		<div class="slide">
			<img src="images/slide2.jpeg">
		</div>
		<div class="slide">
			<img src="images/slide3.jpeg">
		</div>

		<div id="prev" class="arrow">&#10094;</div>
		<div id="next" class="arrow">&#10095;</div>

		<div class="dots">
			<span class="active-dot"></span> <span></span> <span></span>
		</div>
	</div>

	<!-- SEARCH + FILTER BAR -->
	<div class="filters">
		<form method="get">
			<input type="text" name="search" placeholder="Search products..."
				value="<%=search == null ? "" : search%>"> <select
				name="category">
				<option value="all">All Categories</option>
				<option value="Electronics"
					<%="Electronics".equals(cat) ? "selected" : ""%>>Electronics</option>
				<option value="Fashion"
					<%="Fashion".equals(cat) ? "selected" : ""%>>Fashion</option>
				<option value="Accessories"
					<%="Accessories".equals(cat) ? "selected" : ""%>>Accessories</option>
				<option value="Home" <%="Home".equals(cat) ? "selected" : ""%>>Home</option>
			</select>

			<button type="submit">Filter</button>
		</form>
	</div>

	<!-- PRODUCT GRID -->
	<div class="container">
		<%
		for (Product p : filtered) {
		%>
		<div class="card">
			<img src="<%=request.getContextPath()%>/images/<%=p.getImage()%>"
				alt="Product Image">

			<div class="name"><%=p.getName()%></div>
			<div class="price">
				₹
				<%=p.getPrice()%></div>

			<p><%=p.getDescription() == null ? "" : p.getDescription()%></p>

			<div class="btn-row">
				<form action="addToCart" method="post">
					<input type="hidden" name="productId" value="<%=p.getProductId()%>">
					<button type="submit" class="btn-small">Add to Cart</button>
				</form>

				<form action="buyNow" method="post">
					<input type="hidden" name="productId" value="<%=p.getProductId()%>">
					<button type="submit" class="btn-small buy">Buy Now</button>
				</form>
			</div>
		</div>
		<%
}
%>
	</div>

	<script>
function confirmLogout() {
    if (confirm("Are you sure you want to logout?")) {
        window.location.href = "logout";
    }
}

/* SLIDER SCRIPT */
let index = 0;
let slides = document.querySelectorAll('.slide');
let dots = document.querySelectorAll('.dots span');

function showSlide(n) {
    slides.forEach((slide, i) => {
        slide.classList.remove('active');
        dots[i].classList.remove('active-dot');
    });

    slides[n].classList.add('active');
    dots[n].classList.add('active-dot');
}

// Arrow Events
document.getElementById("next").onclick = () => {
    index = (index + 1) % slides.length;
    showSlide(index);
};

document.getElementById("prev").onclick = () => {
    index = (index - 1 + slides.length) % slides.length;
    showSlide(index);
};

// Dot Events
dots.forEach((dot, i) => {
    dot.onclick = () => {
        index = i;
        showSlide(index);
    };
});

// Auto-slide
setInterval(() => {
    index = (index + 1) % slides.length;
    showSlide(index);
}, 5000);


</script>

</body>
</html>
