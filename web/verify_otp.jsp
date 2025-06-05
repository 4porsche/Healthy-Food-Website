<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Xác thực OTP</title>
    <style>
        /* Copy toàn bộ CSS từ forgot_password.jsp */
    </style>
</head>
<body>
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
</div>
</body>
</html>