<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Quản lý sản phẩm</title>

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
            body {
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 80%;
                margin: 20px auto;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                margin-top: 30px;
                font-size: 34px;
                text-align: center;
                color: #3C603C;
            }

            .header {
                width: 100%;
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-top: 20px;
                margin-bottom: 15px;
            }

            .add-btn, .delete-btn {
                padding: 10px 15px;
                border: none;
                color: white;
                border-radius: 5px;
                cursor: pointer;
            }

            .add-btn {
                background-color: #3C603C;
                margin-left: 0; /* Đảm bảo không bị lệch */
            }


            .delete-btn {
                background-color: #dc3545;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }

            th, td {
                padding: 10px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            th {
                padding: 20px;
                background-color: #3C603C;
                color: white;
                font-size: 18px;
            }

            td {
                font-size: 18px;
            }
            td img {
                width: 150px;
                border-radius: 5px;
            }

            .edit-btn, .delete-btn {
                background: none;
                border: none;
                cursor: pointer;
                font-size: 18px;
            }

            .edit-btn i {
                color: #ffc107;
            }

            .delete-btn i {
                color: #dc3545;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            /* Popup form */
            .popup {
                display: none; /* Ẩn mặc định */
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }

            /* Nội dung form */
            .popup-content {
                display: flex;
                flex-direction: column; /* Ép các phần tử xếp dọc */
                background: white;
                padding: 60px;
                border-radius: 8px;
                width: 30%;
                height: 80%;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                position: relative;
            }
            .popup-content h3 {
                text-align: left !important;
            }

            /* Nút đóng */
            .close-btn {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 30px;
                cursor: pointer;
            }

            /* Input, select, textarea */
            input, select {
                width: 100%;
                padding: 8px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            /* Button */

            .popup-button {
                margin-top: 15px;
            }

            .btn-submit {
                background: #28a745;
                color: white;
                padding: 10px;
                border: none;
                width: 100%;
                border-radius: 5px;
                cursor: pointer;
                margin-bottom: 3px;
            }

            .btn-cancel {
                margin-top: 15px;
                background: #dc3545;
                color: white;
                padding: 10px;
                border: none;
                width: 100%;
                border-radius: 5px;
                margin-top: 5px;
                cursor: pointer;
            }

            .btn-home {
                display: inline-block;
                background-color: #3C603C;
                color: white;
                padding: 9px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
                text-decoration: none;
                font-size: 16px;
                width: auto;
                margin-left: 150px;
                margin-bottom: 30px;
            }

            .pagination {
                display: flex;
                justify-content: flex-end;
                margin-top: 20px;
                margin-right: 142px;
                padding-right: 10px;
            }

            .pagination a {
                display: inline-block;
                padding: 10px 15px;
                margin: 0 0 0 5px;
                text-decoration: none;
                font-weight: 600;
                color: #333;
                background-color: #fff;
                transition: all 0.3s ease;
            }

            .pagination a:hover {
                background-color: #a49898;
                color: white;
                border-color: #f9a825;
            }

            .pagination a.active {
                background-color: #3C603C;
                color: white;
                font-weight: bold;
                border-color: #d32f2f;
            }

            .pagination a:first-child,
            .pagination a:last-child {
                font-weight: 600;
            }
        </style>

    </head>
    <body>
        <div class="container">
            <h2><b>Quản lý sản phẩm</b></h2>
            <div class="header-manange">
                <div class="row">
                    <div class="col-md-9">
                        <div class="row">

                            <%-- Search + Sort Product Start --%>
                            <div class="col-lg-12">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="product-search">
                                            <form action="products" method="POST" onsubmit="return validateSearchInput()">
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
                                            <form action="products" method="POST">
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
                                                            <a href="product-detail.html">
                                                                <img src="img/product1.png" alt="Product Image">
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
                                                    <a href="product-detail.html">
                                                        <img src="img/product1.png" alt="Product Image">
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
                                    <%-- All Product List Start --%>
                                    <c:forEach var="p" items="${productList}">
                                        <div class="col-lg-4">
                                            <div class="product-item">
                                                <div class="product-image">
                                                    <a href="product-detail?pid=${p.getProductId()}">
                                                        <img src="img/product1.png" alt="Product Image">
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
                                    <%-- All Product List End --%>

                                </c:otherwise>
                            </c:choose>


                            <button class="add-btn" onclick="openPopup()">Thêm sản phẩm</button>
                        </div>
                    </div>

                </div>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên</th>
                        <th>Ảnh</th>
                        <th>Giá</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Dùng JSTL để hiển thị danh sách sản phẩm -->
                    <c:forEach var="p" items="${productList}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td class="pname">${p.productName}</td>
                            <td><img src="${p.imageUrl}" alt="Product Image" width="100"></td>
                            <td>${p.price}đ</td>
                    <td>
                        <a href="load?pid=${p.productId}">
                            <button class="edit-btn"><i class="fas fa-edit"></i></button>
                        </a>

                        <a href="delete?pid=${p.productId}" onclick="return confirmDelete(event, '${p.productName}')">
                            <button class="delete-btn"><i class="fas fa-trash"></i></button>
                        </a>
                    </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <form action="add" method="POST">
            <div id="popupForm" class="popup">
                <div class="popup-content">
                    <span class="close-btn" onclick="closePopup()">&times;</span>
                    <h3>Thêm sản phẩm</h3>
                    <label for="name">Tên</label>
                    <input type="text" id="name" name="name" required>

                    <label for="image">URL ảnh</label>
                    <input type="text" id="image" name="image" required>

                    <label for="price">Giá</label>
                    <input type="number" id="price" name="price" required>

                    <label for="title">Mô tả</label>
                    <input type="text" id="description" name="description" required>

                    <label for="description">Thành phần</label>
                    <input type="text" id="ingredient" name="ingredient" required>

                    <label for="category">Danh mục</label>
                    <select id="category" name="category">
                        <option value="Miso">Nước dùng Miso</option>
                        <option value="Tonkotsu">Nước dùng Tonkotsu</option>
                        <option value="Shoyu">Nước dùng Shoyu</option>
                        <option value="Special">Đặc biệt</option>
                    </select>
                    <div class="popup-button">
                        <button type="submit" class="btn-submit">Thêm</button>
                        <button type="button" class="btn-cancel" onclick="closePopup()">Hủy</button>
                    </div>
                    <c:if test="${not empty sessionScope.ms}">
                        <p id="error-message">${sessionScope.ms}</p>
                        <c:remove var="ms" scope="session"/>
                    </c:if>


                </div>
            </div>
        </form>

        <c:set var="totalPages" value="${totalPages}" />
        <c:set var="totalProducts" value="${totalProducts}" />
        <c:set var="currentPage" value="${currentPage}" />
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <!-- Nút Previous -->
                <c:if test="${currentPage > 1}">
                    <a href="manage-product?page=${currentPage - 1}">Trang trước</a>
                </c:if>

                <!-- Các số trang -->
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="manage-product?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>

                <!-- Nút Next -->
                <c:if test="${currentPage < totalPages}">
                    <a href="manage-product?page=${currentPage + 1}">Trang sau</a>
                </c:if>
            </div>
        </c:if>



        <a href="home">
            <button class="btn-home">Quay lại trang chủ</button>
        </a>



        <script>
            function openPopup() {
                document.getElementById("popupForm").style.display = "flex";
            }

            function closePopup() {
                document.getElementById("popupForm").style.display = "none";
            }

        </script>

        <script>
            function confirmDelete(event, productName) {
                event.preventDefault(); // Ngăn chặn hành động mặc định của thẻ <a>
                let confirmation = confirm("Bạn có chắc chắn muốn xóa sản phẩm '" + productName + "' không?");
                if (confirmation) {
                    window.location.href = event.currentTarget.href; // Chuyển hướng nếu xác nhận
                }
            }
        </script>

        <script>
            window.onload = function () {
                var errorMessage = document.querySelector("#error-message")?.innerText;
                if (errorMessage && errorMessage.trim() !== "") {
                    document.getElementById("popupForm").style.display = "flex";
                }
            };
        </script>
    </body>
</html>
