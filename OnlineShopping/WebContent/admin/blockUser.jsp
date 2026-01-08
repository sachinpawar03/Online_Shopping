<%@ page import="com.online.dao.UserDAO" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    UserDAO dao = new UserDAO();
    dao.updateStatus(id, "blocked");

    response.sendRedirect(request.getContextPath() + "/admin/users");
%>
