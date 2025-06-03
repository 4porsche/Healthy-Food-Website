<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Profile</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Bootstrap Ecommerce Template" name="keywords">
        <meta content="Bootstrap Ecommerce Template Free Download" name="description">

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
        <div class="top-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-3">
                        <div class="logo">
                            <a href="">
                                <img src="img/logo.png" alt="Logo">
                            </a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="search">
                            <input type="text" placeholder="Search">
                            <button><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="user">
                            <div class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">My Account</a>
                                <div class="dropdown-menu">
                                    <a href="#" class="dropdown-item">Login</a>
                                    <a href="#" class="dropdown-item">Register</a>
                                </div>
                            </div>
                            <div class="cart">
                                <i class="fa fa-cart-plus"></i>
                                <span>(0)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Customer Profile Section -->
        <div class="container my-5">
            <h2 class="text-center text-primary mb-4">Customer Profile</h2>
            <div class="card p-4 shadow-sm">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            <div class="col-sm-6 mb-3">
                                <strong>Họ và tên:</strong>
                                <p>${customer.fullname}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <strong>Email:</strong>
                                <p id="email">${customer.email}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <strong>Số điện thoại:</strong>
                                <p id="phone">${customer.phone}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <strong>Giới tính:</strong>
                                <p id="gender">${customer.gender}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <strong>Chiều cao:</strong>
                                <p id="height">${customer.height} cm</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <strong>Cân nặng:</strong>
                                <p id="weight">${customer.weight} kg</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <strong>BMI:</strong>
                                <p id="bmi">${customer.BMI}</p>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <strong>Activity Level:</strong>
                                <p id="activityLevel">${customer.activitylevel}</p>
                            </div>
                            <div class="col-12 mb-3">
                                <strong>Mục tiêu:</strong>
                                <p id="goal">${customer.goal}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/slick/slick.min.js"></script>


        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
