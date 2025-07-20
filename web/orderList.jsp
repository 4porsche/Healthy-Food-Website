<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Management</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .header {
                background: linear-gradient(135deg, #ff416c, #ff4b2b);
                color: white;
                padding: 1.5rem 0;
                margin-bottom: 2rem;
            }
            .table-container {
                background: white;
                border-radius: 0.75rem;
                box-shadow: 0 6px 15px rgba(0,0,0,0.08);
                overflow: hidden;
            }
            .table thead {
                background: linear-gradient(135deg, #4e54c8, #8f94fb);
                color: white;
            }
            .table th {
                font-weight: 600;
            }
            .status-badge {
                padding: 0.35rem 0.75rem;
                border-radius: 1rem;
                font-size: 0.85rem;
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
            .btn-view {
                background: linear-gradient(135deg, #4e54c8, #8f94fb);
                color: white;
                border: none;
                padding: 0.35rem 1rem;
                border-radius: 0.5rem;
                transition: all 0.3s;
            }
            .btn-view:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
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
                    <h1 class="h3 mb-0"><i class="fas fa-shopping-cart me-2"></i>Order Management</h1>
                    <a href="managerHome.jsp" class="btn btn-light">
                        <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                    </a>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="table-container">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer Name</th>
                            <th>Order Date</th>
                            <th>Total Price</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>${order.orderID}</td>
                                <td>${order.customerName}</td>
                                <td>${order.orderDate}</td>
                                <td>$${order.totalPrice}</td>
                                <td>
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
                                </td>
                                <td>



                                    <a href="${pageContext.request.contextPath}/OrderDetailServlet?id=${order.orderID}">
                                        <i class="fas fa-info-circle me-1"></i>View Details
                                    </a>
                                </td>

                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-center mt-4">
                <a href="managerHome.jsp" class="btn back-btn">
                    <i class="fas fa-home me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>