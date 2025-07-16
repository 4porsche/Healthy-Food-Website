<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đăng ký</title>
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            height: 100vh;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .top-header {
            position: absolute;
            top: 0;
            left: 0;
            padding: 12px 20px;
            background: transparent;
        }
        .top-header img {
            height: 50px;
        }

        .main-wrapper {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 12px 25px rgba(0,0,0,0.15);
            width: 380px;
            text-align: center;
        }

        h2 {
            margin-bottom: 25px;
            color: #4a4a4a;
            font-weight: 700;
            letter-spacing: 1px;
        }

        form {
            text-align: left;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            color: #555;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 12px 14px;
            border: 1.8px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus {
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.7);
        }

        input[type="submit"] {
            width: 100%;
            background-color: #667eea;
            color: white;
            font-weight: 700;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            letter-spacing: 1px;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            background-color: #5a67d8;
        }

        .back-login {
            display: block;
            margin-top: 16px;
            text-align: center;
            font-weight: 600;
            color: #667eea;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .back-login:hover {
            color: #5a67d8;
            text-decoration: underline;
        }

        p.error-message {
            margin-top: 18px;
            font-weight: 600;
            font-size: 14px;
            color: #e53e3e;
            text-align: center;
        }

        /* Thông báo lỗi xác nhận mật khẩu */
        #confirm-password-error {
            color: #e53e3e;
            font-size: 13px;
            margin-top: 6px;
            display: none;
            font-weight: 600;
        }
    </style>

    <script>
        function validateForm(event) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const errorMsg = document.getElementById('confirm-password-error');

            if (password !== confirmPassword) {
                errorMsg.style.display = 'block';
                event.preventDefault(); // ngăn form submit
            } else {
                errorMsg.style.display = 'none';
            }
        }

        window.addEventListener('DOMContentLoaded', () => {
            document.getElementById('registerForm').addEventListener('submit', validateForm);
        });
    </script>
</head>
<body>
<!-- Logo góc trên trái -->
<div class="top-header">
    <a href="home.jsp">
         <img src="img/header-logo.png" alt="Logo">
    </a>
</div>

<!-- Khối đăng ký ở giữa màn hình -->
<div class="main-wrapper">
    <div class="register-container">
        <h2>Đăng ký</h2>
        <form id="registerForm" action="RegisterServlet" method="post">
            <label for="fullname">Họ và tên:</label>
            <input type="text" id="fullname" name="fullname" required>

            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>

            <label for="confirmPassword">Xác nhận mật khẩu:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <div id="confirm-password-error">Mật khẩu không trùng với mật khẩu bạn đã nhập.</div>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <input type="submit" value="Đăng ký">
        </form>

        <!-- Thông báo lỗi nếu có -->
        <c:if test="${param.error == 'exists'}">
            <p class="error-message">Tên đăng nhập hoặc email đã tồn tại.</p>
        </c:if>

        <!-- Nút quay lại trang đăng nhập -->
        <a class="back-login" href="login.jsp">← Quay lại đăng nhập</a>
    </div>
</div>
</body>
</html>
