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
            
            .product-item .product-content .price {
                text-align: center;
            }

            .slick-track {
                display: flex !important;
                align-items: stretch !important;
            }
        </style>
    </head>

    <body>
        <%@ include file="header.jsp" %>



        <!-- Main Slider Start -->
        <div class="home-slider">
            <div class="main-slider">
                <div class="main-slider-item"><img src="img/slider1.png" alt="Slider Image" style="width: 100vw; height: 75vh; object-fit: cover;"/></div>
                <div class="main-slider-item"><img src="img/slider2.png" alt="Slider Image" style="width: 100vw; height: 75vh; object-fit: cover;"/></div>
                <div class="main-slider-item"><img src="img/slider3.jpg" alt="Slider Image" style="width: 100vw; height: 75vh; object-fit: cover;"/></div>
            </div>
        </div>
        <!-- Main Slider End -->


        <!-- Feature Start-->
        <div class="feature">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-3 col-md-6 feature-col">
                        <div class="feature-content">
                            <i class="fa fa-shield"></i>
                            <h2>Mua Sắm An Tâm</h2>
                            <p>
                                Cam kết cung cấp sản phẩm sạch, an toàn và rõ nguồn gốc.
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 feature-col">
                        <div class="feature-content">
                            <i class="fa fa-shopping-bag"></i>
                            <h2>Sản Phẩm Chất Lượng</h2>
                            <p>
                                Thực phẩm ít béo, giàu dinh dưỡng, không chất bảo quản.
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 feature-col">
                        <div class="feature-content">
                            <i class="fa fa-truck"></i>
                            <h2>Giao Hàng Nhanh Chóng</h2>
                            <p>
                                Đảm bảo giao hàng tiện lợi, nhanh chóng tới tay người dùng.
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 feature-col">
                        <div class="feature-content">
                            <i class="fa fa-phone"></i>
                            <h2>Hỗ Trợ Khách Hàng</h2>
                            <p>
                                Luôn sẵn sàng giải đáp và hỗ trợ tận tâm 24/7.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Feature End-->


        <!-- Category Start-->
        <div class="category">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-4">
                        <div class="category-img">
                            <img src="img/healthy-roll.png" style="width: 100%; aspect-ratio: 1 / 1; object-fit: cover;" />
                            <a class="category-name" href="">
                                <h2>Healthy Rolls</h2>
                            </a>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="category-img">
                            <img src="img/low-carbs.png" style="width: 100%; aspect-ratio: 1 / 1; object-fit: cover;" />
                            <a class="category-name" href="">
                                <h2>Low-Carb Meals</h2>
                            </a>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="category-img">
                            <img src="img/vegan-special.png" style="width: 100%; aspect-ratio: 1 / 1; object-fit: cover;" />
                            <a class="category-name" href="">
                                <h2>Vegan Special</h2>
                            </a>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- Category End-->

        <!-- Featured Product Start -->
        <div class="featured-product">
            <div class="container">
                <div class="section-header">
                    <h3>Sản phẩm nổi bật</h3>
                    <p>
                        Những sản phẩm được chọn lọc kỹ càng, nổi bật với hàm lượng protein cao, chất béo thấp – phù hợp cho chế độ ăn uống lành mạnh và cân đối.
                    </p>
                </div>

                <div class="row align-items-center product-slider product-slider-4">
                    <c:forEach var="p" items="${featureList}">
                        <div class="col-lg-3">
                            <div class="product-item">
                                <div class="product-image">
                                    <a href="product-detail?pid=${p.productId}">
                                        <img src="${p.imageUrl}" alt="${p.productName}" class="product-img">
                                    </a>
                                    <div class="product-action">
                                        <a href="#"><i class="fa fa-cart-plus"></i></a>
                                        <a href="#"><i class="fa fa-search"></i></a>
                                    </div>
                                </div>
                                <div class="product-content">
                                    <div class="title"><a href="#">${p.productName}</a></div>
                                    <div class="price">${p.price}đ</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach> 
                </div>
            </div>
        </div>
        <!-- Featured Product End -->


        <!-- Recent Product Start -->
        <div class="recent-product">
            <div class="container">
                <div class="section-header">
                    <h3>Sản phẩm mới nhất</h3>
                    <p>
                        Khám phá những món ăn vừa được cập nhật – tươi ngon, dinh dưỡng và hợp xu hướng ăn uống lành mạnh.
                    </p>
                </div>
                <div class="row align-items-center product-slider product-slider-4">
                    <c:forEach var="p" items="${recentList}">
                        <div class="col-lg-3">
                            <div class="product-item">
                                <div class="product-image">
                                    <a href="product-detail?pid=${p.productId}">
                                        <img src="${p.imageUrl}" alt="${p.productName}" class="product-img">
                                    </a>
                                    <div class="product-action">
                                        <a href="#"><i class="fa fa-cart-plus"></i></a>
                                        <a href="#"><i class="fa fa-search"></i></a>
                                    </div>
                                </div>
                                <div class="product-content">
                                    <div class="title"><a href="#">${p.productName}</a></div>
                                    <div class="price">${p.price}đ</div>
                                </div>
                            </div>
                        </div>
                    </c:forEach> 
                </div>
            </div>
        </div>
        <!-- Recent Product End -->

        <%@ include file="footer.jsp" %>

        <!-- Back to Top -->
        <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/slick/slick.min.js"></script>


        <!-- Javascript -->
        <script src="js/main.js"></script>
    </body>

</html>
