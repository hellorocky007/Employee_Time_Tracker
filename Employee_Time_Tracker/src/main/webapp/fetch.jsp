<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="Util.DBConnection" %>
<%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    Integer uid = null;

    // Retrieve the logged-in user's uid from the session
    uid = (Integer) session.getAttribute("uid");

    if (uid == null) {
        // User is not logged in, redirect to login page or show an error message
        response.sendRedirect("Home.jsp");
        return;
    }

    try {
    	conn = DBConnection.getConnection();
        String sql = "SELECT * FROM tasks WHERE uid = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, uid);
        rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fetch Tasks</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Custom CSS styles */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to bottom right, #ffffff, #e0e0f1);
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
        .table th, .table td {
            vertical-align: middle;
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
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Task Table</h2>
        <div class="btn-container">
            <a href="Home.jsp" class="btn btn-primary home-btn">Home</a>
        </div>
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
                xhttp.open("POST", "delete.jsp", true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.send("task_id=" + taskId);
            }
        }

        function updateRow(taskId) {
            if (confirm("Are you sure you want to update this task?")) {
                // Redirect the user to an update page with the task ID
                window.location.href = "update.jsp?task_id=" + taskId;
            }
        }
    </script>
</body>
</html>
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
