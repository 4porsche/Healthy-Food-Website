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
            body {
                background-color: #f8f9fa;
                padding: 30px 0;
            }

            .form-container {
                max-width: 600px;
                margin: auto;
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                font-weight: bold;
                margin-bottom: 25px;
                color: #3C603C;
            }

            label {
                font-weight: 500;
            }

            .form-control, #category {
                border-radius: 8px;
            }

            #category {
                height: 45px;
            }

            .btn-success {
                width: 100%;
                padding: 12px;
                font-size: 16px;
                font-weight: 600;
                border-radius: 10px;
            }

            .btn-close-custom {
                float: right;
                border: none;
                background: none;
                font-size: 24px;
                color: #aaa;
                cursor: pointer;
            }

            .btn-close-custom:hover {
                color: #000;
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

        <div class="form-container">
            <!--            <button class="btn-close-custom" onclick="window.history.back();">&times;</button>-->

            <!--            <button class="btn-close-custom" onclick="handleBack();">&times;</button>-->

            <button class="btn-close-custom" id="backBtn">&times;</button>


            <h2>Sửa sản phẩm</h2>
            <form action="edit-product" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${detail.productId}" />
                <div class="mb-3">
                    <label>Tên</label>
                    <input value="${detail.productName}" name="name" type="text" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Ảnh</label>
                    <input value="${detail.imageUrl}" name="image" type="file" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Giá (VND)</label>
                    <input value="${detail.price}" name="price" type="text" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Mô tả</label>
                    <input value="${detail.description}" name="description" type="text" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Thành phần</label>
                    <input value="${detail.ingredient}" name="ingredient" type="text" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Khối lượng (gam)</label>
                    <input value="${detail.weight}" name="weight" type="number" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Lượng calo (kcal)</label>
                    <input value="${detail.calories}" name="calories" type="number" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Hàm lượng đạm (gam)</label>
                    <input value="${detail.protein}" name="protein" type="number" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Hàm lượng chất béo (gam)</label>
                    <input value="${detail.fat}" name="fat" type="number" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label>Hàm lượng tinh bột (gam)</label>
                    <input value="${detail.carbs}" name="carbs" type="number" class="form-control" required>
                </div>

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

                <div class="mb-4">
                    <label>Danh mục</label>
                    <select id="category" name="category" class="form-select">
                        <option value="1" ${detail.categoryId == 1 ? 'selected' : ''}>Cuốn lành mạnh</option>
                        <option value="2" ${detail.categoryId == 2 ? 'selected' : ''}>Ít tinh bột</option>
                        <option value="3" ${detail.categoryId == 3 ? 'selected' : ''}>Thuần chay đặc biệt</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-success">Cập nhật sản phẩm</button>
            </form>
        </div>

        <div id="notification" class="notification">
            <span class="close-btn" onclick="hideNotification()">&times;</span>
            <span id="notification-message"></span>
            <div id="notification-timer" class="timer-bar"></div>
        </div>

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

            window.addEventListener("DOMContentLoaded", function () {
                const isSubmitted = ${submitted != null ? 'true' : 'false'};
                const backBtn = document.getElementById("backBtn");

                if (backBtn) {
                    backBtn.onclick = function () {
                        // 💥 Dọn flashMessage để khi quay lại không bị hiển thị message cũ
                        localStorage.removeItem("flashMessage");
                        localStorage.removeItem("flashShown");

                        if (isSubmitted) {
                            window.location.href = "manage-product";
                        } else {
                            window.history.back();
                        }
                    };
                }
            });





        </script>

        <c:if test="${not empty ms}">
            <script>
//                alert("Thông báo: ${fn:escapeXml(ms)}");
                showNotification("${ms}");

            </script>
        </c:if>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
