<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đặt lại mật khẩu</title>
    <style>
        /* Copy toàn bộ CSS từ forgot_password.jsp */
    </style>
</head>
<body>
<div class="container">
    <h2>Đặt lại mật khẩu</h2>
    <form action="ResetPasswordServlet" method="post">
        <div class="form-field">
            <label for="newPassword">Mật khẩu mới:</label>
            <input type="password" id="newPassword" name="newPassword" required>
        </div>
        <div class="form-field">
            <label for="confirmPassword">Xác nhận mật khẩu:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>
        <input type="submit" value="Cập nhật">
    </form>

    <c:if test="${not empty error}">
        <p class="message error">${error}</p>
    </c:if>
</div>
</body>
</html>