<form action="<%=request.getContextPath()%>/checkout"
      method="post"
      onsubmit="return validatePayment();">

    <h3 class="payment-title">Payment Options</h3>

    <label>
        <input type="radio" name="paymentMode" value="CARD" checked
               onclick="showPayment('CARD')">
        Pay with Card
    </label>
    <br><br>

    <label>
        <input type="radio" name="paymentMode" value="UPI"
               onclick="showPayment('UPI')">
        Pay with UPI
    </label>

    <hr>

    <!-- CARD -->
    <div id="cardSection">
        Card Holder Name:
        <input type="text" name="cardHolder" id="cardHolder">

        Card Number:
        <input type="text" name="cardNumber" id="cardNumber"
               placeholder="16 digit card number">

        Expiry Date:
        <input type="month" name="expiry" id="expiry">

        CVV:
        <input type="password" name="cvv" id="cvv"
               placeholder="3 digit CVV">
    </div>

    <!-- UPI -->
    <div id="upiSection" style="display:none;">
        UPI ID:
        <input type="text" name="upiId" id="upiId"
               placeholder="name@upi">
    </div>

    <button type="submit">Pay Now</button>
</form>

<script>
function showPayment(type) {
    if (type === 'CARD') {
        document.getElementById("cardSection").style.display = "block";
        document.getElementById("upiSection").style.display = "none";
    } else {
        document.getElementById("cardSection").style.display = "none";
        document.getElementById("upiSection").style.display = "block";
    }
}

function validatePayment() {
    const mode = document.querySelector(
        'input[name="paymentMode"]:checked'
    ).value;

    if (mode === "CARD") {
        const holder = document.getElementById("cardHolder").value.trim();
        const card = document.getElementById("cardNumber").value.trim();
        const expiry = document.getElementById("expiry").value;
        const cvv = document.getElementById("cvv").value.trim();

        if (holder === "") {
            alert("Please enter card holder name");
            return false;
        }
        if (!/^\d{16}$/.test(card)) {
            alert("Card number must be 16 digits");
            return false;
        }
        if (!expiry) {
            alert("Please select expiry date");
            return false;
        }
        if (!/^\d{3}$/.test(cvv)) {
            alert("CVV must be 3 digits");
            return false;
        }
    }

    if (mode === "UPI") {
        const upi = document.getElementById("upiId").value.trim();
        if (upi === "") {
            alert("Please enter UPI ID");
            return false;
        }
        if (!/^[a-zA-Z0-9._-]+@[a-zA-Z]+$/.test(upi)) {
            alert("Invalid UPI ID");
            return false;
        }
    }

    return true; // ✅ SUBMIT
}
</script>
