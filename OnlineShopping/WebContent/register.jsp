<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register | Shopping Mart</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #f0f2f5;
        }

        .container {
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            background: #fff;
            padding: 35px;
            width: 420px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .title {
            font-size: 28px;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .input-group {
            margin-bottom: 15px;
            font-size: 16px;
        }

        .input-group input {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #999;
            font-size: 16px;
            margin-top: 5px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background: black;
            color: white;
            font-size: 17px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
            font-size: 15px;
        }

        .login-link a {
            color: #0077ee;
            text-decoration: none;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        /* ----------------------------
           ⭐ Improved Role Selector
           ---------------------------- */
        .role-container {
            margin-top: 5px;
            font-size: 17px;
            font-weight: 500;
            color: #333;
            cursor: pointer;
        }

        .role-container input {
            display: none; /* hide real radios */
        }

        .admin-option {
            display: none;
            margin-left: 10px;
            padding-top: 5px;
        }

        /* ⭐ Admin shows on hover OR when selected */
        .role-container:hover .admin-option,
        .admin-option.keep-visible {
            display: block !important;
        }

        .selected {
            font-weight: 600;
            color: black;
        }
    </style>

    <% 
        String success = request.getParameter("success");
        String error = request.getParameter("err");
    %>

    <script>
        <% if ("1".equals(success)) { %>
        alert("🎉 Registration Successful! You can now login.");
        <% } %>

        <% if ("failed".equals(error)) { %>
        alert("❌ Registration Failed! Try again.");
        <% } %>
    </script>

</head>
<body>

<div class="container">
    <div class="card">

        <div class="title">Create an Account</div>

        <form action="register" method="post">

            <div class="input-group">
                Name:
                <input type="text" name="name" required>
            </div>

            <div class="input-group">
                Email:
                <input type="email" name="email" required>
            </div>

            <div class="input-group">
                Password:
                <input type="password" name="password" required>
            </div>

            <!-- ⭐ Hover-Based Role Selector -->
            <div class="input-group role-container">

                <!-- CUSTOMER -->
                <label onclick="selectRole('customer', this)">
                    <input type="radio" name="role" value="customer" checked>
                    <span class="role-text selected">Customer</span>
                </label>

                <!-- ADMIN -->
                <label class="admin-option" onclick="selectRole('admin', this)">
                    <input type="radio" name="role" value="admin">
                    <span class="role-text">Admin</span>
                </label>

            </div>

            <button class="btn" type="submit">Register</button>
        </form>

        <div class="login-link">
            Already have an account?
            <a href="admin/login.jsp">Login</a>
        </div>

    </div>
</div>

<script>
function selectRole(role, label) {

    // Remove selected text class
    document.querySelectorAll('.role-text').forEach(e => e.classList.remove('selected'));

    // Add selected class to chosen one
    label.querySelector('.role-text').classList.add('selected');

    // Set radio checked
    document.querySelector("input[value='" + role + "']").checked = true;

    // FIX: keep admin visible when selected
    let admin = document.querySelector(".admin-option");

    if (role === "admin") {
        admin.classList.add("keep-visible");
    } else {
        admin.classList.remove("keep-visible");
    }
}
</script>

</body>
</html>
