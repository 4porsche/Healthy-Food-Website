<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả thanh toán</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 800px;
            margin: 50px auto;
        }
        .result-card {
            text-align: center;
            padding: 40px;
        }
        .success-icon {
            color: #28a745;
            font-size: 5rem;
            margin-bottom: 20px;
        }
        .failure-icon {
            color: #dc3545;
            font-size: 5rem;
            margin-bottom: 20px;
        }
        .error-icon {
            color: #ffc107;
            font-size: 5rem;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="container">
        <div class="card result-card">
            <% 
                String status = request.getParameter("status");
                String orderId = request.getParameter("orderId");
                
                if ("success".equals(status)) {
            %>
                <i class="fa fa-check-circle success-icon"></i>
                <h2>Thanh toán thành công!</h2>
                <p>Cảm ơn bạn đã mua hàng tại Healthy Food.</p>
                <% if (orderId != null) { %>
                    <p>Mã đơn hàng: <%= orderId %></p>
                <% } %>
            <% } else if ("failed".equals(status)) { %>
                <i class="fa fa-times-circle failure-icon"></i>
                <h2>Thanh toán thất bại</h2>
                <p>Đã xảy ra lỗi trong quá trình thanh toán.</p>
                <% if (orderId != null) { %>
                    <p>Mã đơn hàng: <%= orderId %></p>
                <% } %>
            <% } else { %>
                <i class="fa fa-exclamation-triangle error-icon"></i>
                <h2>Đã xảy ra lỗi</h2>
                <p>Hệ thống đã gặp sự cố khi xử lý đơn hàng của bạn.</p>
            <% } %>
            
            
           <div class="text-center mt-4">
    <a href="order-detail?orderId=${param.orderId}" class="btn btn-primary">
        <i class="bi bi-eye me-2"></i>Xem chi tiết đơn hàng
    </a>
    <a href="home" class="btn btn-outline-secondary ms-2">
        <i class="bi bi-house-door me-2"></i>Về trang chủ
    </a>
</div>
        </div>
    </div>
    
    <%@ include file="footer.jsp" %>
</body>
</html>