<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Customer Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700&display=swap" rel="stylesheet">
        <!-- CSS Libraries -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="lib/slick/slick.css" rel="stylesheet">
        <link href="lib/slick/slick-theme.css" rel="stylesheet">
        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>

        <%@ include file="header.jsp" %>

        <!-- Customer Profile -->
        <div class="container my-5">
            <c:if test="${empty sessionScope.user}">
                <!-- Nếu chưa đăng nhập -->
                <div class="container my-5">
                    <div class="alert alert-warning text-center">
                        Bạn cần <a href="login.jsp">đăng nhập</a> để xem hồ sơ khách hàng.
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <h2 class="text-center text-success mb-4">Hồ sơ khách hàng</h2>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center" role="alert">
                        ${error}
                    </div>
                </c:if>
                <div class="card shadow p-4">
                    <form action="updateprofile" method="post">
                        <input type="hidden" name="userid" value="${customer.userid}">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <strong>Họ và tên:</strong>
                                <input type="text" class="form-control" name="fullname" value="${customer.fullname}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <strong>Email:</strong>
                                <input type="email" class="form-control" name="email" value="${customer.email}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <strong>Số điện thoại:</strong>
                                <input type="text" class="form-control" name="phone" value="${customer.phone}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <strong>Giới tính:</strong>
                                <select class="form-control" name="gender" required>
                                    <option value="Nam" ${customer.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                    <option value="Nữ" ${customer.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <strong>Chiều cao:</strong>
                                <p>${customer.height} cm</p>
                            </div>
                            <div class="col-md-6 mb-3">
                                <strong>Cân nặng:</strong>
                                <p>${customer.weight} kg</p>
                            </div>
                            <div class="col-md-6 mb-3">
                                <strong>BMI:</strong>
                                <p>${customer.BMI}</p>
                            </div>
                            <div class="col-md-6 mb-3">
                                <strong>Mức độ hoạt động:</strong>
                                <p>${customer.activitylevel}</p>
                            </div>
                            <div class="col-md-6 mb-3">
                                <strong>Mục tiêu:</strong>
                                <p>${customer.goal}</p>
                            </div>
                            <div class="col-12 d-flex gap-2 flex-wrap">
                                <button type="submit" class="btn btn-success btn-sm" 
                                        onclick="return confirm('Bạn có chắc muốn lưu thay đổi?')">
                                    <i class="fa fa-save"></i> Lưu thay đổi
                                </button>
                                <a class="btn btn-outline-success btn-sm mr-2" href="load?userid=${customer.userid}">
                                    <i class="fa fa-plus-square"></i> Nhập chỉ số cơ thể
                                </a>
                                <a class="btn btn-outline-info btn-sm" href="loadpassword?userid=${customer.userid}">
                                    <i class="fa fa-key"></i> Đổi mật khẩu
                                </a>
                            </div>
                        </div>
                    </form>

                    <!-- Consultation Request Form -->
                    <div class="mt-5">
                        <h3 class="text-success mb-4">Gửi yêu cầu tư vấn dinh dưỡng</h3>

                        <!-- Thông báo khi có message -->
                        <c:if test="${not empty sessionScope.requestMessage}">
                            <div class="alert alert-info text-center" role="alert">
                                ${sessionScope.requestMessage}
                            </div>
                        </c:if>

                        <!-- Ẩn mã request đã gửi (dành cho debug, tracking hoặc dùng JS sau này) -->
                        <c:if test="${not empty sessionScope.lastRequest}">
                            <input type="hidden" id="lastRequestId" value="${lastRequest.requestId}" />
                        </c:if>

                        <!-- Chỉ hiển thị form nếu đã đăng nhập -->
                        <c:if test="${not empty sessionScope.user}">
                            <form action="submitRequest" method="post">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <strong>Ngày và giờ mong muốn tư vấn:</strong>
                                        <input type="datetime-local" class="form-control" name="preferredDate" required>
                                    </div>
                                    <div class="col-12 mb-3">
                                        <button type="submit" class="btn btn-primary btn-sm"
                                                onclick="return confirm('Bạn có chắc muốn gửi yêu cầu tư vấn?')">
                                            <i class="fa fa-paper-plane"></i> Gửi yêu cầu
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </c:if>

                        <!-- Nếu chưa đăng nhập -->


                    </div>
                    

                </div>

            </c:if>
        </div>
        <%@ include file="footer.jsp" %>
        <!-- Footer Bottom End -->

        <!-- Back to Top -->
        <a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/slick/slick.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>