<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System - Login</title>
    <link rel="stylesheet" href="css/adminstyles.css">
</head>
<body style="background-image: url('herobg.png'); background-size: cover; background-repeat: no-repeat;">
    <div class="container">
        <div class="left-section">
            <div class="planet">
                <img src="left.jpeg" alt="time tracker">
            </div>
            <div class="title">Admin</div>
        </div>
        <div class="right-section">
            <form action="adminLogin" method="post" class="login-form">
                <div class="form-group">
                    <label for="username">Email</label>
                    <input type="text" id="username" name="username" placeholder="Email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Password" required>
                </div>
                <div class="buttons">
                    <button type="submit" class="btn sign-in">Sign in</button>
                </div>
                <div class="error-message">
                    <c:if test="${not empty param.error}">
                        ${param.error}
                    </c:if>
                </div>
                
            </form>
        </div>
    </div>
</body>
</html>
