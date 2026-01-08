<!DOCTYPE html>
<html>
<head>
<title>Order Successful | Shopping Mart</title>

<style>
    body {
        margin: 0;
        padding: 0;
        background: #f0f2f5;
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .success-box {
        background: #fff;
        padding: 40px;
        border-radius: 15px;
        text-align: center;
        width: 450px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        animation: pop 0.4s ease-out;
    }

    @keyframes pop {
        0%   { transform: scale(0.6); opacity: 0; }
        100% { transform: scale(1); opacity: 1; }
    }

    .tick {
        width: 120px;
        height: 120px;
        margin-bottom: 20px;
        border-radius: 50%;
        border: 6px solid #28a745;
        display: flex;
        justify-content: center;
        align-items: center;
        animation: tickPop 0.6s ease-out;
    }

    @keyframes tickPop {
        0%   { transform: scale(0); }
        60%  { transform: scale(1.3); }
        100% { transform: scale(1); }
    }

    .tick-icon {
        font-size: 70px;
        color: #28a745;
    }

    h1 {
        margin: 15px 0;
        font-size: 26px;
        color: #333;
    }

    p {
        font-size: 16px;
        color: #555;
    }

    .btn {
        display: inline-block;
        margin-top: 20px;
        padding: 12px 25px;
        background: #000;
        color: #fff;
        text-decoration: none;
        border-radius: 8px;
        font-size: 16px;
    }

    .btn:hover {
        opacity: 0.9;
    }

</style>

</head>

<body>

<div class="success-box">

    <!-- CIRCLE WITH TICK -->
    <div class="tick">
        <div class="tick-icon">&#10004;</div>
    </div>

    <h1>Order Successful!</h1>

    <p>Your order has been placed successfully.<br>
       Thank you for shopping with us!</p>

    <a href="index.jsp" class="btn">Continue Shopping</a>

</div>

</body>
</html>
