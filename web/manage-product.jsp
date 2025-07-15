<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-brands/css/uicons-brands.css'>
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-straight/css/uicons-regular-straight.css'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <link href="css/style.css" rel="stylesheet">

        <style>
            /*            body {
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
                        }*/

            h2 {
                margin-top: 30px;
                font-size: 34px;
                text-align: center;
                color: #3C603C;
            }

            .header {
                width: 100%;
                /*                display: flex;*/
                /*                justify-content: flex-end;
                                align-items: center;*/
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
                margin-left: 316px;
                width: 155px;
                height: 52px;
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

            .popup-content {
                background: white;
                border-radius: 8px;
                width: 30%;
                height: 80%;
                padding: 20px;
                display: flex;
                flex-direction: column;
                position: relative;
                max-height: 90vh;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            }

            .popup-body {
                flex-grow: 1;
                overflow-y: auto;

                overflow-y: auto;
                max-height: 70vh; /* hoặc tính toán tùy nội dung */
                padding-right: 12px; /* tránh scrollbar che nội dung */
                box-sizing: border-box;
            }

            .popup-footer {
                margin-top: 10px;
                display: flex;
                gap: 10px;
                flex-direction: column;
            }

            .btn-submit,
            .btn-cancel {
                padding: 10px;
                border-radius: 5px;
                border: none;
                color: white;
                cursor: pointer;
            }

            .btn-submit {
                background: #28a745;
            }

            .btn-cancel {
                background: #dc3545;
            }


            .popup-content h3 {
                text-align: center !important;
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
                display: flex;
                justify-content: right;
                gap: 8px;
            }

            /*            .btn-submit {
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
                        }*/

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
                margin-top: 30px;
                margin-left: 110px;
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

            .pimg {
                width: 170px;
                height: 170px;
                object-fit: cover;
                border-radius: 5px;
            }

            a {
                text-decoration: none !important;
            }


            .search-box {
                position: relative;
                width: 450px;
            }

            .search-box input {
                width: 100%;
                padding-right: 40px;
                height: 36px;
                border: 1px solid #3C603C;
                border-radius: 3px;
            }

            .search-box .search-icon {
                position: absolute;
                top: 1px;
                right: 1px;
                width: 35px;
                height: 34px;
                /*                background: #3C603C;*/
                border: none;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 0 3px 3px 0;
                cursor: pointer;
            }

            .search-box button {
                position: absolute;
                width: 35px;
                height: 33px;
                top: 1px;
                right: 1px;
                text-align: center;
                background: #ffffff;
                color: #3C603C;
                border: none;
                margin-top: 5px;
            }

            .search-box button:hover {
                background: #3C603C;
                color: #ffffff;
            }

            .search-box button i {
                color: #3C603C;
            }

            .search-box button:hover i {
                color: #ffffff;
            }

            .search-box .search-icon i {
                font-size: 16px;
            }

            .pname {
                text-align: left;
            }
            .tag-group {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 8px 24px; /* khoảng cách giữa hàng và giữa 2 cột */
            }

            .tag-group label {
                display: flex;
                align-items: center;
                font-size: 16px;
                gap: 8px; /* khoảng cách giữa checkbox và text */
                cursor: pointer;
            }

            .tag-group input[type="checkbox"] {
                width: 16px;
                height: 16px;
            }

            .notification {
                position: fixed;
                top: 20px;
                right: -400px;
                background-color: #4caf50;
                color: white;
                padding: 16px 24px 24px 16px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                width: 300px;
                max-width: 90%;
                z-index: 9999;
                transition: right 0.5s ease-in-out;
                overflow: hidden;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .notification.show {
                right: 20px;
            }

            .notification.hide {
                right: -400px;
            }

            .close-btn {
                position: absolute;
                top: 6px;
                right: 10px;
                font-size: 20px;
                cursor: pointer;
                color: #fff;
            }

            .timer-bar {
                position: absolute;
                bottom: 0;
                left: 0;
                height: 4px;
                background-color: rgba(255, 255, 255, 0.8);
                width: 100%;
                animation: countdown 5s linear forwards;
            }

            @keyframes countdown {
                from {
                    width: 100%;
                }
                to {
                    width: 0%;
                }
            }

        </style>

    </head>
    <body>
        <div class="container">
            <h2><b>Quản lý sản phẩm</b></h2>
            <div class="header-manange">
                <div class="row">
                    <div class="col-md-9">
                        <div class="row align-items-center">
                            <!-- Tìm kiếm: 6 cột -->
                            <div class="col-md-6">
                                <form action="manage-product" method="POST" onsubmit="return validateSearchInput()">
                                    <div class="search-box d-flex">
                                        <input value="${txtS}" type="text" id="searchInput" name="txt" placeholder="Tìm kiếm..." class="form-control">
                                        <button type="submit" class="search-icon btn btn-light">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <!-- Lọc: 4 cột -->
                            <div class="col-md-4">
                                <form action="manage-product" method="POST">
                                    <select name="sort" class="form-control" onchange="this.form.submit()">
                                        <option value="">-- Tất cả danh mục --</option>
                                        <option value="1" ${param.sort == 1 ? 'selected' : ''}>Cuốn lành mạnh</option>
                                        <option value="2" ${param.sort == 2 ? 'selected' : ''}>Ít tinh bột</option>
                                        <option value="3" ${param.sort == 3 ? 'selected' : ''}>Thuần chay đặc biệt</option>
                                    </select>
                                </form>
                            </div>

                            <!-- Thêm sản phẩm: 2 cột -->
                            <div class="col-md-2 text-end">
                                <button class="add-btn" onclick="openPopup('popup-add')">Thêm sản phẩm</button>
                            </div>
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

                <c:choose>
                    <c:when test="${empty productList}">
                        <tr><td colspan="5">Không tìm thấy kết quả phù hợp.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="p" items="${productList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td class="pname">${p.productName}</td>
                                <td><img src="${p.imageUrl}" alt="Product Image" class="pimg"></td>
                                <td>${p.price}đ</td>
                                <td>
                                    <a href="edit-product?pid=${p.productId}">
                                        <button class="edit-btn"><i class="fas fa-edit"></i></button>
                                    </a>
                                    <form action="manage-product" method="POST" onsubmit="return confirmDelete(event, '${p.productName}')">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="productId" value="${p.productId}" />
                                        <button class="delete-btn">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

            </table>
        </div>

        <form action="manage-product" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="action" value="add" />

            <div id="popup-add" class="popup">
                <div class="popup-content">

                    <div class="popup-body">
                        <h3>Thêm sản phẩm</h3>
                        <label for="name">Tên</label>
                        <input type="text" id="name" name="name" required>

                        <label for="image">Ảnh</label>
                        <input type="file" id="image" name="image" accept="image/*" required>

                        <label for="price">Giá (VND)</label>
                        <input type="number" id="price" name="price" required>

                        <label for="description">Mô tả</label>
                        <input type="text" id="description" name="description" required>

                        <label for="ingredient">Thành phần</label>
                        <input type="text" id="ingredient" name="ingredient" required>

                        <label for="weight">Khối lượng (gam)</label>
                        <input type="number" id="weight" name="weight" required>

                        <label for="calories">Lượng calo (kcal)</label>
                        <input type="number" id="calories" name="calories" required>

                        <label for="protein">Hàm lượng đạm (gam)</label>
                        <input type="number" id="protein" name="protein" required>

                        <label for="fat">Hàm lượng chất béo (gam)</label>
                        <input type="number" id="fat" name="fat" required>

                        <label for="carbs">Hàm lượng tinh bột (gam)</label>
                        <input type="number" id="carbs" name="carbs" required>

                        <label for="tags">Tag</label>
                        <div class="tag-group">
                            <label><input type="checkbox" name="tags" value="bún" /> <span>bún</span></label>
                            <label><input type="checkbox" name="tags" value="bánh tráng" /> <span>bánh tráng</span></label>
                            <label><input type="checkbox" name="tags" value="vỏ tortilla" /> <span>vỏ tortilla</span></label>
                            <label><input type="checkbox" name="tags" value="yến mạch" /> <span>yến mạch</span></label>
                            <label><input type="checkbox" name="tags" value="gà" /> <span>gà</span></label>
                            <label><input type="checkbox" name="tags" value="hải sản" /> <span>hải sản</span></label>
                            <label><input type="checkbox" name="tags" value="trứng" /> <span>trứng</span></label>
                            <label><input type="checkbox" name="tags" value="hạt" /> <span>hạt</span></label>
                            <label><input type="checkbox" name="tags" value="nấm" /> <span>nấm</span></label>
                            <label><input type="checkbox" name="tags" value="đậu hũ" /> <span>đậu hũ</span></label>
                            <label><input type="checkbox" name="tags" value="đậu que" /> <span>đậu que</span></label>
                            <label><input type="checkbox" name="tags" value="rong biển" /> <span>rong biển</span></label>
                            <label><input type="checkbox" name="tags" value="trái cây" /> <span>trái cây</span></label>
                        </div>

                        <label for="category">Danh mục</label>
                        <select id="category" name="category">
                            <option value="1">Cuốn lành mạnh</option>
                            <option value="2">Ít tinh bột</option>
                            <option value="3">Thuần chay đặc biệt</option>
                        </select>
                    </div>

                    <div class="popup-button">
                        <button type="button" class="btn-cancel" onclick="closePopup('popup-add')">Hủy</button>
                        <button type="submit" class="btn-submit">Thêm</button>
                    </div>



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

        <!--        <div id="notification" class="notification"></div>-->

        <div id="notification" class="notification">
            <span class="close-btn" onclick="hideNotification()">&times;</span>
            <span id="notification-message"></span>
            <div id="notification-timer" class="timer-bar"></div>
        </div>

        <c:if test="${not empty sessionScope.ms}">
            <script>
                localStorage.setItem("flashMessage", "${fn:escapeXml(sessionScope.ms)}");
                localStorage.removeItem("flashShown");
            </script>
            <c:remove var="ms" scope="session"/>
        </c:if>

        <script>

            window.addEventListener("DOMContentLoaded", function () {
                const message = localStorage.getItem("flashMessage");
                const shown = localStorage.getItem("flashShown");

                if (message && shown !== "true") {
                    showNotification(message);
                    localStorage.setItem("flashShown", "true");
                    // Optionally xóa luôn nếu muốn
                    setTimeout(() => {
                        localStorage.removeItem("flashMessage");
                        localStorage.removeItem("flashShown");
                    }, 6000); // sau khi notification biến mất
                } else {
                    console.log("Không gọi showNotification");
                }
            });

            function openPopup(popupId) {
                document.getElementById(popupId).style.display = "flex";
            }

            function closePopup(popupId) {
                document.getElementById(popupId).style.display = "none";
            }

            function confirmDelete(event, productName) {
                event.preventDefault(); // Ngăn chặn hành động mặc định của thẻ <a>
                let confirmation = confirm("Bạn có chắc chắn muốn xóa sản phẩm '" + productName + "' không?");
                if (confirmation) {
                    window.location.href = event.currentTarget.href; // Chuyển hướng nếu xác nhận
                }
            }

            window.onload = function () {
                var errorMessage = document.querySelector("#error-message")?.innerText;
                if (errorMessage && errorMessage.trim() !== "") {
                    document.getElementById("popupForm").style.display = "flex";
                }
            };

            function validateSearchInput() {
                var input = document.getElementById('searchInput').value.trim();
                if (input === "") {
                    return false; // Ngăn biểu mẫu được gửi đi
                }
                return true; // Cho phép gửi biểu mẫu
            }

            let timeoutId = null;

            function showNotification(message) {
                const noti = document.getElementById("notification");
                const messageEl = document.getElementById("notification-message");
                const timerBar = document.getElementById("notification-timer");

                messageEl.innerText = message;
                noti.classList.add("show");
                noti.classList.remove("hide");

                // Reset animation bar
                timerBar.style.animation = "none";
                timerBar.offsetHeight; // trigger reflow
                timerBar.style.animation = "countdown 5s linear forwards";

                clearTimeout(timeoutId);
                timeoutId = setTimeout(() => {
                    hideNotification();
                }, 5000);
            }

            function hideNotification() {
                const noti = document.getElementById("notification");
                noti.classList.remove("show");
                noti.classList.add("hide");
            }

            window.addEventListener("load", function () {
                // Nếu server có truyền message xuống, thì show notification
                if (typeof serverMessage !== "undefined" && serverMessage.trim() !== "") {
                    showNotification(serverMessage);
                }

                const errorMessage = document.querySelector("#error-message")?.innerText;
                if (errorMessage && errorMessage.trim() !== "") {
                    document.getElementById("popupForm").style.display = "flex";
                }
            });

            function confirmDelete(event, productName) {
                let confirmation = confirm("Bạn có chắc chắn muốn xóa sản phẩm '" + productName + "' không?");
                if (!confirmation) {
                    event.preventDefault(); // Hủy gửi form nếu người dùng không xác nhận
                    return false;
                }
                // Nếu xác nhận, cho phép form gửi đi
                return true;
            }

            if (!localStorage.getItem("flashMessage")) {
                localStorage.setItem("flashMessage", "${fn:escapeXml(sessionScope.ms)}");
                localStorage.removeItem("flashShown");
            }
        </script>

    </body>
</html>
