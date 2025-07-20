<%@page import="java.util.List"%>
<%@page import="model.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <style>
        .order-card {
            transition: all 0.3s ease;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        .order-header {
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
        }
        .order-body {
            padding: 20px;
        }
        .product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
        }
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }
        .status-pending {
            background-color: #ffc107;
            color: #333;
        }
        .status-paid {
            background-color: #198754;
            color: white;
        }
        .status-shipping {
            background-color: #0dcaf0;
            color: white;
        }
        .status-delivered {
            background-color: #6c757d;
            color: white;
        }
        .status-cancelled {
            background-color: #dc3545;
            color: white;
        }
        .empty-state {
            text-align: center;
            padding: 40px 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
        .empty-state i {
            font-size: 64px;
            color: #6c757d;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container py-5">
        <div class="row">
            <div class="col-lg-10 mx-auto">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3">Lịch sử đơn hàng</h1>
                    <a href="home" class="btn btn-outline-primary">
                        <i class="bi bi-house-door me-1"></i> Về trang chủ
                    </a>
                </div>

                <div class="card border-0 shadow-sm">
                    <div class="card-body p-0">
                        <%
                            List<Order> orders = (List<Order>) request.getAttribute("orders");
                            if (orders != null && !orders.isEmpty()) {
                                for (Order order : orders) {
                                    String statusClass = "";
                                    String statusText = order.getDeliveryStatus();

                                    // Xử lý trạng thái đơn hàng
                                    if (statusText != null) {
                                        switch (statusText.toLowerCase()) {
                                            case "pending":
                                            case "đang xử lý":
                                            case "đang xú lý":
                                                statusClass = "status-pending";
                                                statusText = "Đang xử lý";
                                                break;
                                            case "paid":
                                            case "đã thanh toán":
                                                statusClass = "status-paid";
                                                statusText = "Đã thanh toán";
                                                break;
                                            case "shipping":
                                            case "shipped":
                                            case "đang giao hàng":
                                                statusClass = "status-shipping";
                                                statusText = "Đang giao hàng";
                                                break;
                                            case "delivered":
                                            case "đã giao hàng":
                                                statusClass = "status-delivered";
                                                statusText = "Đã giao hàng";
                                                break;
                                            case "cancelled":
                                            case "đã hủy":
                                                statusClass = "status-cancelled";
                                                statusText = "Đã hủy";
                                                break;
                                            case "failed":
                                                statusClass = "status-cancelled";
                                                statusText = "Thất bại";
                                                break;
                                            default:
                                                statusClass = "status-pending";
                                                // Giữ nguyên statusText nếu không khớp
                                        }
                                    } else {
                                        statusClass = "status-pending";
                                        statusText = "Đang xử lý";
                                    }
                        %>
                        <div class="order-card">
                            <div class="order-header d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="mb-1">Mã đơn hàng: #<%= order.getOrderID() %></h5>
                                    <p class="text-muted mb-0">Ngày đặt: <%= order.getOrderDate() %></p>
                                </div>
                                <div>
                                    <span class="status-badge <%= statusClass %>">
                                        <%= statusText %>
                                    </span>
                                </div>
                            </div>
                            
                            <div class="order-body">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <p class="mb-1"><strong>Khách hàng</strong></p>
                                        <p class="mb-0"><%= order.getCustomerName() %></p>
                                    </div>
                                    <div class="col-md-6">
                                        <p class="mb-1"><strong>Tổng tiền</strong></p>
                                        <p class="mb-0 text-danger fw-bold"><%= String.format("%,d", order.getTotalPrice()) %>đ</p>
                                    </div>
                                </div>
                                
                                <div class="d-flex justify-content-between align-items-center">
                                    <a href="order-detail?orderID=<%= order.getOrderID() %>" class="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-eye me-1"></i> Xem chi tiết
                                    </a>
                                    <span class="text-muted"><%= order.getDeliveryAddress() %></span>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <div class="empty-state">
                            <i class="bi bi-cart-x"></i>
                            <h4 class="mb-3">Bạn chưa có đơn hàng nào</h4>
                            <p class="text-muted mb-4">Hãy bắt đầu mua sắm để tận hưởng những sản phẩm tuyệt vời của chúng tôi</p>
                            <a href="my-products" class="btn btn-primary">
                                <i class="bi bi-bag me-1"></i> Mua sắm ngay
                            </a>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>