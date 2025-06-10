<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Customer Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

        <!-- Header -->
        <div class="top-header py-3 bg-light">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-3">
                        <a href="#"><img src="img/logo.png" alt="Logo" class="img-fluid"></a>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search">
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 d-flex justify-content-end align-items-center">
                        <div class="dropdown mr-3">
                            <a href="#" class="dropdown-toggle text-dark" data-toggle="dropdown">My Account</a>
                            <div class="dropdown-menu">
                                <a href="#" class="dropdown-item">Login</a>
                                <a href="#" class="dropdown-item">Register</a>
                            </div>
                        </div>
                        <div class="cart">
                            <i class="fa fa-cart-plus fa-lg"></i>
                            <span>(0)</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Customer Profile -->
        <div class="container my-5">
            <h2 class="text-center text-primary mb-4">Hồ sơ khách hàng</h2>
            <div class="card shadow p-4">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <strong>Họ và tên:</strong>
                        <p>${customer.fullname}</p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong>Email:</strong>
                        <p>${customer.email}</p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong>Số điện thoại:</strong>
                        <p>${customer.phone}</p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong>Giới tính:</strong>
                        <p>${customer.gender}</p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong>Chiều cao:</strong>
                        <p>${customer.height} cm</p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong>Cân nặng:</strong>
                        <p>${customer.weight} kg</p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong>BMI:</strong>
                        <p>${customer.BMI}</p>
                    </div>
                    <div class="col-md-6 mb-3">
                        <strong>Mức độ hoạt động:</strong>
                        <p>${customer.activitylevel}</p>
                    </div>
                    <div class="col-12 mb-3">
                        <strong>Mục tiêu:</strong>
                        <p>${customer.goal}</p>
                    </div>
                    <div class="col-12 d-flex gap-2 flex-wrap">
                        <a class="btn btn-outline-success btn-sm mr-2" href="load?userid=${customer.userid}">
                            <i class="fa fa-plus-square"></i> Nhập chỉ số cơ thể
                        </a>
                        <a class="btn btn-outline-info btn-sm" href="loadpassword?userid=${customer.userid}">
                            <i class="fa fa-key"></i> Đổi mật khẩu
                        </a>
                    </div>
                </div>
            </div>
        </div>
                            
          <!-- Footer Start -->
        <div class="footer">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-widget">
                            <h1>E Shop</h1>
                            <p>
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sollicitudin rutrum massa. Suspendisse sollicitudin rutrum massa. Vestibulum porttitor, metus sed pretium elementum, nisi nibh sodales quam, non lobortis neque felis id mauris.
                            </p>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="footer-widget">
                            <h3 class="title">Useful Pages</h3>
                            <ul>
                                <li><a href="product.html">Product</a></li>
                                <li><a href="product-detail.html">Product Detail</a></li>
                                <li><a href="cart.html">Cart</a></li>
                                <li><a href="checkout.html">Checkout</a></li>
                                <li><a href="login.html">Login & Register</a></li>
                                <li><a href="my-account.html">My Account</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="footer-widget">
                            <h3 class="title">Quick Links</h3>
                            <ul>
                                <li><a href="product.html">Product</a></li>
                                <li><a href="cart.html">Cart</a></li>
                                <li><a href="checkout.html">Checkout</a></li>
                                <li><a href="login.html">Login & Register</a></li>
                                <li><a href="my-account.html">My Account</a></li>
                                <li><a href="wishlist.html">Wishlist</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="footer-widget">
                            <h3 class="title">Get in Touch</h3>
                            <div class="contact-info">
                                <p><i class="fa fa-map-marker"></i>123 E Shop, Los Angeles, CA, USA</p>
                                <p><i class="fa fa-envelope"></i>email@example.com</p>
                                <p><i class="fa fa-phone"></i>+123-456-7890</p>
                                <div class="social">
                                    <a href=""><i class="fa fa-twitter"></i></a>
                                    <a href=""><i class="fa fa-facebook"></i></a>
                                    <a href=""><i class="fa fa-linkedin"></i></a>
                                    <a href=""><i class="fa fa-instagram"></i></a>
                                    <a href=""><i class="fa fa-youtube"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row payment">
                    <div class="col-md-6">
                        <div class="payment-method">
                            <p>We Accept:</p>
                            <img src="img/payment-method.png" alt="Payment Method" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="payment-security">
                            <p>Secured By:</p>
                            <img src="img/godaddy.svg" alt="Payment Security" />
                            <img src="img/norton.svg" alt="Payment Security" />
                            <img src="img/ssl.svg" alt="Payment Security" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->                   
        <!-- Footer -->
          <div class="footer-bottom">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 copyright">
                        <p>Copyright &copy; <a href="https://htmlcodex.com">HTML Codex</a>. All Rights Reserved</p>
                    </div>

                    <div class="col-md-6 template-by">
                        <p>Template By <a href="https://htmlcodex.com">HTML Codex</a></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/slick/slick.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
