<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

            .sold-badge {
                position: absolute;
                top: 8px;
                left: 8px;
                background-color: rgba(0, 150, 136, 0.8);
                color: white;
                font-size: 0.8rem;
                padding: 5px 7px;
                border-radius: 4px;
                font-weight: bold;
            }
        </style>

    </head>
    <body>
        <%@ include file="header.jsp" %>

        <!-- Breadcrumb Start -->
        <div class="breadcrumb-wrap">
            <div class="container">
                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                    <li class="breadcrumb-item active"><a href="my-products">Sản phẩm của tôi</a></li>
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
                                            <form action="my-products" onsubmit="return validateSearchInput()">
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
                                            <form action="my-products">
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
                            <c:set var="pageSize" value="6" />
                            <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />

                            <c:choose>
                                <c:when test="${empty productList}">
                                    <div class="col-lg-12">
                                        <div class="alert alert-warning text-center py-4" role="alert" style="font-size: 18px;">
                                            Không tìm thấy kết quả phù hợp với từ khóa "<strong>${txtS}</strong>".
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="totalProducts" value="${productList.size()}" />
                                    <c:set var="totalPagesRaw" value="${(totalProducts + pageSize - 1) / pageSize}" />
                                    <c:set var="totalPages" value="${fn:substringBefore(totalPagesRaw, '.')}" />

                                    <c:set var="start" value="${(currentPage - 1) * pageSize}" />
                                    <c:set var="end" value="${start + pageSize - 1}" />

                                    <c:forEach var="p" items="${productList}" varStatus="status">
                                        <c:if test="${status.index >= start && status.index <= end}">
                                            <div class="col-lg-4">
                                                <div class="product-item">
                                                    <div class="product-image">
                                                        <a href="product-detail?pid=${p.productId}">
                                                            <img src="${p.imageUrl}" alt="${p.productName}" class="product-img">
                                                        </a>

                                                        <div class="sold-badge">
                                                            Đã bán: 50
                                                        </div>
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
                                        </c:if>
                                    </c:forEach>

                                </c:otherwise>
                            </c:choose>
                            <%-- View Search + Sort Product Result End --%>

                        </div>

                        <div class="col-lg-12">
                            <nav aria-label="Page navigation example">
                                <c:set var="totalPages" value="${(productList.size() + pageSize - 1) / pageSize}" />
                                <div>
                                    <ul class="pagination justify-content-center">

                                        <!-- First -->
                                        <c:if test="${currentPage > 2}">
                                            <li class="page-item">
                                                <a class="page-link" href="my-products?page=1">Trang đầu</a>
                                            </li>
                                        </c:if>

                                        <!-- Previous -->
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="my-products?page=${currentPage - 1}">Trước</a>
                                            </li>
                                        </c:if>

                                        <!-- Page Numbers -->
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="my-products?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- Next -->
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="my-products?page=${currentPage + 1}">Sau</a>
                                            </li>
                                        </c:if>

                                        <!-- Last -->
                                        <c:if test="${currentPage < totalPages - 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="my-products?page=${totalPages}">Trang cuối</a>
                                            </li>
                                        </c:if>

                                    </ul>
                                </div>
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
                                        <form action="my-products" id="form-${categoryId}">
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
                            <c:forEach var="tag" items="${tagList}">
                                <a href="my-products?tag=${tag}" value="${tag}">${tag}</a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

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
