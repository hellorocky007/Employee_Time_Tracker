<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.User" %>
<%@ page import="Util.DBConnection" %> <!-- Import User class from appropriate package -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        
        .container {
            margin-top: 30px;
            background-color: #ffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .table {
            margin-bottom: 0;
        }
        #ok{
            background-color: #0027ff;
            color: #ffff;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f2f2f2;
        }
        .btn-primary {
            background-color: #2525d1;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .no-data {
            text-align: center;
            color: #6c757d;
            padding: 20px;
        }
    </style>
</head>
<body style="background-image: url('herobg.png'); background-size: cover; background-repeat: no-repeat;">
    <div class="container">
        <h2 class="text-center mb-4">Users</h2>
        <table class="table table-striped">
            <thead class="thead" id="ok">
                <tr>
                    <th>User ID</th>
                    <th>Username</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<User> users = new ArrayList<>(); // Ensure User class is correctly imported
                    
                    
                    try {
                    	Connection connection = DBConnection.getConnection();
                        String sql = "SELECT uid, uname FROM users";
                        PreparedStatement statement = connection.prepareStatement(sql);
                        ResultSet resultSet = statement.executeQuery();

                        while (resultSet.next()) {
                            User user = new User();
                            user.setId(resultSet.getInt("uid"));
                            user.setName(resultSet.getString("uname"));
                            users.add(user);
                        }
                        resultSet.close();
                        statement.close();
                        connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    if (users != null && !users.isEmpty()) {
                        for (User user : users) {
                %>
                <tr>
                    <td><%= user.getId() %></td>
                    <td><%= user.getName() %></td>
                    <td>
                        <form action="Web" method="get" style="display:inline;">
                            <input type="hidden" name="userId" value="<%= user.getId() %>">
                            <button type="submit" class="btn btn-primary">View</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="3" class="no-data">No users found</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
