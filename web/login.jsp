<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đăng nhập</title>
    <style>
        /* Reset cơ bản */
        * {
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }
        .container {
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
        .form-field {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            color: #555;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 14px;
            border: 1.8px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="password"]:focus {
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
        }
        input[type="submit"]:hover {
            background-color: #5a67d8;
        }
        .register-btn {
            display: inline-block;
            margin-top: 18px;
            color: #667eea;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .register-btn:hover {
            color: #4a4fc6;
        }
        p.message {
            margin-top: 18px;
            font-weight: 600;
            font-size: 14px;
        }
        p.error {
            color: #e53e3e;
        }
        p.success {
            color: #38a169;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Đăng nhập</h2>
    <form action="LoginServlet" method="post">
        <div class="form-field">
            <label for="username">Tên đăng nhập:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-field">
            <label for="password">Mật khẩu:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <input type="submit" value="Đăng nhập">
    </form>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${param.error == 'invalid'}">
        <p class="message error">Tên đăng nhập hoặc mật khẩu không đúng.</p>
    </c:if>
    <c:if test="${param.error == 'role'}">
        <p class="message error">Vai trò người dùng không hợp lệ.</p>
    </c:if>
    <c:if test="${param.register == 'success'}">
        <p class="message success">Đăng ký thành công. Vui lòng đăng nhập.</p>
    </c:if>

    <!-- Nút chuyển đến trang đăng ký -->
    <a href="register.jsp" class="register-btn">Chưa có tài khoản? Đăng ký</a>
</div>
</body>
</html>
