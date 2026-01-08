<%@ page import="java.util.*, com.online.model.User"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin - Users</title>

<style>
body {
	font-family: Arial, sans-serif;
	background: #f5f5f5;
	margin: 0;
	padding: 0;
}

h2 {
	text-align: center;
	margin-top: 30px;
}

table {
	width: 80%;
	margin: 20px auto;
	border-collapse: collapse;
	background: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

th, td {
	border: 1px solid #ddd;
	padding: 12px;
	text-align: left;
}

th {
	background: #333;
	color: #fff;
}

tr:hover {
	background: #f1f1f1;
}

.no-data {
	text-align: center;
	padding: 20px;
	font-size: 18px;
}
</style>
</head>

<body>

<h2>All Registered Users</h2>

<table>
	<thead>
		<tr>
			<th>ID</th>
			<th>User Name</th>
			<th>Email</th>
			<th>Role</th>
			<th>Action</th> <!-- NEW -->
		</tr>
	</thead>

	<tbody>
	<%
	List<User> users = (List<User>) request.getAttribute("usersList");

	if (users != null && !users.isEmpty()) {

		for (User u : users) {
	%>

		<tr>
			<td><%= u.getUserId() %></td>
			<td><%= u.getName() %></td>
			<td><%= u.getEmail() %></td>
			<td><%= u.getRole() %></td>

			<!-- Block / Unblock Button -->
			<td>
			<%
			if (u.getStatus() != null && u.getStatus().equals("active")) {
			%>
				<a href="blockUser.jsp?id=<%= u.getUserId() %>" style="color:red;">Block</a>
			<%
				} else {
			%>
				<a href="unblockUser.jsp?id=<%= u.getUserId() %>" style="color:green;">Unblock</a>
			<%
				}
			%>
			</td>
		</tr>

	<%
		}

	} else {
	%>

		<tr>
			<td colspan="5" class="no-data">No users found.</td>
		</tr>

	<%
	}
	%>
	</tbody>

</table>

</body>
</html>
