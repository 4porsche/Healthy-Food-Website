<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .header {
            background: linear-gradient(135deg, #4e54c8, #8f94fb);
            color: white;
            padding: 1.5rem 0;
            margin-bottom: 2rem;
        }
        .order-card {
            background: white;
            border-radius: 0.75rem;
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 1rem;
            font-size: 1rem;
            font-weight: 500;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-shipped {
            background-color: #cce5ff;
            color: #004085;
        }
        .status-delivered {
            background-color: #d4edda;
            color: #155724;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 0.5rem;
        }
        .back-btn {
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 0.5rem 1.25rem;
            border-radius: 0.5rem;
            transition: all 0.3s;
        }
        .back-btn:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="h3 mb-0"><i class="fas fa-file-invoice me-2"></i>Order Details</h1>
                <a href="OrderManagementServlet" class="btn btn-light">
                    <i class="fas fa-arrow-left me-2"></i>Back to Orders
                </a>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="order-card">
            <!-- Order Information -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <h4 class="mb-3">Order Information</h4>
                    <div class="mb-2">
                        <strong>Order ID:</strong> ${order.orderID}
                    </div>
                    <div class="mb-2">
                        <strong>Order Date:</strong> ${order.orderDate}
                    </div>
                    <div class="mb-2">
                        <strong>Status:</strong>
                        <c:choose>
                            <c:when test="${order.deliveryStatus == 'Pending'}">
                                <span class="status-badge status-pending">${order.deliveryStatus}</span>
                            </c:when>
                            <c:when test="${order.deliveryStatus == 'Shipped'}">
                                <span class="status-badge status-shipped">${order.deliveryStatus}</span>
                            </c:when>
                            <c:when test="${order.deliveryStatus == 'Delivered'}">
                                <span class="status-badge status-delivered">${order.deliveryStatus}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge status-cancelled">${order.deliveryStatus}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="col-md-6">
                    <h4 class="mb-3">Customer Information</h4>
                    <div class="mb-2">
                        <strong>Name:</strong> ${order.customerName}
                    </div>
                    <div class="mb-2">
                        <strong>Email:</strong> ${order.customerEmail}
                    </div>
                    <div class="mb-2">
                        <strong>Phone:</strong> ${order.customerPhone}
                    </div>
                    <div class="mb-2">
                        <strong>Address:</strong> ${order.deliveryAddress}
                    </div>
                </div>
            </div>
            
            <!-- Order Items -->
            <h4 class="mb-3">Order Items</h4>
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${orderDetails}">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <c:if test="${not empty item.image}">
                                           <img src="${pageContext.request.contextPath}/${item.image}" alt="${item.productName}" class="product-img me-3">


                                        </c:if>
                                        <div>
                                            <div class="fw-bold">${item.productName}</div>
                                            <div class="text-muted">ID: ${item.productID}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>$${item.price}</td>
                                <td>${item.quantity}</td>
                                <td>$${item.price * item.quantity}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" class="text-end fw-bold">Grand Total:</td>
                            <td class="fw-bold">$${order.totalPrice}</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
            
            <!-- Shipping Information -->
            <c:if test="${not empty shipping}">
                <h4 class="mt-5 mb-3">Shipping Information</h4>
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-2">
                            <strong>Shipping ID:</strong> ${shipping.shippingID}
                        </div>
                        <div class="mb-2">
                            <strong>Shipper:</strong> ${shipper.fullname}
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-2">
                            <strong>Status:</strong> ${shipping.status}
                        </div>
                        <div class="mb-2">
                            <strong>Last Updated:</strong> ${shipping.updateDate}
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
        
        <div class="d-flex justify-content-center">
            <a href="OrderManagementServlet" class="btn back-btn">
                <i class="fas fa-list me-2"></i>Back to Orders List
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>