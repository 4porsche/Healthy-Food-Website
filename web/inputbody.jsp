<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Sửa Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700&display=swap" rel="stylesheet">

        <!-- CSS Libraries -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/profile.css" rel="stylesheet">
    </head>
    <body>
        <div id="profile">
            <div class="container">
                <div class="row justify-content-center align-items-center">
                    <div class="col-md-6">
                        <div class="form-container">
                            <form class="form" action="edit" method="post">
                                <h3 class="text-center text-primary mb-4">Nhập chỉ số cơ thể</h3>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger text-center" role="alert">
                                        ${error}
                                    </div>
                                </c:if>
                                <input type="hidden" name="userid" value="${loadcustomer.userid}" />

                                <div class="form-group">
                                    <label for="height">Chiều cao:</label>
                                    <input value="${loadcustomer.height}" type="text" name="height" id="height" class="form-control" required>
                                </div>

                                <div class="form-group">
                                    <label for="weight">Cân nặng:</label>
                                    <input value="${loadcustomer.weight}" type="text" name="weight" id="weight" class="form-control" required>
                                </div>

                                <div class="form-group">
                                    <label for="bmi">BMI:</label>
                                    <input value="${loadcustomer.BMI}" type="text" name="bmi" id="bmi" class="form-control" required>
                                </div>

                                <div class="form-group mb-3">
                                    <strong>Mức độ hoạt động:</strong><br>

                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="activitylevel" value="Thấp" 
                                               ${loadcustomer.activitylevel == 'Thấp' ? 'checked' : ''}>
                                        <label class="form-check-label">Thấp</label>
                                    </div>

                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="activitylevel" value="Trung bình" 
                                               ${loadcustomer.activitylevel == 'Trung bình' ? 'checked' : ''}>
                                        <label class="form-check-label">Trung bình</label>
                                    </div>

                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="activitylevel" value="Cao" 
                                               ${loadcustomer.activitylevel == 'Cao' ? 'checked' : ''}>
                                        <label class="form-check-label">Cao</label>
                                    </div>
                                </div>

                                <div class="form-group mb-3">
                                    <strong>Mục tiêu:</strong><br>

                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="goal" value="Giảm cân" 
                                               ${loadcustomer.goal == 'Giảm cân' ? 'checked' : ''}>
                                        <label class="form-check-label">Giảm cân</label>
                                    </div>

                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="goal" value="Tăng cơ" 
                                               ${loadcustomer.goal == 'Tăng cơ' ? 'checked' : ''}>
                                        <label class="form-check-label">Tăng cơ</label>
                                    </div>

                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="goal" value="Giữ vóc dáng" 
                                               ${loadcustomer.goal == 'Giữ vóc dáng' ? 'checked' : ''}>
                                        <label class="form-check-label">Giữ vóc dáng</label>
                                    </div>
                                </div>

                                <div class="form-group text-center">
                                    <input type="submit" name="submit" value="Thay đổi" class="btn btn-primary">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
