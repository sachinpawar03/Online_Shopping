<%@ page import="com.online.utils.DBConnection, java.sql.*" %>

<%
    int oid = Integer.parseInt(request.getParameter("oid"));
    String status = request.getParameter("status");

    try (Connection conn = DBConnection.getConnection()) {
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE orders SET status=? WHERE id=?"
        );

        ps.setString(1, status);
        ps.setInt(2, oid);

        ps.executeUpdate();
    } catch(Exception e) {
        e.printStackTrace();
    }

    // Redirect back to admin page
    response.sendRedirect("manageOrders.jsp");
%>
