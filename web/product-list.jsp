<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>E Shop - Bootstrap Ecommerce Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Bootstrap Ecommerce Template" name="keywords">
    <meta content="Bootstrap Ecommerce Template Free Download" name="description">

    <!-- Favicon -->
<!--    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">-->

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700&display=swap" rel="stylesheet">

    <!-- CSS Libraries -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
     <link href="lib/slick/slick.css" rel="stylesheet">
        <link href="lib/slick/slick-theme.css" rel="stylesheet">

        <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <!-- Top Header Start -->
     
    <div class="top-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-3">
                    <div class="logo">
                        <a href="home">
                             <img src="img/header-logo.png" alt="Logo">
                        </a>
                    </div>
                </div>
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/search" method="get">
                        <div class="search">
                            <input type="text" name="q" placeholder="Search">
                            <button type="submit"><i class="fa fa-search"></i></button>
                        </div>
                    </form>
                </div>
                <div class="col-md-3">
                    <div class="user">
                        <div class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">My Account</a>
                            <div class="dropdown-menu">
                                <c:choose>
                                    <c:when test="${not empty user}">
                                        <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Logout</a>
                                        <a href="${pageContext.request.contextPath}/my-account" class="dropdown-item">My Account</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/login" class="dropdown-item">Login</a>
                                        <a href="${pageContext.request.contextPath}/register" class="dropdown-item">Register</a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="cart">
                            <a href="${pageContext.request.contextPath}/cart">
                                <i class="fa fa-cart-plus"></i>
                                <span>(${cart.itemCount})</span>
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
                <a href="#" class="navbar-brand">MENU</a>
                <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                    <div class="navbar-nav m-auto">
                        <a href="${pageContext.request.contextPath}/" class="nav-item nav-link ${pageContext.request.servletPath eq '/index.jsp' ? 'active' : ''}">Home</a>
                        <a href="${pageContext.request.contextPath}/product-list" class="nav-item nav-link ${pageContext.request.servletPath eq '/product-list.jsp' ? 'active' : ''}">Products</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Pages</a>
                            <div class="dropdown-menu">
                                <a href="product-list.jsp" class="dropdown-item">Product</a>
                                <a href="${pageContext.request.contextPath}/product-detail" class="dropdown-item">Product Detail</a>
                                <a href="${pageContext.request.contextPath}/cart" class="dropdown-item">Cart</a>
                                <a href="${pageContext.request.contextPath}/wishlist" class="dropdown-item">Wishlist</a>
                                <a href="${pageContext.request.contextPath}/checkout" class="dropdown-item">Checkout</a>
                                <a href="${pageContext.request.contextPath}/login" class="dropdown-item">Login & Register</a>
                                <a href="${pageContext.request.contextPath}/my-account" class="dropdown-item">My Account</a>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/contact" class="nav-item nav-link">Contact Us</a>
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product-list">Products</a></li>
                <li class="breadcrumb-item active">product list</li>
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
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-md-8">
                                    <form action="${pageContext.request.contextPath}/product-list" method="get">
                                        <div class="product-search">
                                            <input type="text" name="search" value="${param.search}" placeholder="Search products">
                                            <button type="submit"><i class="fa fa-search"></i></button>
                                        </div>
                                    </form>
                                </div>
                                <div class="col-md-4">
                                    <div class="product-short">
                                        <div class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Product sort by</a>
                                            <div class="dropdown-menu dropdown-menu-right">
                                                <a href="?sort=newest" class="dropdown-item">Newest</a>
                                                <a href="?sort=popular" class="dropdown-item">Popular</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Product Listing -->
                        <c:forEach items="${products}" var="product">
                            <div class="col-lg-4">
                                <div class="product-item">
                                    <div class="product-image">
                                        <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}">
                                            <img src="${pageContext.request.contextPath}/img/${product.image}" alt="${product.name}">
                                        </a>
                                        <div class="product-action">
                                            <a href="#" onclick="addToCart(${product.id})"><i class="fa fa-cart-plus"></i></a>
                                            <a href="#" onclick="addToWishlist(${product.id})"><i class="fa fa-heart"></i></a>
                                            <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}"><i class="fa fa-search"></i></a>
                                        </div>
                                    </div>
                                    <div class="product-content">
                                        <div class="title"><a href="${pageContext.request.contextPath}/product-detail?id=${product.id}">${product.name}</a></div>
                                        <div class="ratting">
                                            <c:forEach begin="1" end="${product.rating}">
                                                <i class="fa fa-star"></i>
                                            </c:forEach>
                                        </div>
                                        <div class="price">$${product.price} <c:if test="${product.oldPrice > 0}"><span>$${product.oldPrice}</span></c:if></div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="col-lg-12">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}&sort=${param.sort}&search=${param.search}">Previous</a>
                                    </li>
                                </c:if>
                                
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&sort=${param.sort}&search=${param.search}">${i}</a>
                                    </li>
                                </c:forEach>
                                
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}&sort=${param.sort}&search=${param.search}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
                
                <!-- Sidebar -->
                <div class="col-md-3">
                    <div class="sidebar-widget category">
                        <h2 class="title">Category</h2>
                        <ul>
                            <c:forEach items="${categories}" var="category">
                                <li>
                                    <a href="?category=${category.id}">${category.name}</a>
                                    <span>(${category.productCount})</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    
                    <c:if test="${not empty featuredProduct}">
                        <div class="sidebar-widget image">
                            <h2 class="title">Featured Product</h2>
                            <a href="${pageContext.request.contextPath}/product-detail?id=${featuredProduct.id}">
                                <img src="${pageContext.request.contextPath}/img/${featuredProduct.image}" alt="${featuredProduct.name}">
                            </a>
                        </div>
                    </c:if>
                    
                    <div class="sidebar-widget brands">
                        <h2 class="title">Our Brands</h2>
                        <ul>
                            <c:forEach items="${brands}" var="brand">
                                <li>
                                    <a href="?brand=${brand.id}">${brand.name}</a>
                                    <span>(${brand.productCount})</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    
                    <div class="sidebar-widget tag">
                        <h2 class="title">Tags Cloud</h2>
                        <c:forEach items="${tags}" var="tag">
                            <a href="?tag=${tag}">${tag}</a>
                        </c:forEach>
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
                        <h1>E Shop</h1>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sollicitudin rutrum massa. 
                            Vestibulum porttitor, metus sed pretium elementum, nisi nibh sodales quam.
                        </p>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="footer-widget">
                        <h3 class="title">Useful Pages</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/product-list">Product</a></li>
                            <li><a href="${pageContext.request.contextPath}/product-detail">Product Detail</a></li>
                            <li><a href="${pageContext.request.contextPath}/cart">Cart</a></li>
                            <li><a href="${pageContext.request.contextPath}/checkout">Checkout</a></li>
                            <li><a href="${pageContext.request.contextPath}/login">Login & Register</a></li>
                            <li><a href="${pageContext.request.contextPath}/my-account">My Account</a></li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="footer-widget">
                        <h3 class="title">Quick Links</h3>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                            <li><a href="${pageContext.request.contextPath}/product-list">Products</a></li>
                            <li><a href="${pageContext.request.contextPath}/cart">Cart</a></li>
                            <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
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
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-linkedin"></i></a>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                                <a href="#"><i class="fa fa-youtube"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row payment">
                <div class="col-md-6">
                    <div class="payment-method">
                        <p>We Accept:</p>
                        <img src="${pageContext.request.contextPath}/img/payment-method.png" alt="Payment Method" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="payment-security">
                        <p>Secured By:</p>
                        <img src="${pageContext.request.contextPath}/img/godaddy.svg" alt="Payment Security" />
                        <img src="${pageContext.request.contextPath}/img/norton.svg" alt="Payment Security" />
                        <img src="${pageContext.request.contextPath}/img/ssl.svg" alt="Payment Security" />
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
                    <p>Copyright &copy; <a href="#">E-Shop</a>. All Rights Reserved</p>
                </div>
                <div class="col-md-6 template-by">
                    <p>Template By <a href="https://htmlcodex.com">HTML Codex</a></p>
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
    <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/slick/slick.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    
    <script>
    function addToCart(productId) {
        $.post('${pageContext.request.contextPath}/cart', {
            action: 'add',
            productId: productId,
            quantity: 1
        }, function(response) {
            if(response.success) {
                alert('Product added to cart!');
                // Update cart count
                $('.cart span').text('(' + response.cartCount + ')');
            } else {
                alert('Error: ' + response.message);
            }
        });
    }
    
    function addToWishlist(productId) {
        $.post('${pageContext.request.contextPath}/wishlist', {
            action: 'add',
            productId: productId
        }, function(response) {
            if(response.success) {
                alert('Product added to wishlist!');
            } else {
                alert('Error: ' + response.message);
            }
        });
    }
    </script>
</body>
</html>