<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Xác thực OTP</title>
    <style>
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

        /* Header chứa logo */
        .custom-header {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            padding: 10px 20px;
            background: transparent;
            z-index: 1000;
        }

        .logo-container img {
            height: 50px;
        }

        .container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 12px 25px rgba(0,0,0,0.15);
            width: 380px;
            text-align: center;
            margin-top: 60px; /* tránh bị logo đè */
        }

        h2 {
            margin-bottom: 25px;
            color: #4a4a4a;
            font-weight: 700;
        }

        .form-field {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #555;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 1.8px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus {
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

        .message.error {
            margin-top: 18px;
            color: #e53e3e;
            font-weight: 600;
            font-size: 14px;
        }

        .back-forgot {
            display: block;
            margin-top: 16px;
            text-align: center;
            font-weight: 600;
            color: #667eea;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .back-forgot:hover {
            color: #5a67d8;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<!-- Logo -->
<div class="custom-header">
    <div class="logo-container">
        <a href="home.jsp">
            <img src="img/logo.png" alt="Logo">
        </a>
    </div>
</div>

<div class="container">
    <h2>Xác thực OTP</h2>
    <form action="VerifyOTPServlet" method="post">
        <div class="form-field">
            <label for="otp">Mã OTP (6 chữ số):</label>
            <input type="text" id="otp" name="otp" required maxlength="6">
        </div>
        <input type="submit" value="Xác thực">
    </form>

    <c:if test="${not empty error}">
        <p class="message error">${error}</p>
    </c:if>

    <a class="back-forgot" href="forgotpassword.jsp">← Quay lại nhập email</a>
</div>

</body>
</html>
