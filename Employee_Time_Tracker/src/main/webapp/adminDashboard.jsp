<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page session="true"%>
<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }

    // Fetch employee data from the database and store it in a list (this is just a placeholder)
    List<String> employees = new ArrayList<>();
    employees.add("Employee 1");
    employees.add("Employee 2");
    employees.add("Employee 3");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fffff; /* Dark background */
            color: #e0e0e0; /* Light text color */
        }
        .navbar {
             background: rgb(16,13,37); /* Darker navbar background */
        }
        .navbar-nav .nav-link {
            color: #e0e0e0; /* Light text color */
        }
        .navbar-nav .nav-link:hover {
            color: #f0a500; /* Highlight color */
        }
        .container {
            margin-top: 20px;
        }
        .jumbotron {
             background: rgb(16,13,37);/* Darker background for jumbotron */
            color: #e0e0e0; /* Light text color */
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
        }
        .btn-primary {
            background-color: #f0a500; /* Highlight button color */
            border: none;
        }
        .btn-primary:hover {
            background-color: #e07b00; /* Darker shade on hover */
        }
        @media (max-width: 768px) {
            .jumbotron {
                padding: 10px;
            }
        }
    </style>
</head>
<body style="background-image: url('herobg.png'); background-size: cover; background-repeat: no-repeat;">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">Admin Portal</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="adminDashboard.jsp">Dashboard</a>
                </li>
                
                <li class="nav-item active">
                    <a class="nav-link" href="users.jsp">View Employee</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="logout1.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Content -->
    <div class="container">
        <div class="jumbotron">
            <h1 class="display-4">Welcome, <%= admin %>!</h1>
            <p class="lead">This is your admin dashboard where you can manage all the administrative tasks.</p>
            <hr class="my-4">
            <h3>Employee Management</h3>
            <!-- You can add more content here related to employee management -->
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
