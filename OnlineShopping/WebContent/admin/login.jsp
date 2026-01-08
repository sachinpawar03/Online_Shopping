<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login | Shopping Mart</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            background: #f2f2f2;
            font-family: Arial, sans-serif;
        }

        /* ===== HEADER (new centered logo) ===== */
        .header {
            width: 100%;
            background: white;
            padding: 15px 0;
            box-shadow: 0px 1px 3px rgba(0,0,0,0.12);
            text-align: center;
            position: sticky;
            top: 0;
            z-index: 99;
        }

        .header-text {
            font-size: 28px;
            font-weight: bold;
            color: #111;
        }

        /* ===== Login Box ===== */
        .login-box {
            width: 360px;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            border: 1px solid #d5d5d5;
        }

        h2 {
            font-weight: normal;
            margin-bottom: 15px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 4px;
            border: 1px solid #a6a6a6;
            font-size: 15px;
        }

        .btn {
            width: 100%;
            background: #f0c14b;
            border-color: #a88734 #9c7e31 #846a29;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #a88734;
            cursor: pointer;
            font-size: 16px;
        }

        .btn:hover {
            background: #e2b33c;
        }

        .register {
            text-align: center;
            margin-top: 12px;
            font-size: 14px;
        }

        .register a {
            color: #0066c0;
            text-decoration: none;
        }

        .register a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<!-- Header -->
<div class="header">
    <div class="header-text">Shopping Mart</div>
</div>

<!-- Login Card -->
<div class="login-box">

    <h2>Sign-In</h2>

    <form action="${pageContext.request.contextPath}/login" method="post">

        <label>Email or mobile phone number</label>
        <input type="text" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <!-- 🧹 Removed radio buttons (Auto-detect role in backend) -->

        <button type="submit" class="btn">Continue</button>
    </form>

    <div class="register">
        New to Shopping Mart? <a href="register.jsp">Create your account</a>
    </div>

</div>

</body>
</html>
