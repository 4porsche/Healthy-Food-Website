<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <title>Chi tiết sản phẩm</title>

            <!-- Favicon -->
            <link href="img/favicon.ico" rel="icon">

            <!-- Google Fonts -->
            <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700&display=swap" rel="stylesheet">

            <!-- CSS Libraries -->
            <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
                rel="stylesheet">
            <link href="lib/slick/slick.css" rel="stylesheet">
            <link href="lib/slick/slick-theme.css" rel="stylesheet">

            <link href="css/style.css" rel="stylesheet">

            <style>
                .product-img {
                    height: 350px;
                    object-fit: cover;
                    object-position: center;
                }

                .product-content-large .title {
                    justify-content: flex-start !important;
                    text-align: left !important;
                }

                .product-content-mini .title {
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

                .product-content-mini .title a {
                    display: -webkit-box;
                    -webkit-line-clamp: 2;
                    -webkit-box-orient: vertical;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    font-size: 18px;
                    line-height: 1.4;
                }

                .product-img-mini {
                    width: 255px;
                    height: 280px;
                    object-fit: cover;
                    object-position: center;
                }

                .product-content .title,
                .product-content .title h2 {
                    text-align: left !important;
                }

                .product-content-mini .price {
                    text-align: center;
                }
            </style>
        </head>

        <body>
            <%@ include file="header.jsp" %>


                <!-- Breadcrumb Start -->
                <div class="breadcrumb-wrap">
                    <div class="container">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item"><a href="#">Products</a></li>
                            <li class="breadcrumb-item active">Product details</li>
                        </ul>
                    </div>
                </div>
                <!-- Breadcrumb End -->


                <!-- Product Detail Start -->
                <div class="product-detail">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-9">
                                <div class="row align-items-center product-detail-top">
                                    <div class="col-md-5">
                                        <div class="product-slider-single">
                                            <img src="${detail.imageUrl}" alt="${detail.productName}"
                                                class="product-img">
                                        </div>
                                    </div>
                                    <div class="col-md-7">
                                        <div class="product-content product-content-large">
                                            <div class="title">
                                                <h2>${detail.productName}</h2>
                                            </div>
                                            <div class="price">${detail.price}đ</div>
                                            <div class="details">
                                                <p>
                                                    ${detail.description}
                                                </p>
                                            </div>

                                            <div class="quantity">
                                                <h4>Số lượng:</h4>
                                                <div class="qty">
                                                    <button class="btn-minus"><i class="fa fa-minus"></i></button>
                                                    <input type="text" value="1">
                                                    <button class="btn-plus"><i class="fa fa-plus"></i></button>
                                                </div>
                                            </div>
                                            <div class="action">
                                                <a href="#"><i class="fa fa-cart-plus"></i></a>
                                                <a href="#"><i class="fa fa-search"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row product-detail-bottom">
                                    <div class="col-lg-12">
                                        <ul class="nav nav-pills nav-justified">
                                            <li class="nav-item">
                                                <a class="nav-link active" data-toggle="pill" href="#description">Mô
                                                    tả sản phẩm</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-toggle="pill" href="#reviews">Đánh giá
                                                    (1)</a>
                                            </li>
                                        </ul>

                                        <div class="tab-content">
                                            <div id="description" class="container tab-pane active"><br>
                                                <h4>Thành phần</h4>
                                                <p>${detail.ingredient}</p>

                                                <h4>Chỉ số dinh dưỡng</h4>
                                                <ul>
                                                    <!-- guest chỉ xem được weight + tags-->
                                                    <li>Khối lượng: ${detail.weight} gam</li>
                                                    <li>Lượng calo: ${detail.calories} kcal</li>
                                                    <li>Hàm lượng đạm: ${detail.protein} gam</li>
                                                    <li>Hàm lượng chất béo: ${detail.fat} gam</li>
                                                    <li>Hàm lượng tinh bột: ${detail.carbs} gam</li>
                                                    <li>Tag: ${detail.tags}</li>
                                                </ul>
                                            </div>
                                            <div id="reviews" class="container tab-pane fade"><br>
                                                <div class="reviews-submitted">
                                                    <div class="reviewer">Phasellus Gravida - <span>01 Jan 2020</span>
                                                    </div>
                                                    <div class="ratting">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>
                                                    <p>
                                                        Sed ut perspiciatis unde omnis iste natus error sit voluptatem
                                                        accusantium doloremque laudantium, totam rem aperiam.
                                                    </p>
                                                </div>
                                                <div class="reviews-submit">
                                                    <h4>Give your Review:</h4>
                                                    <div class="ratting">
                                                        <i class="fa fa-star-o"></i>
                                                        <i class="fa fa-star-o"></i>
                                                        <i class="fa fa-star-o"></i>
                                                        <i class="fa fa-star-o"></i>
                                                        <i class="fa fa-star-o"></i>
                                                    </div>
                                                    <div class="row form">
                                                        <div class="col-sm-6">
                                                            <input type="text" placeholder="Name">
                                                        </div>
                                                        <div class="col-sm-6">
                                                            <input type="email" placeholder="Email">
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <textarea placeholder="Review"></textarea>
                                                        </div>
                                                        <div class="col-sm-12">
                                                            <button>Submit</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="container">
                                    <div class="section-header">
                                        <h3>Sản phẩm liên quan</h3>
                                    </div>
                                </div>

                                <div class="row align-items-center product-slider product-slider-3">
                                    <c:forEach var="p" items="${similarProducts}">
                                        <div class="col-lg-3">
                                            <div class="product-item">
                                                <div class="product-image">
                                                    <a href="product-detail?pid=${p.getProductId()}">
                                                        <img src="${p.imageUrl}" alt="${p.productName}"
                                                            class="product-img-mini">
                                                    </a>
                                                    <div class="product-action">
                                                        <a href="#"><i class="fa fa-cart-plus"></i></a>
                                                        <a href="#"><i class="fa fa-search"></i></a>
                                                    </div>
                                                </div>
                                                <div class="product-content product-content-mini">
                                                    <div class="title"><a href="#">${p.productName}</a></div>
                                                    <div class="price">${p.price}đ</div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>

                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="sidebar-widget category">
                                    <h2 class="title">Category</h2>
                                    <ul>
                                        <c:forEach var="i" items="${categoriesList}">
                                            <li>
                                                <a href="#">${i.key}</a>
                                                <span>${i.value}</span>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>

                                <div class="sidebar-widget tag">
                                    <h2 class="title">Tags Cloud</h2>
                                    <a href="#">Lorem ipsum</a>
                                    <a href="#">Vivamus</a>
                                    <a href="#">Phasellus</a>
                                    <a href="#">pulvinar</a>
                                    <a href="#">Curabitur</a>
                                    <a href="#">Fusce</a>
                                    <a href="#">Sem quis</a>
                                    <a href="#">Mollis metus</a>
                                    <a href="#">Sit amet</a>
                                    <a href="#">Vel posuere</a>
                                    <a href="#">orci luctus</a>
                                    <a href="#">Nam lorem</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Product Detail End -->


                <%@ include file="footer.jsp" %>


                    <!-- Back to Top -->
                    <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>


                    <!-- JavaScript Libraries -->
                    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
                    <script
                        src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
                    <script src="lib/easing/easing.min.js"></script>
                    <script src="lib/slick/slick.min.js"></script>


                    <!-- Template Javascript -->
                    <script src="js/main.js"></script>
        </body>

        </html>