<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Task Form</title>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    h2 {
      color: rgb(127,103,138);
    }
    .container {
      max-width: 600px;
      margin: 0 auto;
      margin-top: 50px;
    }
    .form-group label {
      font-weight: semi-bold;
      font-size: 15px;
      color: #ffff;
    }
    .form-group input[type="text"], 
    .form-group input[type="date"], 
    .form-group input[type="time"], 
    .form-group textarea {
      border-radius: 10px !important;
      font-size: 15px;
      padding: 5px 15px 5px 10px;
    }
    .card {
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      background-color: rgb(16,13,37);
    }
    .error-message {
      color: red;
      font-weight: bold;
      text-align: center;
    }
    .btn {
      background: rgb(21,16,48);
      color: #ffff;
      font-weight: 900;
      font-size: 12px;
      padding: 8px 35px;
      border: 1px solid #262533;
      text-align: center;
      cursor: pointer;
      border-radius: 5px;
    }
    .btn:hover {
      background: rgb(98,46,189);
      color: #ffff;
    }
  </style>
</head>
<body style="background-image: url('herobg.png'); background-size: cover; background-repeat: no-repeat;">

<div class="container">
  <div class="card p-5">
    <h2 class="text-center">Update Task</h2>
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
    <p class="error-message"><%= errorMessage %></p>
    <%
        }
        
        String taskId = request.getParameter("task_id");
        if (taskId != null) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
            	conn = DBConnection.getConnection();
                String sql = "SELECT * FROM tasks WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(taskId));
                rs = stmt.executeQuery();

                if (rs.next()) {
    %>
    <form action="UpdateAction" method="post">
      <input type="hidden" name="task_id" value="<%= taskId %>">
      <div class="form-group">
        <label for="task"><i class="bi bi-journal"></i> Task:</label>
        <input type="text" class="form-control" id="task" name="task" value="<%= rs.getString("task") %>" readonly>
      </div>
      <div class="form-group">
        <label for="task_category"><i class="bi bi-card-checklist"></i> Task Category:</label>
        <input type="text" class="form-control" id="task_category" name="task_category" value="<%= rs.getString("task_category") %>" readonly>
      </div>
      <div class="form-group">
        <label for="date"><i class="bi bi-calendar"></i> Date:</label>
        <input type="date" class="form-control" id="date" name="date" value="<%= rs.getString("date") %>" readonly>
      </div>
      <div class="form-group">
        <label for="start_time"><i class="bi bi-clock"></i> Start Time:</label>
        <input type="time" class="form-control" id="start_time" name="start_time" value="<%= rs.getString("start_time") %>" required>
      </div>
      <div class="form-group">
        <label for="end_time"><i class="bi bi-clock"></i> End Time:</label>
        <input type="time" class="form-control" id="end_time" name="end_time" value="<%= rs.getString("end_time") %>" required>
      </div>
      <div class="form-group">
        <label for="description"><i class="bi bi-textarea"></i> Description:</label>
        <textarea class="form-control" id="description" name="description" rows="3" required><%= rs.getString("description") %></textarea>
      </div>
      <button type="submit" class="btn">Update Task</button>
    </form>
    <%
                } else {
                    out.println("<p class='error-message'>Task not found</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        } else {
            out.println("<p class='error-message'>Invalid Task ID</p>");
        }
    %>
  </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
