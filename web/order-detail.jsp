<%@page import="model.OrderDetail"%>
<%@page import="model.Order"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết đơn hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <style>
            .order-header {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 30px;
            }
            .order-details {
                margin-top: 30px;
            }
            .product-img {
                max-width: 80px;
                height: auto;
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
            .order-summary {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 20px;
                margin-top: 30px;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="container py-5">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="h3">Chi tiết đơn hàng</h1>
                        <a href="order-history.jsp" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left"></i> Quay lại
                        </a>
                    </div>

                    <%
                        Order order = (Order) request.getAttribute("order");
                        if (order != null) {
                    %>
                    <div class="order-header">
                        <div class="d-flex justify-content-between flex-wrap">
                            <div class="mb-3">
                                <h5 class="mb-1">Mã đơn hàng: #<%= order.getOrderID() %></h5>
                                <p class="text-muted mb-0">
                                    Ngày đặt: <%= order.getOrderDate() %>
                                </p>
                            </div>
                            <div>
                                <%
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
                                <span class="status-badge <%= statusClass %>">
                                    <%= statusText %>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="card mb-4">
                        <div class="card-header bg-light">
                            <h5 class="mb-0">Thông tin khách hàng</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <p class="mb-1"><strong>Họ tên</strong></p>
                                    <p><%= order.getCustomerName() %></p>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <p class="mb-1"><strong>Email</strong></p>
                                    <p><%= order.getCustomerEmail() %></p>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <p class="mb-1"><strong>Số điện thoại</strong></p>
                                    <p><%= order.getCustomerPhone() %></p>
                                </div>
                                <div class="col-md-12">
                                    <p class="mb-1"><strong>Địa chỉ giao hàng</strong></p>
                                    <p><%= order.getDeliveryAddress() %></p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="order-details">
                        <div class="card">
                            <div class="card-header bg-light">
                                <h5 class="mb-0">Sản phẩm đã đặt</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table align-middle">
                                        <thead>
                                            <tr>
                                                <th>Sản phẩm</th>
                                                <th>Đơn giá</th>
                                                <th>Số lượng</th>
                                                <th class="text-end">Thành tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<OrderDetail> orderDetails = (List<OrderDetail>) request.getAttribute("orderDetails");
                                                if (orderDetails != null && !orderDetails.isEmpty()) {
                                                    for (OrderDetail item : orderDetails) {
                                            %>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="<%= item.getImageUrl() != null ? item.getImageUrl() : "img/default-product.png" %>" 
                                                             alt="<%= item.getProductName() %>" 
                                                             class="product-img me-3">
                                                        <div>
                                                            <h6 class="mb-0"><%= item.getProductName() %></h6>
                                                            <p class="text-muted mb-0">Mã SP: <%= item.getProductID() %></p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td><%= String.format("%,d", item.getPrice()) %>đ</td>
                                                <td><%= item.getQuantity() %></td>
                                                <td class="text-end"><%= String.format("%,d", item.getPrice() * item.getQuantity()) %>đ</td>
                                            </tr>
                                            <%
                                                    }
                                                } else {
                                            %>
                                            <tr>
                                                <td colspan="4" class="text-center py-4">Không có sản phẩm nào trong đơn hàng</td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="order-summary">
                        <div class="row">
                            <div class="col-md-6 offset-md-6">
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Tạm tính:</span>
                                    <span><%= String.format("%,d", order.getTotalPrice()) %>đ</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Phí vận chuyển:</span>
                                    <span>0đ</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Giảm giá:</span>
                                    <span>0đ</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between fw-bold fs-5">
                                    <span>Tổng cộng:</span>
                                    <span><%= String.format("%,d", order.getTotalPrice()) %>đ</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        } else {
                    %>
                    <div class="alert alert-warning text-center py-4">
                        <i class="bi bi-exclamation-circle fs-1"></i>
                        <h4 class="mt-3">Không tìm thấy đơn hàng</h4>
                        <p class="mb-0">Đơn hàng bạn yêu cầu không tồn tại hoặc đã bị hủy</p>
                        <div class="mt-3">
                            <a href="order-history.jsp" class="btn btn-primary">
                                <i class="bi bi-list me-2"></i>Quay lại lịch sử đơn hàng
                            </a>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>