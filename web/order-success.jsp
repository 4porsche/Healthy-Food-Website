<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container mt-5">
        <div class="card text-center">
            <div class="card-header bg-success text-white">
                <h3>Đặt hàng thành công!</h3>
            </div>
            <div class="card-body">
                <h5 class="card-title">Cảm ơn bạn đã đặt hàng</h5>
                <p class="card-text">
                    Mã đơn hàng của bạn: <strong>${param.orderID}</strong>
                </p>
                <p>Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.</p>
                <a href="home.jsp" class="btn btn-primary">Tiếp tục mua sắm</a>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>