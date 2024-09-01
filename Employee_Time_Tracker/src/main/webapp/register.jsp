<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Time Tracker Manager</title>
    <link rel="stylesheet" href="css/haistyles.css">
    <link rel="icon" type="image/png" href="images/login.jpeg" />
</head>
<body style="background-image: url('herobg.png'); background-size: cover; background-repeat: no-repeat;">
    <div class="container">
         <div class="left-section">
            <div class="planet">
                <img src="left.jpeg" alt="time tracker">
            </div>
            <div class="title">Time Tracker Manager</div>
        </div>
        <div class="right-section">
            <form class="login-form" action="register" method="post">
                <div class="input-group">
                    <label for="fname">Full Name</label>
                    <input type="text" id="fname" name="username" autocomplete="off" required placeholder="Write your full name here">
                </div>
                <div class="input-group">
                    <label for="name">Email</label>
                    <input type="email" id="name" name="email" autocomplete="off" required placeholder="Email">
                </div>
                <div class="input-group">
                    <label for="inputPassword3">Password</label>
                    <input type="password" id="inputPassword3" name="password" required placeholder="Password">
                </div>
                <div class="buttons">
                    <button type="submit" class="btn sign-up">Create My Account</button>
                </div>
                <div class="text-center">
                    <p>Already have an account? <a href="index.jsp">Sign in here</a></p>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
