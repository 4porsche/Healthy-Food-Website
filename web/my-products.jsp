<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Sản phẩm của tôi</title>

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

            .sidebar-widget.category ul li {
                margin-bottom: 10px;
            }

        </style>

    </head>
    <body>
        <!-- Top Header Start -->
        <div class="top-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-3">
                        <div class="logo">
                            <a href="">
                                <img src="img/logo.jpg" alt="Logo">
                            </a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="search">
                            <input type="text" placeholder="Search">
                            <button><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="user">
                            <div class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">My Account</a>
                                <div class="dropdown-menu">
                                    <a href="#" class="dropdown-item">Login</a>
                                    <a href="#" class="dropdown-item">Register</a>
                                </div>
                            </div>
                            <div class="cart">
                                <i class="fa fa-cart-plus"></i>
                                <span>(0)</span>
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
                            <a href="index.html" class="nav-item nav-link active">Home</a>
                            <a href="product-list.html" class="nav-item nav-link">Products</a>
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


        <!-- Breadcrumb Start -->
        <div class="breadcrumb-wrap">
            <div class="container">
                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Products</a></li>
                    <li class="breadcrumb-item active">My Products</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb End -->


        <!-- Product List Start -->
        <div class="product-view">
            <div class="container">
                <div class="row">
                    <div class="col-md-9">
                        <div class="row">

                            <%-- Search + Sort Product Start --%>
                            <div class="col-lg-12">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="product-search">
                                            <form action="my-products" method="POST" onsubmit="return validateSearchInput()">
                                                <div class="search-box">
                                                    <input value="${txtS}" type="text" id="searchInput" name="txt" placeholder="Tìm kiếm...">
                                                    <button type="submit" class="search-icon">
                                                        <i class="fa fa-search"></i>
                                                    </button>
                                                </div>
                                            </form>
                                        </div>

                                    </div>

                                    <div class="col-md-4">
                                        <div class="product-short">
                                            <form action="my-products" method="POST">
                                                <select name="sort" class="form-control" onchange="this.form.submit()">
                                                    <option value="">-- Sắp xếp theo --</option>
                                                    <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                                                    <option value="popular" ${param.sort == 'popular' ? 'selected' : ''}>Phổ biến</option>
                                                </select>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- Search + Sort Product End --%>

                            <%-- View Search + Sort Product Result Start --%>
                            <c:choose>
                                <c:when test="${empty productList}">
                                    <tr><td colspan="5">Không tìm thấy kết quả phù hợp.</td></tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="p" items="${productList}" varStatus="status">
                                        <div class="col-lg-4">
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
                                                    <div class="title"><a href="#">${p.getProductName()}</a></div>
                                                    <div class="price">${p.getPrice()}đ</div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                            <%-- View Search + Sort Product Result End --%>



                        </div>

                        <div class="col-lg-12">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item disabled">
                                        <a class="page-link" href="#" tabindex="-1">Previous</a>
                                    </li>
                                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="sidebar-widget category">
                            <h2 class="title">Danh mục</h2>
                            <ul>
                                <c:forEach var="i" items="${categoryNameMap}">
                                    <c:set var="categoryId" value="${i.key}" />
                                    <c:set var="categoryName" value="${i.value}" />
                                    <c:set var="count" value="${categoryCountMap[categoryId]}" />
                                    <li>
                                        <form action="my-products" method="POST" id="form-${categoryId}">
                                            <input type="hidden" name="categoryId" value="${categoryId}" />
                                            <a href="#" onclick="document.getElementById('form-${categoryId}').submit(); return false;">
                                                ${categoryName}
                                            </a>
                                            <span>${count}</span>
                                        </form>
                                    </li>         
                                </c:forEach>
                            </ul>
                        </div>

                        <div class="sidebar-widget tag">
                            <h2 class="title">Tags</h2>
                            <a href="#" value="bún">bún</a>
                            <a href="#" value="bánh tráng">bánh tráng</a>
                            <a href="#" value="vỏ tortilla">vỏ tortilla</a>
                            <a href="#" value="yến mạch">yến mạch</a>
                            <a href="#" value="gà">gà</a>
                            <a href="#" value="hải sản">hải sản</a>
                            <a href="#" value="trứng">trứng</a>
                            <a href="#" value="hạt">hạt</a>
                            <a href="#" value="nấm">nấm</a>
                            <a href="#" value="đậu hũ">đậu hũ</a>
                            <a href="#" value="đậu que">đậu que</a>
                            <a href="#" value="rong biển">rong biển</a>
                            <a href="#" value="trái cây">trái cây</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Product List End -->


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


        <!-- Back to Top -->
        <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/slick/slick.min.js"></script>


        <!-- Javascript -->
        <script src="js/main.js"></script>

        <script>
                                                function validateSearchInput() {
                                                    var input = document.getElementById('searchInput').value.trim();
                                                    if (input === "") {
                                                        return false; // Ngăn biểu mẫu được gửi đi
                                                    }
                                                    return true; // Cho phép gửi biểu mẫu
                                                }
        </script>

    </body>
</html>
