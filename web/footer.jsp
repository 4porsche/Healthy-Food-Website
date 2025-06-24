<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Healthy Food</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700&display=swap" rel="stylesheet">

        <!-- CSS Libraries -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="lib/slick/slick.css" rel="stylesheet">
        <link href="lib/slick/slick-theme.css" rel="stylesheet">

        <link href="css/style.css" rel="stylesheet">

        <style>
            .product-img {
                width: 255px;
                height: 280px;
                object-fit: cover;
                object-position: center;
            }

            .product-content .title {
                height: 48px;
                overflow: hidden;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                text-overflow: ellipsis;
                display: flex;
                justify-content: center;
                align-items: center;
                text-align: center;
            }

            .product-content .title a {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                font-size: 18px;
                line-height: 1.4;
            }

            .top-header {
                padding: 20px 0;
                height: auto;
            }
            .top-header {
                height: auto !important;
                padding: 20px 0;
                overflow: hidden;
            }

            .logo img {
                max-width: 100%;
                height: auto;
                display: block;
            }

            .container, .row {
                height: auto !important;
            }

            .top-header .logo a img {
                max-height: 90px;
                height: auto;
                width: auto;
            }

            .header {
                padding: 7px 0px;
            }

            .top-header {
                position: relative;
                z-index: 10; /* Giữ header nằm trên */
            }

            .dropdown-menu {
                position: absolute;
                z-index: 999; /* Đảm bảo dropdown nằm trên mọi thứ khác */
            }
            .top-header {
                overflow: visible;
            }

            @media (min-width: 768px) {
                .top-header {
                    max-height: none;
                }
            }

            .navbar-nav .nav-link,
            .navbar-brand {
                font-size: 18px !important;
                font-weight: 510;
            }

            .navbar-nav {
                display: flex;
                gap: 50px;
            }

        </style>
    </head>
    
    <body>
        <!-- Footer Start -->
        <div class="footer">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-widget">
                            <h1>Healthy Food Shop</h1>
                            <p>
                                Chúng tôi luôn cố gắng mang đến cho bạn những bữa ăn tươi ngon, ít béo, giàu protein và không dùng chất bảo quản. Nguyên liệu sạch, rõ nguồn gốc được chọn lựa kỹ lưỡng mỗi ngày – để bạn vừa ăn ngon, vừa an tâm sống khỏe.
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
                            <img src="img/vnpay-logo1.png" alt="Payment Method" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="payment-security">
                            <p>Secured By:</p>
                            <img src="img/vegan-logo.png" alt="Vegan Certification" />
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
                        <p>Copyright &copy; <a href="https://htmlcodex.com">2025 Healthy Food</a>. All Rights Reserved</p>
                    </div>

                    <div class="col-md-6 template-by">
                        <a href="#" class="policy-link">Chính sách bảo mật</a>
                        <span class="separator">•</span>
                        <a href="#" class="policy-link">Chính sách hoàn tiền</a>
                    </div>


                </div>
            </div>
        </div>
        <!-- Footer Bottom End -->
    </body>
</html>
