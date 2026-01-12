<!DOCTYPE html>
<html>
<head>
<title>Delivery Address</title>
<style>
.container {
    width: 400px;
    margin: 50px auto;
    background: #fff;
    padding: 20px;
    border-radius: 10px;
}
input, textarea {
    width: 100%;
    margin-bottom: 15px;
    padding: 10px;
}
button {
    width: 100%;
    padding: 12px;
    background: black;
    color: white;
    border: none;
}
</style>
</head>

<body>
<div class="container">
<h2>Delivery Address</h2>

<form action="saveAddress" method="post">

    Full Name:
    <input type="text" name="fullName" required>

    Address:
    <textarea name="address" required></textarea>

    City:
    <input type="text" name="city" required>

    Pincode:
    <input type="text" name="pincode" pattern="\d{6}" required>

    Phone:
    <input type="text" name="phone" pattern="\d{10}" required>

    <button type="submit">Continue to Payment</button>

</form>
</div>
</body>
</html>
