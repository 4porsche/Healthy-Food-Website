<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Panel - Healthy Food</title>
        <style>
            :root {
                --primary: #4CAF50;
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

            /* CRUD Actions */
            .crud-actions {
                display: flex;
                gap: 10px;
                margin-top: 15px;
                flex-wrap: wrap;
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
            .admin-info {
                position: relative;
                cursor: pointer;
            }

            .logout-dropdown a {
                display: block;
                padding: 10px 15px;
                color: #333;
                text-decoration: none;
                white-space: nowrap;
            }

            .logout-dropdown a:hover {
                background-color: #f5f5f5;
            }
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h3>Healthy Food</h3>
            </div>
            <div class="sidebar-menu">
                <a href="AdminServlet?action=view">
                    <i class="fas fa-users"></i> Xem Người Dùng
                </a>
                <button onclick="document.getElementById('searchForm').scrollIntoView({behavior: 'smooth'});">
                    <i class="fas fa-search"></i> Tìm Tài Khoản
                </button>
            </div>
        </div>

        <div class="main-content">
            <div class="header">
                <h2>Bảng Điều Khiển Admin</h2>
                <div class="admin-dropdown">
                    <div class="admin-info" id="adminInfo">
                        <div class="admin-avatar">Q</div>
                        <div>
                            <h4>Quản Trị Viên</h4>
                            <p>Administrator</p>
                        </div>
                    </div>
                    <div class="dropdown-content" id="dropdownContent">
                       
                    </div>
                </div>
            </div>

            <!-- Tìm kiếm tài khoản -->
            <div class="section" id="searchForm">
                <h3><i class="fas fa-search"></i> Tìm Kiếm Tài Khoản</h3>
                <form action="AdminServlet" method="get" style="margin-bottom: 20px;">
                    <input type="hidden" name="action" value="search">
                    <div class="form-row">
                        <div class="form-group" style="flex: 3;">
                            <label for="searchQuery">Tìm theo từ khóa:</label>
                            <input type="text" id="searchQuery" name="query" placeholder="Tìm theo tên, email, tên đăng nhập...">
                        </div>
                        <div class="form-group" style="flex: 1; align-self: flex-end;">
                            <button type="submit" class="btn-primary" style="width: 100%;">
                                <i class="fas fa-search"></i> Tìm Kiếm
                            </button>
                        </div>
                    </div>
                </form>

                <form action="AdminServlet" method="get">
                    <input type="hidden" name="action" value="filter">
                    <div class="form-row">
                        <div class="form-group" style="flex: 3;">
                            <label for="filterRoleId">Lọc theo vai trò:</label>
                            <select id="filterRoleId" name="roleId">
                                <option value="all" selected>Tất cả vai trò</option>
                                <option value="1">Quản trị viên</option>
                                <option value="3">Khách hàng</option>
                                <option value="4">Chuyên gia dinh dưỡng</option>
                                <option value="5">Người bán</option>
                                <option value="6">Người giao hàng</option>
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

            <!-- Danh sách tài khoản -->
            <div class="section">
                <div class="add-account-btn">
                    <button class="btn-primary" onclick="showAddAccountForm()">
                        <i class="fas fa-plus-circle"></i> Thêm Tài Khoản
                    </button>
                </div>

                <h3><i class="fas fa-list"></i> Danh Sách Tài Khoản</h3>
                <%
                    List<User> users = (List<User>) request.getAttribute("userList");
                    if (users == null || users.isEmpty()) {
                        out.println("<div style='padding: 20px; text-align: center; background: #f9f9f9; border-radius: 8px;'>");
                        out.println("<i class='fas fa-exclamation-circle' style='font-size: 2rem; color: #FF9800; margin-bottom: 15px;'></i>");
                        out.println("<h3 style='color: #555;'>Không tìm thấy người dùng</h3>");
                        out.println("<p>Hiện không có dữ liệu người dùng</p>");
                        out.println("</div>");
                    } else {
                %>
                <table>
                    <thead>
                        <tr>
                            <th>ID Người Dùng</th>
                            <th>Họ Tên</th>
                            <th>Tên Đăng Nhập</th>
                            <th>Email</th>
                            <th>Số Điện Thoại</th> <!-- Thêm cột Số Điện Thoại -->
                            <th>Vai Trò</th>
                            <th>Trạng Thái</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (User user : users) {
                                String roleName = "";
                                switch(user.getRoleID()) {
                                    case 1: roleName = "Quản trị"; break;
                                    case 3: roleName = "Khách hàng"; break;
                                    case 4: roleName = "Dinh dưỡng"; break;
                                    case 5: roleName = "Người bán"; break;
                                    case 6: roleName = "Giao hàng"; break;
                                    default: roleName = "Khác";
                                }
                        %>
                        <tr>
                            <td><%= user.getUserID() %></td>
                            <td><%= user.getFullname() != null ? user.getFullname() : "N/A" %></td>
                            <td><%= user.getUsername() != null ? user.getUsername() : "N/A" %></td>
                            <td><%= user.getEmail() != null ? user.getEmail() : "N/A" %></td>
                            <td><%= user.getPhone() != null ? user.getPhone() : "N/A" %></td> <!-- Hiển thị số điện thoại -->
                            <td><%= roleName %></td>
                            <td>
                                <% if(user.isIsActive()) { %>
                                <span class="status-active">Hoạt động</span>
                                <% } else { %>
                                <span class="status-inactive">Vô hiệu</span>
                                <% } %>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-secondary btn-sm" onclick="showEditForm(
                                                    '<%= user.getUserID() %>',
                                                    '<%= user.getFullname() != null ? user.getFullname().replace("'", "\\'") : "" %>',
                                                    '<%= user.getUsername() != null ? user.getUsername().replace("'", "\\'") : "" %>',
                                                    '<%= user.getEmail() != null ? user.getEmail().replace("'", "\\'") : "" %>',
                                                    '<%= user.getPhone() != null ? user.getPhone().replace("'", "\\'") : "" %>', <!-- Thêm phone -->
                                                    '<%= user.getRoleID() %>',
                                                    '<%= user.isIsActive() %>'
                                                    )">
                                        <i class="fas fa-edit"></i> Sửa
                                    </button>
                                    <form action="AdminServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="crud">
                                        <input type="hidden" name="crudAction" value="delete">
                                        <input type="hidden" name="userId" value="<%= user.getUserID() %>">
                                        <button type="submit" class="btn-danger btn-sm">
                                            <i class="fas fa-trash-alt"></i> Xóa
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
                <% 
                    }
                %>
            </div>

            <!-- Form thêm tài khoản -->
            <div class="section" id="addAccountForm" style="display: none;">
                <h3><i class="fas fa-user-plus"></i> Thêm Tài Khoản Mới</h3>
                <form action="AdminServlet" method="post">
                    <input type="hidden" name="action" value="crud">
                    <input type="hidden" name="crudAction" value="create">

                    <div class="form-row">
                        <div class="form-group">
                            <label for="addFullname">Họ và tên:</label>
                            <input type="text" id="addFullname" name="fullname" required placeholder="Nhập họ tên đầy đủ">
                        </div>
                        <div class="form-group">
                            <label for="addUsername">Tên đăng nhập:</label>
                            <input type="text" id="addUsername" name="username" required placeholder="Nhập tên đăng nhập">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="addEmail">Email:</label>
                            <input type="email" id="addEmail" name="email" required placeholder="Nhập địa chỉ email">
                        </div>
                        <div class="form-group">
                            <label for="addPhone">Số điện thoại:</label> <!-- Thêm trường phone -->
                            <input type="tel" id="addPhone" name="phone" required placeholder="Nhập số điện thoại">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="addPassword">Mật khẩu:</label>
                            <input type="password" id="addPassword" name="password" required placeholder="Nhập mật khẩu">
                        </div>
                        <div class="form-group">
                            <label for="addRoleId">Vai trò:</label>
                            <select id="addRoleId" name="roleId" required>
                                <option value="" disabled selected>Chọn vai trò</option>
                                <option value="1">Quản trị viên</option>
                                <option value="3">Khách hàng</option>
                                <option value="4">Chuyên gia dinh dưỡng</option>
                                <option value="5">Người bán</option>
                                <option value="6">Người giao hàng</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="addActive">Trạng thái tài khoản:</label>
                            <div style="margin-top: 10px;">
                                <input type="checkbox" id="addActive" name="isActive" checked style="width: auto; margin-right: 10px;">
                                <label for="addActive" style="display: inline; font-weight: normal;">Tài khoản hoạt động</label>
                            </div>
                        </div>
                    </div>

                    <div class="crud-actions">
                        <button type="submit" class="btn-primary">
                            <i class="fas fa-plus-circle"></i> Tạo Tài Khoản
                        </button>
                        <button type="button" class="btn-outline" onclick="hideAddAccountForm()">
                            <i class="fas fa-times"></i> Hủy
                        </button>
                    </div>
                </form>
            </div>

            <!-- Form chỉnh sửa tài khoản -->
            <div class="section" id="editAccountForm" style="display: none;">
                <h3><i class="fas fa-user-edit"></i> Chỉnh Sửa Tài Khoản</h3>
                <form action="AdminServlet" method="post">
                    <input type="hidden" name="action" value="crud">
                    <input type="hidden" name="crudAction" value="update">
                    <input type="hidden" id="editUserId" name="userId">

                    <div class="form-row">
                        <div class="form-group">
                            <label for="editFullname">Họ và tên:</label>
                            <input type="text" id="editFullname" name="fullname" required placeholder="Nhập họ tên đầy đủ">
                        </div>
                        <div class="form-group">
                            <label for="editUsername">Tên đăng nhập:</label>
                            <input type="text" id="editUsername" name="username" required placeholder="Nhập tên đăng nhập">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="editEmail">Email:</label>
                            <input type="email" id="editEmail" name="email" required placeholder="Nhập địa chỉ email">
                        </div>
                        <div class="form-group">
                            <label for="editPhone">Số điện thoại:</label> <!-- Thêm trường phone -->
                            <input type="tel" id="editPhone" name="phone" required placeholder="Nhập số điện thoại">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="editPassword">Mật khẩu (để trống nếu giữ nguyên):</label>
                            <input type="password" id="editPassword" name="password" placeholder="Nhập mật khẩu mới">
                        </div>
                        <div class="form-group">
                            <label for="editRoleId">Vai trò:</label>
                            <select id="editRoleId" name="roleId" required>
                                <option value="1">Quản trị viên</option>
                                <option value="3">Khách hàng</option>
                                <option value="4">Chuyên gia dinh dưỡng</option>
                                <option value="5">Người bán</option>
                                <option value="6">Người giao hàng</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="editActive">Trạng thái tài khoản:</label>
                            <div style="margin-top: 10px;">
                                <input type="checkbox" id="editActive" name="isActive" style="width: auto; margin-right: 10px;">
                                <label for="editActive" style="display: inline; font-weight: normal;">Tài khoản hoạt động</label>
                            </div>
                        </div>
                    </div>

                    <div class="crud-actions">
                        <button type="submit" class="btn-secondary">
                            <i class="fas fa-sync-alt"></i> Cập Nhật
                        </button>
                        <button type="button" class="btn-outline" onclick="hideEditAccountForm()">
                            <i class="fas fa-times"></i> Hủy
                        </button>
                    </div>
                </form>
            </div>

            <!-- Activate/Disable Account Section -->
            <div class="section" id="toggleForm">
                <!-- ... existing toggle form ... -->
            </div>

            <!-- Assign Roles and Permissions Section -->
            <div class="section" id="assignRoleForm">
                <!-- ... existing assign role form ... -->
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const adminInfo = document.querySelector('.admin-info');

                // Tạo dropdown menu
                const dropdown = document.createElement('div');
                dropdown.className = 'logout-dropdown';
                dropdown.innerHTML = '<a href="#" id="logoutLink">Đăng xuất</a>';
                dropdown.style.display = 'none';
                dropdown.style.position = 'absolute';
                dropdown.style.backgroundColor = '#fff';
                dropdown.style.boxShadow = '0 2px 10px rgba(0,0,0,0.1)';
                dropdown.style.borderRadius = '4px';
                dropdown.style.overflow = 'hidden';
                dropdown.style.zIndex = '1000';

                // Thêm dropdown vào DOM
                adminInfo.parentNode.insertBefore(dropdown, adminInfo.nextSibling);

                // Xử lý sự kiện click avatar
                const adminAvatar = document.querySelector('.admin-avatar');
                adminAvatar.addEventListener('click', function (e) {
                    e.stopPropagation();
                    dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
                });

                // Xử lý sự kiện click đăng xuất
                document.getElementById('logoutLink').addEventListener('click', function (e) {
                    e.preventDefault();
                    window.location.href = 'LogoutServlet'; // Gọi servlet đăng xuất
                });

                // Đóng dropdown khi click bất kỳ đâu
                document.addEventListener('click', function () {
                    dropdown.style.display = 'none';
                });

                // Ngăn đóng dropdown khi click vào dropdown
                dropdown.addEventListener('click', function (e) {
                    e.stopPropagation();
                });
            });
            // Function to show/hide add account form
            function showAddAccountForm() {
                document.getElementById('addAccountForm').style.display = 'block';
                document.getElementById('addAccountForm').scrollIntoView({behavior: 'smooth'});
            }

            function hideAddAccountForm() {
                document.getElementById('addAccountForm').style.display = 'none';
            }

            // Function to show/hide edit account form
            function showEditForm(userId, fullname, username, email, roleId, isActive) {
                document.getElementById('editUserId').value = userId;
                document.getElementById('editFullname').value = fullname;
                document.getElementById('editUsername').value = username;
                document.getElementById('editEmail').value = email;
                document.getElementById('editRoleId').value = roleId;
                document.getElementById('editActive').checked = (isActive === 'true');

                document.getElementById('editAccountForm').style.display = 'block';
                document.getElementById('editAccountForm').scrollIntoView({behavior: 'smooth'});
            }

            function hideEditAccountForm() {
                document.getElementById('editAccountForm').style.display = 'none';
                // Function to show/hide edit account form (cập nhật thêm phone)
            function showEditForm(userId, fullname, username, email, phone, roleId, isActive) {
                document.getElementById('editUserId').value = userId;
                document.getElementById('editFullname').value = fullname;
                document.getElementById('editUsername').value = username;
                document.getElementById('editEmail').value = email;
                document.getElementById('editPhone').value = phone; // Thiết lập giá trị phone
                document.getElementById('editRoleId').value = roleId;
                document.getElementById('editActive').checked = (isActive === 'true');

                document.getElementById('editAccountForm').style.display = 'block';
                document.getElementById('editAccountForm').scrollIntoView({behavior: 'smooth'});
            }
            }
        </script>
    </body>

</html>