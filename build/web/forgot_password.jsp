<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quên Mật Khẩu</title>
    <style>
        /* Styles tương tự login.jsp - giữ nguyên giao diện */
        * { box-sizing: border-box; }
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
        /* ... (Copy toàn bộ CSS từ login.jsp) ... */
    </style>
</head>
<body>
<div class="container">
    <h2>Quên Mật Khẩu</h2>
    <form action="ForgetPasswordServlet" method="post">
        <div class="form-field">
            <label for="email">Email đăng ký:</label>
            <input type="text" id="email" name="email" required>
        </div>
        <input type="submit" value="Gửi OTP">
    </form>

    <c:if test="${not empty error}">
        <p class="message error">${error}</p>
    </c:if>
</div>
</body>
</html>