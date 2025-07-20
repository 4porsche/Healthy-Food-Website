<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f6fff7;
            font-family: 'Segoe UI', sans-serif;
        }

        h2 {
            color: #2e7d32;
            font-weight: bold;
        }

        .card-profile {
            background-color: #ffffff;
            border: 1px solid #c8e6c9;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(46, 125, 50, 0.1);
        }

        .table-green th {
            background-color: #a5d6a7;
            color: #1b5e20;
            font-weight: 600;
            width: 30%;
        }

        .table-green td {
            background-color: #e8f5e9;
            color: #2e7d32;
        }

        .btn-secondary {
            background-color: #81c784;
            border-color: #66bb6a;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #66bb6a;
        }
    </style>
</head>
<body>
    <div class="container mt-5 mb-5">
        <div class="card-profile mx-auto" style="max-width: 700px;">
            <h2 class="text-center mb-4">Thông tin chi tiết khách hàng</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center">${error}</div>
            </c:if>

            <c:if test="${not empty customer}">
                <table class="table table-bordered table-green">
                    <tr>
                        <th>Họ tên</th>
                        <td>${customer.fullname}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${customer.email}</td>
                    </tr>
                    <tr>
                        <th>Giới tính</th>
                        <td>${customer.gender}</td>
                    </tr>
                    <tr>
                        <th>Chiều cao</th>
                        <td>${customer.height} cm</td>
                    </tr>
                    <tr>
                        <th>Cân nặng</th>
                        <td>${customer.weight} kg</td>
                    </tr>
                    <tr>
                        <th>BMI</th>
                        <td>${customer.BMI}</td>
                    </tr>
                    <tr>
                        <th>Mức độ hoạt động</th>
                        <td>${customer.activitylevel}</td>
                    </tr>
                    <tr>
                        <th>Mục tiêu</th>
                        <td>${customer.goal}</td>
                    </tr>
                </table>

                <div class="text-center mt-4">
                    <a href="requests" class="btn btn-secondary">
                        ← Quay lại danh sách
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
