<%@ page import="java.sql.*" %>

<%
    String paymentType = request.getParameter("paymentType");

    // Card details
    String cardNumber = request.getParameter("cardNumber");
    String cardName   = request.getParameter("cardName");
    String expiry     = request.getParameter("expiry");
    String cvv        = request.getParameter("cvv");

    // SIMPLE validation
    if ("CARD".equals(paymentType)) {
        if (cardNumber == null || cardNumber.length() != 16) {
            out.println("Invalid Card Number");
            return;
        }
    }

  
    int orderId = (int) (System.currentTimeMillis() % 100000); 
    // (Replace this with DB generated ID later)

    // FIX 2: Store orderId in session
    session.setAttribute("orderId", orderId);

    // FIX 3: Redirect to success page
    response.sendRedirect("orderSuccess.jsp");
%>
