<%@ page import="com.online.dao.UserDAO" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    UserDAO dao = new UserDAO();
    dao.updateStatus(id, "active");

    response.sendRedirect(request.getContextPath() + "/admin/users");
%>
