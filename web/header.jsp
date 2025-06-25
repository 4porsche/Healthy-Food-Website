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
                    <div class="col-md-6">
                        <div class="search">
                            <input type="text" placeholder="Tìm kiếm sản phẩm...">
                            <button><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="user">
                            <div class="dropdown">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user}">
                                        <!-- Sử dụng họ tên nếu có, nếu không thì dùng tên tài khoản -->
                                        <c:set var="displayName" value="${not empty sessionScope.fullname ? sessionScope.fullname : sessionScope.username}" />

                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
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
                            <a href="product-list.html" class="nav-item nav-link">Sản phẩm</a>
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
                            <a href="contact.html" class="nav-item nav-link">Contact Us</a>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Header End -->
    </body>
</html>
