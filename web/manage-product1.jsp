<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Seller Panel - Healthy Food</title>
        <style>
            :root {
                --primary: #3C603C;
                --primary-dark: #388E3C;
                --primary-light: #C8E6C9;
                --secondary: #FF9800;
                --secondary-light: #FFE0B2;
                --danger: #F44336;
                --danger-light: #FFCDD2;
                --light-gray: #f5f5f5;
                --medium-gray: #e0e0e0;
                --dark-gray: #424242;
                --white: #ffffff;
                --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                --transition: all 0.3s ease;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f9fbfa;
                color: #333;
                line-height: 1.6;
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar Styling */
            .sidebar {
                width: 280px;
                background: linear-gradient(to bottom, var(--primary), var(--primary-dark));
                color: var(--white);
                padding: 25px 0;
                height: 100vh;
                position: fixed;
                overflow-y: auto;
                box-shadow: var(--shadow);
                z-index: 100;
            }

            .sidebar-header {
                padding: 0 25px 20px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                margin-bottom: 20px;
            }

            .sidebar-header h3 {
                font-size: 1.8rem;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .sidebar-header h3::before {
                content: "🍎";
                font-size: 1.5rem;
            }

            .sidebar-menu {
                padding: 0 15px;
            }

            .sidebar a, .sidebar button {
                display: flex;
                align-items: center;
                gap: 12px;
                width: 100%;
                padding: 14px 20px;
                margin: 8px 0;
                border: none;
                background: rgba(255, 255, 255, 0.1);
                color: var(--white);
                text-align: left;
                cursor: pointer;
                text-decoration: none;
                border-radius: 8px;
                font-size: 1.05rem;
                font-weight: 500;
                transition: var(--transition);
            }

            .sidebar a:hover, .sidebar button:hover {
                background: rgba(255, 255, 255, 0.2);
                transform: translateX(5px);
            }

            .sidebar a i, .sidebar button i {
                width: 24px;
                text-align: center;
            }

            /* Main Content Styling */
            .main-content {
                margin-left: 280px;
                padding: 30px;
                width: calc(100% - 280px);
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                padding-bottom: 20px;
                border-bottom: 1px solid var(--medium-gray);
            }

            .header h2 {
                font-size: 2.2rem;
                color: var(--primary-dark);
                font-weight: 700;
            }

            .admin-info {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .admin-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background-color: var(--primary);
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.4rem;
                font-weight: bold;
            }

            /* Section Styling */
            .section {
                background: var(--white);
                border-radius: 12px;
                box-shadow: var(--shadow);
                padding: 25px;
                margin-bottom: 30px;
                transition: var(--transition);
            }

            .section:hover {
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
            }

            .section h3 {
                font-size: 1.5rem;
                color: var(--primary-dark);
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 2px solid var(--primary-light);
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .section h3 i {
                color: var(--secondary);
            }

            /* Form Styling */
            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: var(--dark-gray);
            }

            input[type="text"],
            input[type="email"],
            input[type="number"],
            input[type="password"],
            select {
                width: 100%;
                padding: 14px;
                border: 1px solid var(--medium-gray);
                border-radius: 8px;
                font-size: 1rem;
                transition: var(--transition);
            }

            input:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.2);
            }

            .form-row {
                display: flex;
                gap: 20px;
                margin-bottom: 15px;
            }

            .form-row .form-group {
                flex: 1;
            }

            /* Button Styling */
            button, .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }

            .btn-primary {
                background-color: var(--primary);
                color: white;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                transform: translateY(-2px);
            }

            .btn-secondary {
                background-color: var(--secondary);
                color: white;
            }

            .btn-secondary:hover {
                background-color: #F57C00;
                transform: translateY(-2px);
            }

            .btn-danger {
                background-color: var(--danger);
                color: white;
            }

            .btn-danger:hover {
                background-color: #D32F2F;
                transform: translateY(-2px);
            }

            .btn-outline {
                background-color: transparent;
                border: 2px solid var(--primary);
                color: var(--primary);
            }

            .btn-outline:hover {
                background-color: var(--primary-light);
            }

            /* Table Styling */
            table {
                border-collapse: collapse;
                width: 100%;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            th {
                background-color: var(--primary);
                color: white;
                text-align: left;
                padding: 16px;
                font-weight: 600;
            }

            td {
                padding: 14px 16px;
                border-bottom: 1px solid var(--medium-gray);
            }

            tr:nth-child(even) {
                background-color: var(--light-gray);
            }

            tr:hover {
                background-color: var(--primary-light);
            }

            .status-active {
                display: inline-block;
                padding: 5px 12px;
                background-color: #E8F5E9;
                color: #2E7D32;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 600;
            }

            .status-inactive {
                display: inline-block;
                padding: 5px 12px;
                background-color: #FFEBEE;
                color: #C62828;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 600;
            }

            .pimg {
                width: 170px;
                height: 170px;
                object-fit: cover;
                border-radius: 5px;
            }


            /* CRUD Actions */
            .crud-actions {
                display: flex;
                gap: 10px;
                margin-top: 15px;
                flex-wrap: wrap;
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

            /* Responsive Design */
            @media (max-width: 992px) {
                .sidebar {
                    width: 250px;
                }

                .main-content {
                    margin-left: 250px;
                    width: calc(100% - 250px);
                }
            }

            @media (max-width: 768px) {
                body {
                    flex-direction: column;
                }

                .sidebar {
                    width: 100%;
                    height: auto;
                    position: relative;
                }

                .main-content {
                    margin-left: 0;
                    width: 100%;
                }

                .form-row {
                    flex-direction: column;
                    gap: 0;
                }
                .action-buttons {
                    display: flex;
                    gap: 8px;
                }

                .btn-sm {
                    padding: 6px 12px;
                    font-size: 0.9rem;
                }

                .add-account-btn {
                    margin-bottom: 20px;
                }

            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>

        <div id="searchForm">
            <h3><i class="fas fa-search"></i>Tìm kiếm sản phẩm</h3>

            <form action="seller-dashboard" style="margin-bottom: 20px;">
                <input type="hidden" name="action" value="product">
                <input type="hidden" name="subaction" value="search">
                <div class="form-row">
                    <div class="form-group" style="flex: 3;">
                        <input value="${txtS}" type="text" id="searchQuery" name="txt" placeholder="Tìm kiếm sản phẩm...">
                    </div>
                    <div class="form-group" style="flex: 1; align-self: flex-end;">
                        <button type="submit" class="btn-primary" style="width: 100%;">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                    </div>
                </div>
            </form>

            <form action="seller-dashboard">
                <input type="hidden" name="action" value="product">
                <input type="hidden" name="subaction" value="filter">
                <div class="form-row">
                    <div class="form-group" style="flex: 3;">
                        <label>Lọc theo danh mục:</label>
                        <select name="sort">
                            <option value="" selected>-- Tất cả danh mục --</option>
                            <option value="1" ${param.sort == '1' ? 'selected' : ''}>Cuốn lành mạnh</option>
                            <option value="2" ${param.sort == '2' ? 'selected' : ''}>Ít tinh bột</option>
                            <option value="3" ${param.sort == '3' ? 'selected' : ''}>Thuần chay đặc biệt</option>
                        </select>
                    </div>
                    <div class="form-group" style="flex: 1; align-self: flex-end;">
                        <button type="submit" class="btn-outline" style="width: 100%;">
                            <i class="fas fa-filter"></i> Lọc
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- View Account List Section -->
        <div class="section">
            <div class="add-account-btn">
                <!--                <button class="btn-primary" onclick="showAddAccountForm()">-->
                <button class="btn-primary" onclick="openPopup('popup-add')">
                    <i class="fas fa-plus-circle"></i> Thêm sản phẩm
                </button>
            </div>

            <h3><i class="fas fa-list"></i> User Accounts</h3>
            <c:choose>
                <c:when test="${empty productList}">
                    <div style='padding: 20px; text-align: center; background: #f9f9f9; border-radius: 8px;'>
                        <i class='fas fa-exclamation-circle' style='font-size: 2rem; color: #FF9800; margin-bottom: 15px;'></i>
                        <h3 style='color: #555;'>No users found</h3>
                        <p>No user data is available at this time</p>
                    </div>
                </c:when>
                <c:otherwise>
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
                            <c:forEach var="p" items="${productList}" varStatus="status">
                                <tr class="product-row">
                                    <td>${status.index + 1}</td>
                                    <td class="pname">${p.productName}</td>
                                    <td><img src="${p.imageUrl}" alt="Product Image" class="pimg"></td>
                                    <td>${p.price}đ</td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-secondary btn-sm" onclick="showEditForm(
                                                            '${p.productId}',
                                                            '${fn:replace(p.categoryId, "'", "\\'")}',
                                                            '${fn:replace(p.productName, "'", "\\'")}',
                                                            '${fn:replace(p.price, "'", "\\'")}',
                                                            '${fn:replace(p.description, "'", "\\'")}',
                                                            '${fn:replace(p.ingredient, "'", "\\'")}',
                                                            '${p.weight}',
                                                            '${p.calories}',
                                                            '${p.protein}',
                                                            '${p.fat}',
                                                            '${p.carbs}',
                                                            '${fn:replace(p.tags, "'", "\\'")}',
                                                            '${fn:replace(p.imageUrl, "'", "\\'")}'
                                                            )">
                                                <i class="fas fa-edit"></i> Edit
                                            </button>
                                            <form action=admin-dashboard" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="crud">
                                                <input type="hidden" name="crudAction" value="delete">
                                                <input type="hidden" name="userId" value="${p.productId}">
                                                <button type="submit" class="btn-danger btn-sm">
                                                    <i class="fas fa-trash-alt"></i> Delete
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>


                        </tbody>
                    </table>

                </c:otherwise>
            </c:choose>
        </div>

        <form action="seller-dashboard" method="POST" enctype="multipart/form-data">
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
        
        <!-- Add Account Form (Initially Hidden) -->
        <div class="section" id="addProductForm" style="display: none;">
            <h3><i class="fas fa-user-plus"></i> Add New Account</h3>
            <form action="admin-dashboard" method="post">
                <input type="hidden" name="action" value="crud">
                <input type="hidden" name="crudAction" value="create">

                <div class="form-row">
                    <div class="form-group">
                        <label for="addFullname">Full Name:</label>
                        <input type="text" id="addFullname" name="fullname" required placeholder="Enter full name">
                    </div>
                    <div class="form-group">
                        <label for="addUsername">Username:</label>
                        <input type="text" id="addUsername" name="username" required placeholder="Enter username">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="addEmail">Email:</label>
                        <input type="email" id="addEmail" name="email" required placeholder="Enter email">
                    </div>
                    <div class="form-group">
                        <label for="addPassword">Password:</label>
                        <input type="password" id="addPassword" name="password" required placeholder="Enter password">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="addRoleId">Role:</label>
                        <select id="addRoleId" name="roleId" required>
                            <option value="" disabled selected>Select a role</option>
                            <option value="1">Administrator</option>
                            <option value="3">Customer</option>
                            <option value="4">Nutritionist</option>
                            <option value="5">Seller</option>
                            <option value="6">Shipper</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="addActive">Account Status:</label>
                        <div style="margin-top: 10px;">
                            <input type="checkbox" id="addActive" name="isActive" checked style="width: auto; margin-right: 10px;">
                            <label for="addActive" style="display: inline; font-weight: normal;">Active Account</label>
                        </div>
                    </div>
                </div>

                <div class="crud-actions">
                    <button type="submit" class="btn-primary">
                        <i class="fas fa-plus-circle"></i> Create Account
                    </button>
                    <button type="button" class="btn-outline" onclick="hideAddAccountForm()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </form>
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
            
            // Function to show/hide add account form
            function showAddAccountForm() {
                document.getElementById('addAccountForm').style.display = 'block';
                document.getElementById('addAccountForm').scrollIntoView({behavior: 'smooth'});
            }

            function hideAddAccountForm() {
                document.getElementById('addAccountForm').style.display = 'none';
            }

            // Function to show/hide edit product form
            function showEditForm(productId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl) {
                document.getElementById('editProductId').value = productId;
                document.getElementByategoryId').value = categoryId;
                        document.getElementById('editProductName').value = productName;
                document.getElementById('editPrice').value = price;
                document.getElementById('editDescription').value = description;
                document.getElementById('editIngredient').value = ingredient;
                document.getElementById('editWeight').value = weight;
                document.getElementById('editCalories').value = calories;
                document.getElementById('editProtein').value = protein;
                document.getElementById('editFat').value = fat;
                document.getElementById('editCarbs').value = carbs;
                document.getElementById('editTags').value = tags;
                document.getElementById('editImageUrl').value = imageUrl;

                document.getElementById('editAccountForm').style.display = 'block';
                document.getElementById('editAccountForm').scrollIntoView({behavior: 'smooth'});
            }

            function hideEditAccountForm() {
                document.getElementById('editAccountForm').style.display = 'none';
            }
        </script>
    </body>

</html>
