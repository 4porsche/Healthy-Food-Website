<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đăng ký</title>
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
            box-sizing: border-box;
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
        p.error-message {
            margin-top: 18px;
            font-weight: 600;
            font-size: 14px;
            color: #e53e3e;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="register-container">
    <h2>Đăng ký</h2>
    <form action="RegisterServlet" method="post">
        <label for="fullname">Họ và tên:</label>
        <input type="text" id="fullname" name="fullname" required>

        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <input type="submit" value="Đăng ký">
    </form>
    <c:if test="${param.error == 'exists'}">
        <p class="error-message">Tên đăng nhập hoặc email đã tồn tại.</p>
    </c:if>
</div>
</body>
</html>
