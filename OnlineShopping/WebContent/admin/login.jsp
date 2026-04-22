<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login | Shopping Mart</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;

            /* 🔥 BLUE GRADIENT BACKGROUND */
            background: linear-gradient(135deg, #4e73df, #224abe);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* 🔥 LOGIN CARD (CENTERED) */
        .login-box {
            width: 350px;
            background: #ffffff;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0px 10px 30px rgba(0,0,0,0.2);
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        label {
            display: block;
            text-align: left;
            margin-top: 10px;
            font-size: 14px;
            color: #555;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-top: 5px;
            border-radius: 8px;
            border: none;
            background: #f1f1f1;
            font-size: 14px;
        }

        input:focus {
            outline: none;
            background: #e9ecef;
        }

        /* 🔥 BUTTON STYLE */
        .btn {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            border-radius: 8px;
            border: none;
            background: #1e73ff;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .btn:hover {
            background: #155edb;
        }

        .extra {
            margin-top: 10px;
            font-size: 13px;
            color: #555;
        }

        .extra a {
            color: #1e73ff;
            text-decoration: none;
        }

        .extra a:hover {
            text-decoration: underline;
        }

        /* OPTIONAL LOGO */
        .logo {
            width: 40px;
            height: 40px;
            background: #222;
            border-radius: 50%;
            margin: 0 auto 15px;
        }
    </style>
</head>

<body>

<div class="login-box">

    <!-- 🔥 Small top logo -->
    <div class="logo"></div>

    <h2>Login</h2>

    <form action="${pageContext.request.contextPath}/admin/login" method="post">

        <label>Email</label>
        <input type="text" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button type="submit" class="btn">SIGN IN</button>

    </form>

    <div class="extra">
        <a href="#">Forgot Password?</a><br><br>
        Don’t have an account?
        <a href="${pageContext.request.contextPath}/register.jsp">Sign up</a>
    </div>

</div>

</body>
</html>