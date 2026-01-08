<%@ page import="com.online.dao.OrderDAO" %>
<a href="admin/updateOrderStatus.jsp?oid=...&status=...">

<%
    String orderIdStr = request.getParameter("oid");
    String status = request.getParameter("status");

    if(orderIdStr == null || status == null) {
        response.sendRedirect("orders.jsp?error=1");
        return;
    }

    int oid = Integer.parseInt(orderIdStr);

    OrderDAO dao = new OrderDAO();
    dao.updateOrderStatus(oid, status);

    response.sendRedirect("orders.jsp?updated=1");
%>
