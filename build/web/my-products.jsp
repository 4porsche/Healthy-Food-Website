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
                                                    <option value="">-- Lọc theo --</option>
                                                    <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                                                    <option value="popular" ${param.sort == 'popular' ? 'selected' : ''}>Phổ biến</option>
                                                </select>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- Search + Sort Product End --%>

                            <c:choose>
                                <%-- Nếu có từ khóa search --%>
                                <c:when test="${not empty txtS}">

                                    <c:choose>
                                        <%-- Nếu có kết quả search --%>
                                        <c:when test="${not empty searchedList}">
                                            <c:forEach var="p" items="${searchedList}">
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
                                        </c:when>

                                        <%-- Nếu không tìm thấy kết quả --%>
                                        <c:otherwise>
                                            <div class="col-lg-12">
                                                <p>Không tìm thấy kết quả phù hợp.</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>

                                <c:when test="${not empty sortT}">
                                    <c:forEach var="p" items="${sortedList}">
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
                                </c:when>

                                <%-- Nếu chưa nhập search text --%>    
                                <c:otherwise>
                                    <%-- My Product List Start --%>
                                    <c:forEach var="p" items="${myProductList}">
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
                                                    <div class="title"><a href="#">${p.productName}</a></div>
                                                    <div class="price">${p.price}đ</div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <%-- My Product List End --%>

                                </c:otherwise>
                            </c:choose>


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
        <!-- Product List End -->


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
