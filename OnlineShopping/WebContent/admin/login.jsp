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
            background: linear-gradient(135deg, #4e73df, #224abe);
            height: 100vh;

            /* ✅ center everything vertically */
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* ✅ Wrapper to hold alert + login box */
        .wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* 🔥 Stylish Alert Box */
        .alert-box {
            background-color: #ffe6e6;
            color: #d8000c;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-weight: 500;
            text-align: center;
            width: 100%;
            max-width: 350px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        /* LOGIN CARD */
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

<div class="wrapper">

    <!-- ✅ ALERT MESSAGE (CENTERED ABOVE BOX) -->
    <%
    String msg = request.getParameter("msg");
    if (msg != null) {
    %>
        <div class="alert-box">
            <%= msg %>
        </div>
    <%
    }
    %>

    <!-- LOGIN BOX -->
    <div class="login-box">

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

</div>

<!-- ✅ Auto hide alert -->
<script>
setTimeout(() => {
    let alertBox = document.querySelector('.alert-box');
    if (alertBox) {
        alertBox.style.display = 'none';
    }
}, 3000);
</script>

</body>
</html>