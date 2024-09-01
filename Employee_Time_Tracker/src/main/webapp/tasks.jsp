<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList, java.util.List" %>
<%@ page import="model.Task" %>
<%@ page import="Util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tasks</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 30px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .table {
            margin-bottom: 0;
        }
        .thead-dark {
            background-color: #343a40;
            color: #ffffff;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center mb-4">Tasks</h2>
        <table class="table table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Employee Name</th>
                    <th>Task</th>
                    <th>Category</th>
                    <th>Description</th>
                    <th>Date</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Duration</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection parameters
                   
                    
                    List<Task> tasks = new ArrayList<>();
                    
                    try {
                        // Load database driver
                        Connection connection = DBConnection.getConnection();
                        
                        // Prepare SQL query to fetch tasks
                        String sql = "SELECT id, uid, task, task_category, description, date, start_time, end_time, duration FROM tasks";
                        PreparedStatement statement = connection.prepareStatement(sql);
                        ResultSet resultSet = statement.executeQuery();
                        
                        // Prepare SQL query to fetch employee name
                        String userSql = "SELECT uname FROM users WHERE uid = ?";
                        PreparedStatement userStatement = connection.prepareStatement(userSql);
                        
                        // Process result set
                        while (resultSet.next()) {
                            Task task = new Task();
                            task.setId(resultSet.getInt("id"));
                            task.setUid(resultSet.getInt("uid"));
                            task.setTask(resultSet.getString("task"));
                            task.setTaskCategory(resultSet.getString("task_category"));
                            task.setDescription(resultSet.getString("description"));
                            task.setDate(resultSet.getDate("date"));
                            task.setStartTime(resultSet.getTime("start_time"));
                            task.setEndTime(resultSet.getTime("end_time"));
                            task.setDuration(resultSet.getInt("duration"));
                            
                            // Fetch employee name based on uid
                            userStatement.setInt(1, task.getUid());
                            ResultSet userResultSet = userStatement.executeQuery();
                            if (userResultSet.next()) {
                                task.setEmployeeName(userResultSet.getString("uname"));
                            } else {
                                task.setEmployeeName("Unknown");
                            }
                            userResultSet.close();
                            
                            tasks.add(task);
                        }
                        
                        // Close resources
                        resultSet.close();
                        statement.close();
                        userStatement.close();
                        connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<tr><td colspan='10' class='text-center'>Error retrieving tasks: " + e.getMessage() + "</td></tr>");
                    }
                    
                    // Display tasks in the table
                    if (tasks != null && !tasks.isEmpty()) {
                        for (Task task : tasks) {
                %>
                <tr>
                    <td><%= task.getId() %></td>
                    <td><%= task.getUid() %></td>
                    <td><%= task.getEmployeeName() %></td>
                    <td><%= task.getTask() %></td>
                    <td><%= task.getTaskCategory() %></td>
                    <td><%= task.getDescription() %></td>
                    <td><%= task.getDate() %></td>
                    <td><%= task.getStartTime() %></td>
                    <td><%= task.getEndTime() %></td>
                    <td><%= task.getDuration() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="10" class="text-center">No tasks found</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
