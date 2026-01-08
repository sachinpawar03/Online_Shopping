<%@ page import="java.sql.*, com.online.utils.DBConnection" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    try (Connection conn = DBConnection.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id=?");
        ps.setInt(1, id);
        ps.executeUpdate();
    } catch(Exception e){
        e.printStackTrace();
    }

    response.sendRedirect("users.jsp");
%>
