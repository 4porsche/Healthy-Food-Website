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
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <h3>Healthy Food Admin</h3>
        </div>
        <div class="sidebar-menu">
            <a href="AdminServlet?action=view">
                <i class="fas fa-users"></i> View Users
            </a>
            <button onclick="document.getElementById('toggleForm').scrollIntoView({behavior: 'smooth'});">
                <i class="fas fa-toggle-on"></i> Activate/Disable Account
            </button>
            <button onclick="document.getElementById('assignRoleForm').scrollIntoView({behavior: 'smooth'});">
                <i class="fas fa-user-tag"></i> Assign Roles
            </button>
            <button onclick="document.getElementById('crudForm').scrollIntoView({behavior: 'smooth'});">
                <i class="fas fa-user-cog"></i> CRUD Account
            </button>
            <button onclick="document.getElementById('searchForm').scrollIntoView({behavior: 'smooth'});">
                <i class="fas fa-search"></i> Search Account
            </button>
        </div>
    </div>

    <div class="main-content">
        <div class="header">
            <h2>Admin Dashboard</h2>
            <div class="admin-info">
                <div class="admin-avatar">A</div>
                <div>
                    <h4>Admin User</h4>
                    <p>Administrator</p>
                </div>
            </div>
        </div>

        <!-- Activate/Disable Account Section -->
        <div class="section" id="toggleForm">
            <h3><i class="fas fa-toggle-on"></i> Activate/Disable Account</h3>
            <form action="AdminServlet" method="post">
                <input type="hidden" name="action" value="toggleActive">
                <div class="form-group">
                    <label for="toggleEmail">Email to Toggle:</label>
                    <input type="email" id="toggleEmail" name="email" required placeholder="Enter user email">
                </div>
                <button type="submit" class="btn-primary">
                    <i class="fas fa-sync-alt"></i> Toggle Status
                </button>
            </form>
        </div>

        <!-- Assign Roles and Permissions Section -->
        <div class="section" id="assignRoleForm">
            <h3><i class="fas fa-user-tag"></i> Assign Roles and Permissions</h3>
            <form action="AdminServlet" method="post">
                <input type="hidden" name="action" value="assignRole">
                <div class="form-row">
                    <div class="form-group">
                        <label for="assignEmail">Email:</label>
                        <input type="email" id="assignEmail" name="email" required placeholder="Enter user email">
                    </div>
                    <div class="form-group">
                        <label for="roleId">Role:</label>
                        <select id="roleId" name="roleId" required>
                            <option value="" disabled selected>Select a role</option>
                            <option value="1">Administrator</option>
                            
                            <option value="3">Customer</option>
                            <option value="4">Nutritionist</option>
                            <option value="5">Seller</option>
                            <option value="6">Shipper</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn-secondary">
                    <i class="fas fa-check-circle"></i> Assign Role
                </button>
            </form>
        </div>

        <!-- View Account List Section -->
        <div class="section">
            <h3><i class="fas fa-list"></i> User Accounts</h3>
            <%
                List<User> users = (List<User>) request.getAttribute("userList");
                if (users == null || users.isEmpty()) {
                    out.println("<div style='padding: 20px; text-align: center; background: #f9f9f9; border-radius: 8px;'>");
                    out.println("<i class='fas fa-exclamation-circle' style='font-size: 2rem; color: #FF9800; margin-bottom: 15px;'></i>");
                    out.println("<h3 style='color: #555;'>No users found</h3>");
                    out.println("<p>No user data is available at this time</p>");
                    out.println("</div>");
                } else {
            %>
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Full Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        for (User user : users) {
                            String roleName = "";
                            switch(user.getRoleID()) {
                                case 1: roleName = "Admin"; break;
                                
                                case 3: roleName = "Customer"; break;
                                case 4: roleName = "Nutritionist"; break;
                                case 5: roleName = "Seller"; break;
                                case 6: roleName = "Shipper"; break;
                                default: roleName = "Unknown";
                            }
                    %>
                    <tr>
                        <td><%= user.getUserID() %></td>
                        <td><%= user.getFullname() != null ? user.getFullname() : "N/A" %></td>
                        <td><%= user.getUsername() != null ? user.getUsername() : "N/A" %></td>
                        <td><%= user.getEmail() != null ? user.getEmail() : "N/A" %></td>
                        <td><%= roleName %></td>
                        <td>
                            <% if(user.isIsActive()) { %>
                                <span class="status-active">Active</span>
                            <% } else { %>
                                <span class="status-inactive">Inactive</span>
                            <% } %>
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

        <!-- CRUD Account Section -->
        <div class="section" id="crudForm">
            <h3><i class="fas fa-user-cog"></i> Manage Accounts</h3>
            <form action="AdminServlet" method="post">
                <input type="hidden" name="action" value="crud">
                <div class="form-row">
                    <div class="form-group">
                        <label for="crudUserId">User ID:</label>
                        <input type="number" id="crudUserId" name="userId" required placeholder="Enter user ID">
                    </div>
                    <div class="form-group">
                        <label for="crudFullname">Full Name:</label>
                        <input type="text" id="crudFullname" name="fullname" placeholder="Enter full name">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="crudUsername">Username:</label>
                        <input type="text" id="crudUsername" name="username" placeholder="Enter username">
                    </div>
                    <div class="form-group">
                        <label for="crudEmail">Email:</label>
                        <input type="email" id="crudEmail" name="email" placeholder="Enter email">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="crudRoleId">Role:</label>
                        <select id="crudRoleId" name="roleId">
                            <option value="" disabled selected>Select a role</option>
                            <option value="1">Administrator</option>
                            
                            <option value="3">Customer</option>
                            <option value="4">Nutritionist</option>
                            <option value="5">Seller</option>
                            <option value="6">Shipper</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="crudActive">Account Status:</label>
                        <div style="margin-top: 10px;">
                            <input type="checkbox" id="crudActive" name="isActive" style="width: auto; margin-right: 10px;">
                            <label for="crudActive" style="display: inline; font-weight: normal;">Active Account</label>
                        </div>
                    </div>
                </div>
                
                <div class="crud-actions">
                    <button type="submit" name="crudAction" value="create" class="btn-primary">
                        <i class="fas fa-plus-circle"></i> Create
                    </button>
                    <button type="submit" name="crudAction" value="update" class="btn-secondary">
                        <i class="fas fa-sync-alt"></i> Update
                    </button>
                    <button type="submit" name="crudAction" value="delete" class="btn-danger">
                        <i class="fas fa-trash-alt"></i> Delete
                    </button>
                </div>
            </form>
        </div>

        <!-- Search Account Section -->
        <div class="section" id="searchForm">
            <h3><i class="fas fa-search"></i> Search Accounts</h3>
            <form action="AdminServlet" method="get" style="margin-bottom: 20px;">
                <input type="hidden" name="action" value="search">
                <div class="form-row">
                    <div class="form-group" style="flex: 3;">
                        <label for="searchQuery">Search by Keyword:</label>
                        <input type="text" id="searchQuery" name="query" placeholder="Search by name, email, username...">
                    </div>
                    <div class="form-group" style="flex: 1; align-self: flex-end;">
                        <button type="submit" class="btn-primary" style="width: 100%;">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>
                </div>
            </form>
            
            <form action="AdminServlet" method="get">
                <input type="hidden" name="action" value="filter">
                <div class="form-row">
                    <div class="form-group" style="flex: 3;">
                        <label for="filterRoleId">Filter by Role:</label>
                        <select id="filterRoleId" name="roleId">
                            <option value="all" selected>All Roles</option>
                            <option value="1">Administrator</option>
                            
                            <option value="3">Customer</option>
                            <option value="4">Nutritionist</option>
                            <option value="5">Seller</option>
                            <option value="6">Shipper</option>
                        </select>
                    </div>
                    <div class="form-group" style="flex: 1; align-self: flex-end;">
                        <button type="submit" class="btn-outline" style="width: 100%;">
                            <i class="fas fa-filter"></i> Filter
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html>