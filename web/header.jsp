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

            /* Vùng chào người dùng + dropdown */
            .welcome-content {
                display: flex;
                align-items: center;
                justify-content: flex-end;
                gap: 20px;
                font-size: 16px;
                position: relative;
            }

            /* Giỏ hàng */
            .welcome-content .cart {
                position: relative;
                display: inline-block;
            }

            .welcome-content .cart a {
                font-size: 25px;
                color: #3C603C;
                transition: color 0.3s;
            }

            .welcome-content .cart a:hover {
                color: #28a745;
            }

            .welcome-content .cart span {
                position: absolute;
                top: -8px;
                right: -12px;
                font-size: 14px;
                font-weight: bold;
                color: #dc3545;
                background: none;
                border: none;
            }


            /* Animation dropdown */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(5px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
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
        <!-- Top Header Start -->
        <div class="top-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-3 col-lg-3">
                        <div class="logo">
                            <a href="home">
                                <img src="img/header-logo.png" alt="Logo">
                            </a>
                        </div>
                    </div>

                    <!--                    <div class="col-md-6 brand-message text-center">
                                            <h5 style="margin: 0; font-weight: 600; font-size: 25px; color: #28a745;">Ăn lành mạnh, sống tích cực 🌿</h5>
                                        </div>-->

                    <div class="col-md-6 text-center" id="timeDisplay" style="font-size: 20px; color: #3C603C;"></div>
                    <script>
                        function updateTime() {
                            const now = new Date();
                            document.getElementById("timeDisplay").innerText =
                                    now.toLocaleTimeString('vi-VN') + " | " + now.toLocaleDateString('vi-VN');
                        }
                        setInterval(updateTime, 1000);
                        updateTime();
                    </script>


                    <div class="col-md-3 welcome-content">
                        <div class="user">
                            <div class="dropdown">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <!-- Sử dụng họ tên nếu có, nếu không thì dùng tên tài khoản -->
                                        <c:set var="displayName" value="${not empty sessionScope.fullname ? sessionScope.fullname : sessionScope.username}" />

                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="font-size: 17px;">
                                            Xin chào, ${displayName}
                                        </a>
                                        <div class="dropdown-menu">
                                            <a href="profile?userid=${sessionScope.userid}" class="dropdown-item">Xem hồ sơ</a>
                                            <a href="LogoutServlet" class="dropdown-item">Đăng xuất</a>
                                        </div>
                                    </c:when>

                                    <c:otherwise>
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Tài khoản của tôi</a>
                                        <div class="dropdown-menu">
                                            <a href="login.jsp" class="dropdown-item">Đăng nhập</a>
                                            <a href="register.jsp" class="dropdown-item">Đăng ký</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <c:if test="${sessionScope.user.getRoleID() == 3}">
                            <div class="cart">
                                <a href="cart.html" class="nav-item nav-link active">
                                    <i class="fa fa-shopping-cart"></i>
                                </a>
                                <span>(0)</span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <!-- Top Header End -->

        <!-- Header Start -->
        <div class="header">
            <div class="container">
                <nav class="navbar navbar-expand-md bg-dark navbar-dark">
                    <a href="#" class="navbar-brand">MENU</a>
                    <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                        <div class="navbar-nav m-auto">
                            <a href="home" class="nav-item nav-link active">Trang chủ</a>

                            <c:if test="${sessionScope.user.getRoleID() == 3}">
                                <a href="products" class="nav-item nav-link active">Sản phẩm</a>
                                <a href="#" class="nav-item nav-link active">Đơn hàng của tôi</a>

                            </c:if>

                            <c:if test="${sessionScope.user.getRoleID() == 5}">
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Sản phẩm</a>
                                    <div class="dropdown-menu">
                                        <a href="products" class="dropdown-item">Tẩt cả sản phẩm</a>
                                        <a href="my-products" class="dropdown-item">Sản phẩm của tôi</a>
                                    </div>
                                </div>
                            </c:if>
                                
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Pages</a>
                                <div class="dropdown-menu">
                                    <a href="product-list.html" class="dropdown-item">Product</a>
                                    <a href="product-detail.html" class="dropdown-item">Product Detail</a>
                                    <a href="cart.html" class="dropdown-item">Cart</a>
                                    <a href="wishlist.html" class="dropdown-item">Wishlist</a>
                                    <a href="checkout.html" class="dropdown-item">Checkout</a>
                                    <a href="login.html" class="dropdown-item">Login & Register</a>
                                    <a href="my-account.html" class="dropdown-item">My Account</a>
                                </div>
                            </div>

                            <c:if test="${sessionScope.user.getRoleID() == 5}">
                                <a href="seller-dashboard" class="nav-item nav-link">Trang người bán</a>
                            </c:if>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Header End -->
    </body>
</html>
