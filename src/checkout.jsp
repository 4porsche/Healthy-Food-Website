<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.cart" %>
<%@ page import="repository.CartDAO" %>

<%
    // Get user ID from session
    Integer userID = (Integer) session.getAttribute("userID");
    List<cart> cartItems = null;
    double subTotal = 0;
    
    // For testing, use userID 3 if not logged in
    if (userID == null) {
        userID = 3; // Set to Customer One for testing
    }
    
    CartDAO cartDAO = new CartDAO();
    cartItems = cartDAO.getCartByUserID(userID);
    
    if (cartItems != null) {
        for (cart item : cartItems) {
            subTotal += item.getPrice() * item.getQuantity();
        }
    }
    
    double shippingCost = 10000.0; // example fixed shipping cost
    double grandTotal = (cartItems != null && !cartItems.isEmpty()) ? subTotal + shippingCost : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Healthy Food - Checkout</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Bootstrap Ecommerce Template" name="keywords">
    <meta content="Bootstrap Ecommerce Template Free Download" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700&display=swap" rel="stylesheet">

    <!-- CSS Libraries -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="lib/slick/slick.css" rel="stylesheet">
    <link href="lib/slick/slick-theme.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
<!-- Top Header Start -->
<div class="top-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-3">
                <div class="logo">
                    <a href="index.jsp">
                        <img src="../img/logo.png" alt="Healthy Food Logo" style="max-height: 60px;">
                    </a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="search">
                    <form action="search" method="get">
                        <input type="text" name="query" placeholder="Search">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </form>
                </div>
            </div>
            <div class="col-md-3">
                <div class="user">
                    <div class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">My Account</a>
                        <div class="dropdown-menu">
                            <a href="login.jsp" class="dropdown-item">Login</a>
                            <a href="register.jsp" class="dropdown-item">Register</a>
                        </div>
                    </div>
                    <div class="cart">
                        <a href="cart.jsp">
                            <i class="fa fa-cart-plus"></i>
                            <span>(<%= cartItems != null ? cartItems.size() : 0 %>)</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Top Header End -->

<!-- Header Start -->
<div class="header">
    <div class="container">
        <nav class="navbar navbar-expand-md bg-dark navbar-dark">
            <a href="#" class="navbar-brand"></a>
            <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                <div class="navbar-nav m-auto">
                    <a href="index.jsp" class="nav-item nav-link">Home</a>
                    <a href="product-list.jsp" class="nav-item nav-link">Products</a>
                    <a href="cart.jsp" class="nav-item nav-link active">Cart</a>
                    <a href="contact.jsp" class="nav-item nav-link">Contact Us</a>
                </div>
            </div>
        </nav>
    </div>
</div>
<!-- Header End -->

<!-- Breadcrumb Start -->
<div class="breadcrumb-wrap">
    <div class="container">
        <ul class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
            <li class="breadcrumb-item"><a href="cart.jsp">Cart</a></li>
            <li class="breadcrumb-item active">Checkout</li>
        </ul>
    </div>
</div>
<!-- Breadcrumb End -->

<!-- Checkout Start -->
<div class="checkout">
    <div class="container">
        <div class="row align-items-stretch">
            <div class="col-md-5">
                <div class="checkout-form">
                    <form action="processcheckout" method="post" id="checkoutForm">
                        <h3>Shipping Information</h3>
                        <div class="form-group">
                            <label>Full Name *</label>
                            <input type="text" class="form-control" name="fullName" required>
                        </div>
                        <div class="form-group">
                            <label>Email *</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="form-group">
                            <label>Phone *</label>
                            <input type="tel" class="form-control" name="phone" required 
                                   pattern="[0-9]{9,10}" 
                                   title="Please enter a valid phone number (9-10 digits)"
                                   placeholder="Enter 9-10 digit phone number">
                            <div class="invalid-feedback">
                                Please enter a valid phone number (9-10 digits)
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Address *</label>
                            <input type="text" class="form-control" name="address" required>
                        </div>
                        <div class="form-group">
                            <label>City *</label>
                            <input type="text" class="form-control" name="city" required>
                        </div>
                        <div class="form-group">
                            <label>Notes</label>
                            <textarea class="form-control" name="notes" rows="3"></textarea>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-md-7 d-flex min-vh-100">
                <div class="checkout-summary w-100 d-flex flex-column min-vh-100 bg-white border p-4">
                    <h3>Order Summary</h3>
                    <div class="checkout-content flex-grow-1">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Qty</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (cartItems != null && !cartItems.isEmpty()) {
                                    for (cart item : cartItems) { %>
                                <tr>
                                    <td>
                                        <img src="../img/<%= item.getProductName().replace(" ", "") %>.jpg" alt="<%= item.getProductName() %>" style="width: 40px; height: 40px; object-fit: cover; margin-right: 5px;">
                                        <%= item.getProductName() %>
                                    </td>
                                    <td>x <%= item.getQuantity() %></td>
                                    <td><%= String.format("%,d", item.getPrice() * item.getQuantity()) %> VND</td>
                                </tr>
                                <% } } %>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="2"><strong>Subtotal</strong></td>
                                    <td><%= String.format("%,d", (int)subTotal) %> VND</td>
                                </tr>
                                <tr>
                                    <td colspan="2"><strong>Shipping</strong></td>
                                    <td><%= String.format("%,d", (int)shippingCost) %> VND</td>
                                </tr>
                                <tr>
                                    <td colspan="2"><strong>Total</strong></td>
                                    <td><%= String.format("%,d", (int)grandTotal) %> VND</td>
                                </tr>
                            </tfoot>
                        </table>
                        <div class="payment-method mt-4">
                            <h3>Payment Method</h3>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="bank" value="bank" checked>
                                <label class="form-check-label" for="bank">
                                    Bank Transfer
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="card" value="card">
                                <label class="form-check-label" for="card">
                                    Credit/Debit Card
                                </label>
                            </div>
                        </div>
                        <button type="submit" form="checkoutForm" class="btn btn-primary btn-block mt-4">Place Order</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Checkout End -->

<!-- Footer Start -->
<div class="footer" style="margin-top: 50px; padding-top: 30px; border-top: 1px solid #eee;">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="footer-widget">
                    <h1>Healthy Food Shop</h1>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="footer-widget">
                    <h3 class="title">Useful Pages</h3>
                    <ul>
                        <li><a href="product-list.jsp">Products</a></li>
                        <li><a href="cart.jsp">Cart</a></li>
                        <li><a href="checkout.jsp">Checkout</a></li>
                        <li><a href="login.jsp">Login & Register</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="footer-widget">
                    <h3 class="title">Contact Info</h3>
                    <div class="contact-info">
                        <p><i class="fa fa-map-marker"></i>123 Healthy Food, Los Angeles, CA, USA</p>
                        <p><i class="fa fa-envelope"></i>email@example.com</p>
                        <p><i class="fa fa-phone"></i>+123-456-7890</p>
                        <div class="social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->

<!-- Footer Bottom Start -->
<div class="footer-bottom">
    <div class="container">
        <div class="row">
            <div class="col-md-6 copyright">
                <p>Copyright &copy; Healthy Food Shop. All Rights Reserved</p>
            </div>
        </div>
    </div>
</div>
<!-- Footer Bottom End -->

<!-- Back to Top -->
<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/slick/slick.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>

<script>
document.getElementById('checkoutForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    // Validate form
    const requiredFields = ['fullName', 'email', 'phone', 'address', 'city'];
    let isValid = true;
    
    requiredFields.forEach(field => {
        const input = document.querySelector(`[name="${field}"]`);
        if (!input.value.trim()) {
            isValid = false;
            input.classList.add('is-invalid');
        } else {
            input.classList.remove('is-invalid');
        }
    });
    
    // Validate phone number specifically
    const phoneInput = document.querySelector('[name="phone"]');
    const phoneValue = phoneInput.value.trim();
    const phoneRegex = /^[0-9]{9,10}$/;
    
    if (!phoneRegex.test(phoneValue)) {
        isValid = false;
        phoneInput.classList.add('is-invalid');
    }
    
    if (!isValid) {
        alert('Please fill in all required fields correctly. Phone number must be 9-10 digits.');
        return;
    }
    
    // Show confirmation dialog
    if (confirm('Are you sure you want to place this order?')) {
        this.submit();
    }
});
</script>
</body>
</html> 