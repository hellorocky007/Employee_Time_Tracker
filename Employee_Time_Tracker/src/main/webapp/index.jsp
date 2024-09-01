<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Time Tracker Manager</title>
    <link rel="stylesheet" href="css/haistyles.css">
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
            <div class="panel panel-primary">
                <div class="panel-body">
                    <div class="panel-success">
                        <div class="panel-body">
                            <form action="login" method="post" class="login-form">
                                <div class="form-group input-group">
                                    <label for="Email">Email</label>
                                    <input type="email" class="form-control" id="Email" placeholder="Email" name="email" required>
                                </div>
                                <div class="form-group input-group">
                                    <label for="Password">Password</label>
                                    <input type="password" class="form-control" id="Password" placeholder="Password" name="password" required>
                                </div>
                                <div class="buttons">
                                    <button type="submit" class="btn btn-primary sign-in">Sign in</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="text-center">
                        <p>New user? <a href="register.jsp">Create an account</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
