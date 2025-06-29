<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h3>Healthy Food Người Bán</h3>
            </div>
            <div class="sidebar-menu">
                <a href="seller-dashboard?action=report">
                    <i class="fas fa-chart-simple"></i>Thống kê
                </a>

                <a href="manage-product">
                    <i class="fas fa-pen"></i>Quản lý sản phẩm
                </a>

                <a href="seller-dashboard?action=product">
                    <i class="fas fa-pen"></i>Quản lý sản phẩm #
                </a>

                <a href="home">
                    <i class="fas fa-home"></i>Trang chủ
                </a>
            </div>
        </div>

        <div class="main-content">
    <%
        String action = request.getParameter("action");
        if ("report".equals(action)) {
    %>
        <jsp:include page="report.jsp" />
    <%
        } else if ("product".equals(action)) {
    %>
        <jsp:include page="manage-product1.jsp" />
    <%
        } else {
    %>
        <jsp:include page="home.jsp" />
    <%
        }
    %>
</div>

        <script>
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
            }
        </script>
    </body>

</html>