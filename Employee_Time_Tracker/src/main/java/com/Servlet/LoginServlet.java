package com.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Util.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    

    static {
        try {
            // Load MySQL JDBC driver class
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new IllegalStateException("Failed to load MySQL JDBC driver: " + e.getMessage());
        }
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uemail = request.getParameter("email");
        String upass = request.getParameter("password");

        // Database connection
        try (Connection connection = DBConnection.getConnection();) {
            String sql = "SELECT uid, uname FROM users WHERE uemail = ? AND upass = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, uemail);
            statement.setString(2, upass);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // User found, store user's id and name in session
                int uid = resultSet.getInt("uid");
                String uname = resultSet.getString("uname");
                HttpSession session = request.getSession();
                session.setAttribute("uid", uid);
                session.setAttribute("username", uname);
                session.setAttribute("employeeName", uname);

                // Redirect to dashboard or any other page
                response.sendRedirect("Home.jsp");
            } else {
                // User not found, show error message
                response.setContentType("text/html");
                
                request.setAttribute("errorMessage", "Invalid username or password,Please Try Again");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing login request");
        } catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    }
}
