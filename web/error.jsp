<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lỗi hệ thống</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-danger text-center">
            <h2>Đã xảy ra lỗi</h2>
            <p>${errorMessage}</p>
            <a href="home" class="btn btn-primary mt-3">Về trang chủ</a>
        </div>
    </div>
</body>
</html>