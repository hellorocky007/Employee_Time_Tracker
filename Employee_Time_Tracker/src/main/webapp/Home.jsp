<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="Util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="images/favicon.png" sizes="80x80">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style2.css">
    <title>Time Tracker - Employee Dashboard</title>
    <style>
        /* Custom CSS styles */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #ffffff, #e0e0f1);
        }
        .fa-chart-line{
	color:#fff;
}
        .chartButton{
	border:none;
	background-color: rgba(255, 255, 255, 0);
	font-size:20px;
	color:white;
	font-family:semi-bold 600;
	text-decoration:none;
}
        .container {
        
        
            margin-top: 50px;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
        }
        .btn-container {
            margin-bottom: 20px;
        }
        .text-center{
        text-align:center;
        
        }
        h2{
        color:#000FF;
        }
        .table th, .table td {
            vertical-align: middle;
            padding: 10px 20px 10px 20px;
            
        }
        .delete-btn, .update-btn {
            cursor: pointer;
            padding: 5px 10px;
            font-size: 14px;
            border: none;
            border-radius: 3px;
            color: #fff;
        }
        .delete-btn {
            background-color: #dc3545;
        }
        .update-btn {
            background-color: #007bff;
        }
        .delete-btn:hover, .update-btn:hover {
            opacity: 0.8;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f5f5f5;
        }
        .table-striped tbody tr:hover {
            background-color: #e2e6ea;
        }
        .header-blue {
            background-color: #007bff;
            color: #fff;
        }
        .header-green {
            background-color: #28a745;
            color: #fff;
        }
        .header-purple {
            background-color: #6f42c1;
            color: #fff;
        }
        .table .thead-dark th {
            color: #fff;
            background-color: #000bfe;
            border-color: #454d55;
        }
        .page_name{
        font-weight:600;
        color:#ffff;
        }
    </style>
</head>
<body style="background-image: url('herobg.png'); background-size: cover; background-repeat: no-repeat;">
    <header class="header">
        <div class="header__container">
            <a href="#" class="header__logo logo">Time Tracker</a>
            <h3 class="page_name text_color">Welcome, <%= session.getAttribute("username") %></h3>
        </div>
    </header>
    <div class="nav" id="navbar">
        <nav class="nav__container">
            <div class="">
                <div class="nav__list">
                    <div class="nav__items">
                        <a href="Home.jsp" class="nav__link">
                            <i class="fas fa-tachometer-alt nav__icon"></i>
                            <span class="nav__name">Dashboard</span>
                        </a>
                        <a href="add.jsp" class="nav__link">
                            <i class="fas fa-tasks nav__icon"></i>
                            <span class="nav__name">Tasks</span>
                        </a>
                        <a href="Home.jsp" class="nav__link">
                            <i class="fas fa-clipboard nav__icon"></i>
                            <span class="nav__name">Timesheets</span>
                        </a>
                        <form action="Web" method="get" style="display:inline;">
                            <input type="hidden" name="userId" value="<%= session.getAttribute("uid") %>">
                            <i class="fas fa-chart-line nav_icon" ></i>
                            <button type="submit" class="chartButton">Chart</button>
                        </form>
                        <a href="logout.jsp" class="nav__link">
                            <i class="fas fa-sign-out-alt nav__icon"></i>
                            <span class="nav__name">Logout</span>
                        </a>
                    </div>
                </div>
            </div>
        </nav>
    </div>

    <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Integer uid = null;

        // Retrieve the logged-in user's uid from the session
        uid = (Integer) session.getAttribute("uid");

        if (uid == null) {
            // User is not logged in, redirect to login page or show an error message
            response.sendRedirect("index.jsp");
            return;
        }

        try {
        	conn = DBConnection.getConnection();
            String sql = "SELECT * FROM tasks WHERE uid = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, uid);
            rs = stmt.executeQuery();
    %>

    <div class="container">
    <h2 class="text-center">Task Table</h2>
    <table class="table table-striped">
        <thead class="thead-dark">
            <tr>
                <th>Task ID</th>
                <th>Project</th>
                <th>Date</th>
                <th>Duration</th>
                <th>Task Category</th>
                <th>Description</th>
                <th>Action</th>
                <th>Action</th> <!-- New Column for Update Button -->
            </tr>
        </thead>
        <tbody>
            <% while (rs.next()) { %>
            <tr id="row_<%= rs.getInt("id") %>">
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("task") %></td>
                <td><%= rs.getString("date") %></td>
                <td><%= rs.getString("duration") %></td>
                <td><%= rs.getString("task_category") %></td>
                <td><%= rs.getString("description") %></td>
                <td><button class='delete-btn' onclick='deleteRow(<%= rs.getInt("id") %>);'>Delete</button></td>
                <td><button class='update-btn' onclick='updateRow(<%= rs.getInt("id") %>);'>Update</button></td> <!-- Update Button -->
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<script>
    function deleteRow(taskId) {
        if (confirm("Are you sure you want to delete this task?")) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    // Remove the row from the table
                    var row = document.getElementById("row_" + taskId);
                    row.parentNode.removeChild(row);
                }
            };
            xhttp.open("POST", "DeleteAction", true); // Change the URL to point to your DeleteAction servlet
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("task_id=" + taskId);
        }
    }

    function updateRow(taskId) {
        if (confirm("Are you sure you want to update this task?")) {
            // Redirect the user to an update page with the task ID
            window.location.href = "UpdateAction?task_id=" + taskId; // Change the URL to point to your UpdateAction servlet
        }
    }
</script>
    <%
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>