<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Đăng nhập</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://accounts.google.com/gsi/client" async defer></script>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                height: 100vh;
                display: flex;
                flex-direction: column;
                position: relative;
                overflow: hidden;
            }

            /* Tạo hiệu ứng bong bóng nền */
            body::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MCIgaGVpZ2h0PSI1MCIgdmlld0JveD0iMCAwIDUwIDUwIj48Y2lyY2xlIGN4PSIxNSIgY3k9IjE1IiByPSIxLjUiIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMC4xIi8+PGNpcmNsZSBjeD0iMzUiIGN5PSIzNSIgcj0iMiIgZmlsbD0iI2ZmZmZmZiIgZmlsbC1vcGFjaXR5PSIwLjEiLz48Y2lyY2xlIGN4PSIyMCIgY3k9IjQwIiByPSIxLjUiIGZpbGw9IiNmZmZmZmYiIGZpbGwtb3BhY2l0eT0iMC4xIi8+PC9zdmc+');
                opacity: 0.1;
                z-index: -1;
            }

            .top-header {
                background: rgba(255, 255, 255, 0.9);
                padding: 15px 40px;
                display: flex;
                align-items: center;
                justify-content: flex-start;
                box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            }

            .top-header img {
                height: 65px;
                transition: transform 0.3s ease;
            }

            .top-header img:hover {
                transform: scale(1.05);
            }

            .main-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }

            .container {
                background: rgba(255, 255, 255, 0.95);
                padding: 35px 45px;
                border-radius: 18px;
                box-shadow: 0 15px 35px rgba(0,0,0,0.2);
                width: 100%;
                max-width: 420px;
                text-align: center;
                position: relative;
                overflow: hidden;
                backdrop-filter: blur(5px);
                border: 1px solid rgba(255,255,255,0.3);
            }

            .container::before {
                content: "";
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: linear-gradient(45deg, transparent, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1), transparent);
                transform: rotate(30deg);
                z-index: 0;
            }

            .container > * {
                position: relative;
                z-index: 1;
            }

            h2 {
                margin-bottom: 30px;
                color: #4a4a4a;
                font-weight: 700;
                letter-spacing: 0.5px;
                font-size: 28px;
            }

            form {
                text-align: left;
            }

            .form-field {
                margin-bottom: 24px;
                position: relative;
            }

            label {
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                color: #555;
                font-size: 15px;
            }

            .input-icon {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #667eea;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 14px 18px 14px 48px;
                border: 2px solid #e1e5ee;
                border-radius: 10px;
                font-size: 16px;
                transition: all 0.3s ease;
                background: #f8f9fa;
            }

            input[type="text"]:focus,
            input[type="password"]:focus {
                border-color: #667eea;
                background: #fff;
                outline: none;
                box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.15);
            }

            input[type="submit"] {
                width: 100%;
                background: linear-gradient(to right, #667eea, #764ba2);
                color: white;
                font-weight: 600;
                padding: 16px;
                border: none;
                border-radius: 10px;
                font-size: 18px;
                cursor: pointer;
                transition: all 0.4s ease;
                letter-spacing: 0.8px;
                position: relative;
                overflow: hidden;
                z-index: 1;
                margin-top: 10px;
            }

            input[type="submit"]::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 0;
                height: 100%;
                background: linear-gradient(to right, #5a67d8, #6a4b9c);
                transition: all 0.4s ease;
                z-index: -1;
            }

            input[type="submit"]:hover::before {
                width: 100%;
            }

            input[type="submit"]:hover {
                box-shadow: 0 8px 20px rgba(0,0,0,0.2);
                transform: translateY(-3px);
            }

            input[type="submit"]:active {
                transform: translateY(1px);
            }

            .links {
                display: flex;
                justify-content: space-between;
                margin-top: 25px;
            }

            .register-btn {
                color: #667eea;
                font-weight: 600;
                text-decoration: none;
                font-size: 15px;
                transition: all 0.3s ease;
                position: relative;
                padding: 5px 0;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .register-btn::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 0;
                height: 2px;
                background: #667eea;
                transition: width 0.3s ease;
            }

            .register-btn:hover::after {
                width: 100%;
            }

            .register-btn:hover {
                color: #4a4fc6;
            }

            p.message {
                margin-top: 20px;
                font-weight: 600;
                font-size: 15px;
                padding: 12px;
                border-radius: 8px;
                text-align: center;
            }

            p.error {
                color: #e53e3e;
                background: rgba(229, 62, 62, 0.1);
                border-left: 4px solid #e53e3e;
            }

            p.success {
                color: #38a169;
                background: rgba(56, 161, 105, 0.1);
                border-left: 4px solid #38a169;
            }

            .divider {
                display: flex;
                align-items: center;
                margin: 25px 0;
                color: #777;
                font-size: 14px;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                border-bottom: 1px solid #e1e5ee;
            }

            .divider span {
                padding: 0 15px;
            }

            /* Social login */
            .social-login {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 20px;
            }

            /* CSS mới cho nút Google */
            .google-login-container {
                width: 100%;
                display: flex;
                justify-content: center;
            }

            .g_id_signin {
                border: none !important;
                background: transparent !important;
                padding: 0 !important;
                margin: 0 !important;
                border-radius: 50% !important;
                width: 45px !important;
                height: 45px !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                overflow: hidden !important;
                box-shadow: 0 3px 10px rgba(0,0,0,0.15) !important;
                transition: all 0.3s ease !important;
            }

            .g_id_signin:hover {
                transform: translateY(-3px) !important;
                box-shadow: 0 5px 15px rgba(0,0,0,0.2) !important;
            }

            .g_id_signin > div {
                border: none !important;
                background: transparent !important;
                width: 100% !important;
                height: 100% !important;
                border-radius: 50% !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
            }

            .g_id_signin > div > div {
                width: 24px !important;
                height: 24px !important;
                background: url('https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg') center center no-repeat !important;
                background-size: contain !important;
                margin: 0 !important;
                padding: 0 !important;
            }

            /* Responsive */
            @media (max-width: 480px) {
                .container {
                    padding: 25px 30px;
                }

                .top-header {
                    padding: 12px 20px;
                }

                .top-header img {
                    height: 50px;
                }

                .links {
                    flex-direction: column;
                    gap: 15px;
                }

                input[type="text"],
                input[type="password"] {
                    padding: 12px 12px 12px 42px;
                    font-size: 15px;
                }
            }
            p.message.error {
                background: rgba(229, 62, 62, 0.1);
                border-left: 4px solid #e53e3e;
                padding: 12px;
                border-radius: 4px;
                margin-top: 20px;
                font-size: 15px;
            }

            p.message.error i {
                margin-right: 8px;
                color: #e53e3e;
            }
        </style>
    </head>
    <body>
        <%@ page session="true" %>

        <!-- Header với logo bên trái -->
        <div class="top-header">
            <a href="home.jsp">
                <img src="img/logo.png" alt="Logo">
            </a>
        </div>

        <!-- Phần đăng nhập ở giữa màn hình -->
        <div class="main-container">
            <div class="container">
                <h2>Đăng nhập</h2>
                <form action="LoginServlet" method="post">
                    <div class="form-field">
                        <label for="username">Tên đăng nhập</label>
                        <div class="input-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <input type="text" id="username" name="username" required placeholder="Nhập tên đăng nhập">
                    </div>

                    <div class="form-field">
                        <label for="password">Mật khẩu</label>
                        <div class="input-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu">
                    </div>

                    <input type="submit" value="Đăng nhập">
                </form>

                <!-- Thông báo -->
                <c:if test="${param.error == 'google_email_exists'}">
                    <p class="message error">
                        <i class="fas fa-exclamation-circle"></i> Email này đã được đăng ký trong hệ thống. 
                        Vui lòng đăng nhập bằng mật khẩu hoặc sử dụng email khác.
                    </p>
                </c:if>
                <c:if test="${param.error == 'google'}">
                    <p class="message error">
                        <i class="fas fa-exclamation-circle"></i> Đăng nhập bằng Google thất bại. Vui lòng thử lại.
                    </p>
                </c:if>
                <c:if test="${param.error == 'invalid'}">
                    <p class="message error">
                        <i class="fas fa-exclamation-circle"></i> Tên đăng nhập hoặc mật khẩu không đúng
                    </p>
                </c:if>
                <c:if test="${param.error == 'role'}">
                    <p class="message error">
                        <i class="fas fa-exclamation-circle"></i> Vai trò người dùng không hợp lệ
                    </p>
                </c:if>
                <c:if test="${param.register == 'success'}">
                    <p class="message success">
                        <i class="fas fa-check-circle"></i> Đăng ký thành công. Vui lòng đăng nhập
                    </p>
                </c:if>
                <c:if test="${param.reset == 'success'}">
                    <p class="message success">
                        <i class="fas fa-check-circle"></i> Đặt lại mật khẩu thành công. Vui lòng đăng nhập
                    </p>
                </c:if>

                <div class="links">
                    <a href="forgot_password.jsp" class="register-btn">
                        <i class="fas fa-key"></i> Quên mật khẩu?
                    </a>
                    <a href="register.jsp" class="register-btn">
                        <i class="fas fa-user-plus"></i> Đăng ký tài khoản
                    </a>
                </div>

                <div class="divider">
                    <span>Hoặc đăng nhập bằng Google</span>
                </div>

                <div class="google-login-container">
                    <div id="g_id_onload"
                         data-client_id="521313520349-i2fmauofkoknnat6tjm06m2mgav5je65.apps.googleusercontent.com"
                         data-callback="handleGoogleSignIn"
                         data-auto_prompt="false">
                    </div>
                    <div class="g_id_signin" 
                         data-type="icon"
                         data-size="large"
                         data-theme="outline"
                         data-text="sign_in_with"
                         data-shape="rectangular">
                    </div>
                </div>
            </div>
        </div>
        <script>
            function handleGoogleSignIn(response) {
                console.log("Google sign-in response:", response);

                if (response.credential) {
                    // Tạo form ẩn để gửi token
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'GoogleLoginServlet';

                    const tokenInput = document.createElement('input');
                    tokenInput.type = 'hidden';
                    tokenInput.name = 'id_token';
                    tokenInput.value = response.credential;

                    form.appendChild(tokenInput);
                    document.body.appendChild(form);

                    // Hiển thị loading indicator
                    const loader = document.createElement('div');
                    loader.style.position = 'fixed';
                    loader.style.top = '0';
                    loader.style.left = '0';
                    loader.style.width = '100%';
                    loader.style.height = '100%';
                    loader.style.backgroundColor = 'rgba(255,255,255,0.7)';
                    loader.style.zIndex = '9999';
                    loader.style.display = 'flex';
                    loader.style.justifyContent = 'center';
                    loader.style.alignItems = 'center';
                    loader.innerHTML = '<div style="font-size:24px;color:#764ba2;">Đang đăng nhập...</div>';
                    document.body.appendChild(loader);

                    form.submit();
                } else {
                    console.error("Google sign-in failed:", response);
                    alert("Đăng nhập bằng Google thất bại. Vui lòng thử lại.");
                }
            }
        </script>

    </body>
</html>