<%@ page import="com.online.dao.OrderDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String orderIdStr = request.getParameter("oid");
    String status = request.getParameter("status");

    if (orderIdStr == null || status == null || orderIdStr.isEmpty() || status.isEmpty()) {
        response.sendRedirect("admin_orders.jsp?error=1");
        return;
    }

    int oid = 0;
    try {
        oid = Integer.parseInt(orderIdStr);
    } catch (NumberFormatException e) {
        response.sendRedirect("admin_orders.jsp?error=2");
        return;
    }
    
    OrderDAO dao = new OrderDAO();
    dao.updateOrderStatus(oid, status);

    // ✅ CORRECT redirect (same admin folder)
    response.sendRedirect("admin_orders.jsp?updated=1");
%>
