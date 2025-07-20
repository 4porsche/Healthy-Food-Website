<%@page import="model.User"%>
<%@page import="model.CartItem"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .container {
            max-width: 800px;
            margin: 50px auto;
        }
        .payment-method {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 15px 0;
        }
        .payment-option {
            flex: 1;
            min-width: 150px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }
        .payment-option:hover, .payment-option.active {
            border-color: #007bff;
            background-color: #f0f8ff;
        }
        .payment-option img {
            max-height: 30px;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <%
        // Kiểm tra đăng nhập
        User user = (User) session.getAttribute("user");
        if (user == null) {
            String returnUrl = request.getRequestURL().toString();
            if (request.getQueryString() != null) {
                returnUrl += "?" + request.getQueryString();
            }
            response.sendRedirect("login.jsp?returnUrl=" + java.net.URLEncoder.encode(returnUrl, "UTF-8"));
            return;
        }

        // Lấy giỏ hàng từ session
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        double total = 0.0;
        if (cart != null && !cart.isEmpty()) {
            for (CartItem item : cart.values()) {
                double itemTotal = item.getPrice() * item.getQuantity();
                total += itemTotal;
            }
        }
    %>

    <div class="container">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">Thanh toán đơn hàng</h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Thông tin đơn hàng</h5>
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (cart != null && !cart.isEmpty()) { 
                                    for (CartItem item : cart.values()) { 
                                        double itemTotal = item.getPrice() * item.getQuantity(); %>
                                <tr>
                                    <td><%= item.getProductName() %></td>
                                    <td><%= item.getQuantity() %></td>
                                    <td><%= String.format("%,.0f", itemTotal) %>đ</td>
                                </tr>
                                <% } %>
                                <tr class="table-active">
                                    <td colspan="2"><strong>Tổng cộng</strong></td>
                                    <td><strong><%= String.format("%,.0f", total) %>đ</strong></td>
                                </tr>
                                <% } else { %>
                                <tr>
                                    <td colspan="3" class="text-center">Giỏ hàng trống</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="col-md-6">
                        <h5>Thông tin khách hàng</h5>
                        <form id="checkoutForm" action="checkout" method="POST">
                            <div class="form-group">
                                <label for="fullname">Họ và tên</label>
                                <input type="text" class="form-control" id="fullname" name="fullname" 
                                       value="<%= user.getFullname() %>" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Số điện thoại</label>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       value="<%= user.getPhone() != null ? user.getPhone() : "" %>" required>
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="<%= user.getEmail() %>" required>
                            </div>
                            <div class="form-group">
                                <label for="address">Địa chỉ giao hàng</label>
                                <textarea class="form-control" id="address" name="address" rows="2" required></textarea>
                            </div>
                            
                            <h5 class="mt-4">Phương thức thanh toán</h5>
                            <div class="payment-method">
                                <div class="payment-option active" data-method="vnpay">
                                    <img src="img/vnpay-logo.png" alt="VNPay">
                                    <div>VNPay</div>
                                </div>
                                <div class="payment-option" data-method="cod">
                                    <i class="fa fa-truck fa-2x"></i>
                                    <div>Thanh toán khi nhận hàng</div>
                                </div>
                            </div>
                            <input type="hidden" id="paymentMethod" name="paymentMethod" value="vnpay">
                            
                            <div class="mt-4">
                                <button type="submit" class="btn btn-primary btn-lg btn-block">Hoàn tất thanh toán</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script>
        $(document).ready(function() {
            // Xử lý chọn phương thức thanh toán
            $('.payment-option').click(function() {
                $('.payment-option').removeClass('active');
                $(this).addClass('active');
                $('#paymentMethod').val($(this).data('method'));
            });
        });
    </script>
</body>
</html>