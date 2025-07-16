<%@page import="model.CartItem"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Giỏ hàng</title>

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700&display=swap" rel="stylesheet">

        <!-- CSS Libraries -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">

        <style>
            .cart-table img {
                max-width: 80px;
                height: auto;
            }

            .quantity-input {
                width: 60px;
                text-align: center;
            }

            .cart-summary {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
            }

            .btn-update {
                margin-top: 5px;
                padding: 5px 10px;
                font-size: 14px;
            }

            .empty-cart {
                text-align: center;
                padding: 50px 0;
            }

            .empty-cart i {
                font-size: 5rem;
                color: #e0e0e0;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>

        <%@ include file="header.jsp" %>

        <!-- Breadcrumb Start -->
        <div class="breadcrumb-wrap">
            <div class="container">
                <ul class="breadcrumb">
                    <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                    <li class="breadcrumb-item active">Giỏ hàng</li>
                </ul>
            </div>
        </div>
        <!-- Breadcrumb End -->

        <!-- Cart Start -->
        <div class="cart-page">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <%
                            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
                            double total = 0;
                            
                            if (cart != null && !cart.isEmpty()) {
                        %>
                        <div class="table-responsive">
                            <table class="table table-bordered cart-table">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                        <th>Tổng</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (CartItem item : cart.values()) {
                                            if (item != null) {
                                                double itemTotal = item.getPrice() * item.getQuantity();
                                                total += itemTotal;
                                    %>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="<%= item.getImageUrl() != null ? item.getImageUrl() : "" %>" alt="Product Image">
                                                <div class="ml-3">
                                                    <h6><%= item.getProductName() != null ? item.getProductName() : "" %></h6>
                                                </div>
                                            </div>
                                        </td>
                                        <td><%= String.format("%,.0f", item.getPrice()) %>đ</td>
                                        <td>
                                            <form action="update-cart" method="POST" class="update-form">
                                                <input type="hidden" name="productID" 
                                                       value="<%= item.getProductID() %>">
                                                <input type="number" class="quantity-input" name="quantity" 
                                                       value="<%= item.getQuantity() %>" min="1">
                                                <button type="submit" class="btn btn-sm btn-primary btn-update">Cập nhật</button>
                                            </form>
                                        </td>
                                        <td><%= String.format("%,.0f", itemTotal) %>đ</td>
                                        <td>
                                            <form action="remove-from-cart" method="POST" class="remove-form">
                                                <input type="hidden" name="productID" 
                                                       value="<%= item.getProductID() %>">
                                                <button type="submit" class="btn btn-sm btn-danger">
                                                    <i class="fa fa-trash"></i> Xóa
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                    <%
                                            } // end if item != null
                                        } // end for
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <%
                            } else {
                        %>
                        <div class="empty-cart">
                            <i class="fa fa-shopping-cart"></i>
                            <h3>Giỏ hàng của bạn đang trống</h3>
                            <p>Hãy tiếp tục mua sắm và thêm sản phẩm vào giỏ hàng!</p>
                            <a href="home" class="btn btn-primary">Tiếp tục mua sắm</a>
                        </div>
                        <%
                            }
                        %>
                    </div>

                    <% if (cart != null && !cart.isEmpty()) { %>
                    <div class="col-md-12 mt-4">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="coupon">
                                    <input type="text" placeholder="Mã giảm giá">
                                    <button class="btn btn-primary">Áp dụng</button>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="cart-summary">
                                    <h3>Tổng giỏ hàng</h3>
                                    <table class="table">
                                        <tr>
                                            <td>Tạm tính</td>
                                            <td><%= String.format("%,.0f", total) %>đ</td>
                                        </tr>
                                        <tr>
                                            <td>Phí vận chuyển</td>
                                            <td>Miễn phí</td>
                                        </tr>
                                        <tr class="total-row">
                                            <td><strong>Tổng cộng</strong></td>
                                            <td><strong><%= String.format("%,.0f", total) %>đ</strong></td>
                                        </tr>
                                    </table>
                                    <div class="cart-buttons mt-4">
                                        <a href="home" class="btn btn-outline-secondary mr-2">Tiếp tục mua hàng</a>
                                        <a href="checkout.jsp" class="btn btn-primary">Thanh toán</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
        <!-- Cart End -->

        <%@ include file="footer.jsp" %>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>

        <script>
            $(document).ready(function () {
                // Xử lý cập nhật số lượng bằng AJAX
                $('.update-form').on('submit', function (e) {
                    e.preventDefault();
                    var form = $(this);
                    
                    // Kiểm tra số lượng hợp lệ
                    var quantityInput = form.find('.quantity-input');
                    var quantity = parseInt(quantityInput.val());
                    if (isNaN(quantity) || quantity < 1) {
                        quantityInput.val(1);
                        quantity = 1;
                    }

                    $.ajax({
                        type: 'POST',
                        url: form.attr('action'),
                        data: form.serialize(),
                        success: function (response) {
                            // Làm mới trang sau khi cập nhật thành công
                            location.reload();
                        },
                        error: function (xhr) {
                            console.error('Error:', xhr);
                            alert('Có lỗi xảy ra khi cập nhật giỏ hàng: ' + xhr.status + ' ' + xhr.statusText);
                        }
                    });
                });

                // Xử lý xóa sản phẩm bằng AJAX
                $('.remove-form').on('submit', function (e) {
                    e.preventDefault();
                    var form = $(this);

                    if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                        $.ajax({
                            type: 'POST',
                            url: form.attr('action'),
                            data: form.serialize(),
                            success: function (response) {
                                // Làm mới trang sau khi xóa thành công
                                location.reload();
                            },
                            error: function (xhr) {
                                console.error('Error:', xhr);
                                alert('Có lỗi xảy ra khi xóa sản phẩm: ' + xhr.status + ' ' + xhr.statusText);
                            }
                        });
                    }
                });

                // Kiểm tra số lượng nhập
                $('.quantity-input').on('change', function () {
                    var value = parseInt($(this).val());
                    if (isNaN(value) || value < 1) {
                        $(this).val(1);
                    }
                });
            });
        </script>
    </body>
</html>