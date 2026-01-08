<form action="${pageContext.request.contextPath}/placeOrder" method="post">

    <!-- Only send total to backend -->
    <input type="hidden" name="total" value="${cartTotal}">

    <button type="submit">Place Order</button>
</form>
