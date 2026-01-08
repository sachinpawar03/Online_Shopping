<%@page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head><title>Register</title><link rel="stylesheet" href="css/style.css"></head>
<body>
<h2>Register</h2>
<form action="register" method="post">
  Name: <input type="text" name="name" required><br>
  Email: <input type="email" name="email" required><br>
  Password: <input type="password" name="password" required><br>
  <button type="submit">Register</button>
</form>
<p><a href="login.jsp">Already have an account? Login</a></p>
</body>
</html>
