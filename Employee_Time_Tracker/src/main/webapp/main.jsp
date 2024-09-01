<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee and Admin Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('bg.jpg'); /* Add background image */
            background-size: cover;
            
            margin: 0;
            padding: 0;
        }
       .container {
            width: 80%;
            margin: auto;
            text-align: center;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8); /* Add transparent background to container */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
       .button {
            background-color: #4CAF50;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
       .button:hover {
            background-color: #3e8e41;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Employee and Admin Login</h1>
        <button class="button" onclick="location.href='index.jsp'">Employee Login</button>
        <button class="button" onclick="location.href='adminlogin.jsp'">Admin Login</button>
        <p>Already an employee? <a href="index.jsp">Login here</a></p>
    </div>
</body>
</html>