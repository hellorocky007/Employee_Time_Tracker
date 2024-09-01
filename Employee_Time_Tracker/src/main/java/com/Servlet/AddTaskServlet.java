package com.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import Util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add")
public class AddTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String task = request.getParameter("project");
        String date = request.getParameter("date_1");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String taskCategory = request.getParameter("task_category");
        String description = request.getParameter("description");

        HttpSession session = request.getSession();
        Integer uid = (Integer) session.getAttribute("uid");
        if (uid == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBConnection.getConnection();

            // Check for duplicate task in a day
            String duplicateTaskQuery = "SELECT * FROM tasks WHERE uid = ? AND date = ? AND task = ?";
            PreparedStatement duplicateTaskStmt = conn.prepareStatement(duplicateTaskQuery);
            duplicateTaskStmt.setInt(1, uid);
            duplicateTaskStmt.setString(2, date);
            duplicateTaskStmt.setString(3, task);
            ResultSet duplicateTaskResultSet = duplicateTaskStmt.executeQuery();
            if (duplicateTaskResultSet.next()) {
                request.setAttribute("errorMessage", "Task already exists for this day.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            // Calculate duration in hours
            double durationHours = calculateDurationHours(startTime, endTime);
            if (durationHours < 0) {
                request.setAttribute("errorMessage", "End time cannot be earlier than start time.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            // Check if total duration of tasks in a day exceeds 8 hours
            String totalDurationQuery = "SELECT SUM(duration) FROM tasks WHERE uid = ? AND date = ?";
            PreparedStatement totalDurationStmt = conn.prepareStatement(totalDurationQuery);
            totalDurationStmt.setInt(1, uid);
            totalDurationStmt.setString(2, date);
            ResultSet totalDurationResultSet = totalDurationStmt.executeQuery();
            double totalDurationHours = 0;
            if (totalDurationResultSet.next()) {
                totalDurationHours = totalDurationResultSet.getDouble(1);
            }
            if (totalDurationHours + durationHours > 8) {
                request.setAttribute("errorMessage", "Total duration of tasks in a day cannot exceed 8 hours.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            // Insert query with duration in hours
            String sql = "INSERT INTO tasks (uid, task, task_category, description, date, start_time, end_time, duration) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, uid); // User ID
            stmt.setString(2, task); // Task
            stmt.setString(3, taskCategory); // Task Category
            stmt.setString(4, description); // Description
            stmt.setString(5, date); // Date
            stmt.setString(6, startTime); // Start Time
            stmt.setString(7, endTime); // End Time
            stmt.setDouble(8, durationHours); // Duration

            stmt.executeUpdate();

            response.sendRedirect(request.getContextPath() + "/error.jsp");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "JDBC Driver not found");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private double calculateDurationHours(String startTime, String endTime) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
            LocalTime start= LocalTime.parse(startTime, formatter);
            LocalTime end = LocalTime.parse(endTime, formatter);

            long durationMinutes = Duration.between(start, end).toMinutes();
            double durationHours = durationMinutes / 60.0;
            return durationHours >= 0 ? durationHours : -1; // Check for negative duration
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // Handle the exception properly in your application
        }
    }
}