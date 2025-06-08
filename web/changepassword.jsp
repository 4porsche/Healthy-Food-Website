<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sửa thông tin cá nhân</title>
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
        <div id="changepassword">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="col-md-6">
                        <div class="form-container">
                            <form class="form" action="changepassword" method="post">
                                <h3 class="text-center text-primary mb-4">Đổi mật khẩu</h3>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger text-center" role="alert">
                                        ${error}
                                    </div>
                                </c:if>

                                <c:if test="${not empty success}">
                                    <div class="alert alert-success text-center" role="alert">
                                        ${success}
                                    </div>
                                </c:if>
                                  
                                <input type="hidden" name="userid" value="" />

                                <div class="form-group">
                                    <label for="currentPassword">Mật khẩu hiện tại:</label>
                                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                </div>

                                <div class="form-group">
                                    <label for="newPassword">Mật khẩu mới:</label>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                </div>

                                <div class="form-group">
                                    <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                </div>

                                <div class="form-group text-center">
                                    <input type="submit" name="submit" value="Đổi mật khẩu" class="btn btn-primary">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
