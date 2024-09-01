package com.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
			if (validateAdmin(username, password)) {
			    HttpSession session = request.getSession();
			    session.setAttribute("admin", username);
			    response.sendRedirect("adminDashboard.jsp");
			} else {
			    request.setAttribute("errorMessage", "Invalid username or password");
			    request.getRequestDispatcher("error.jsp").forward(request, response);
			}
		} catch (ClassNotFoundException | IOException | ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    private boolean validateAdmin(String username, String password) throws ClassNotFoundException {
        boolean isValid = false;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "SELECT * FROM admin WHERE username = ? AND password = ?")) {
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    isValid = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isValid;
    }
}
