package com.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import Util.DBConnection;

@WebServlet("/Web")
public class Web extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings({ "unchecked", "resource" })
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        JSONObject responseJson = new JSONObject();

        try {
            conn = DBConnection.getConnection();

            LocalDate today = LocalDate.now();
            LocalDate startOfWeek = today.with(java.time.DayOfWeek.MONDAY);
            LocalDate endOfWeek = startOfWeek.plusDays(6);
            LocalDate startOfMonth = today.withDayOfMonth(1);
            LocalDate endOfMonth = today.withDayOfMonth(today.lengthOfMonth());

            String dailySql = "SELECT task, SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS daily_hours "
                            + "FROM tasks "
                            + "WHERE uid = ? AND date = ? "
                            + "GROUP BY task";

            String weeklySql = "SELECT task, SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS weekly_hours "
                             + "FROM tasks "
                             + "WHERE uid = ? AND date BETWEEN ? AND ? "
                             + "GROUP BY task";

            String monthlySql = "SELECT task, SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS monthly_hours "
                              + "FROM tasks "
                              + "WHERE uid = ? AND date BETWEEN ? AND ? "
                              + "GROUP BY task";

            stmt = conn.prepareStatement(dailySql);
            stmt.setString(1, userId);
            stmt.setString(2, today.format(DateTimeFormatter.ISO_DATE));
            rs = stmt.executeQuery();
            JSONArray dailyTasks = new JSONArray();
            while (rs.next()) {
                JSONObject taskObj = new JSONObject();
                taskObj.put("task", rs.getString("task"));
                taskObj.put("daily_hours", Math.abs(rs.getInt("daily_hours")));
                dailyTasks.add(taskObj);
            }

            stmt = conn.prepareStatement(weeklySql);
            stmt.setString(1, userId);
            stmt.setString(2, startOfWeek.format(DateTimeFormatter.ISO_DATE));
            stmt.setString(3, endOfWeek.format(DateTimeFormatter.ISO_DATE));
            rs = stmt.executeQuery();
            JSONArray weeklyTasks = new JSONArray();
            while (rs.next()) {
                JSONObject taskObj = new JSONObject();
                taskObj.put("task", rs.getString("task"));
                taskObj.put("weekly_hours", Math.abs(rs.getInt("weekly_hours")));
                weeklyTasks.add(taskObj);
            }

            stmt = conn.prepareStatement(monthlySql);
            stmt.setString(1, userId);
            stmt.setString(2, startOfMonth.format(DateTimeFormatter.ISO_DATE));
            stmt.setString(3, endOfMonth.format(DateTimeFormatter.ISO_DATE));
            rs = stmt.executeQuery();
            JSONArray monthlyTasks = new JSONArray();
            while (rs.next()) {
                JSONObject taskObj = new JSONObject();
                taskObj.put("task", rs.getString("task"));
                taskObj.put("monthly_hours", Math.abs(rs.getInt("monthly_hours")));
                monthlyTasks.add(taskObj);
            }

            responseJson.put("daily", dailyTasks);
            responseJson.put("weekly", weeklyTasks);
            responseJson.put("monthly", monthlyTasks);

            request.setAttribute("jsonData", responseJson.toJSONString());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/chart.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();

            responseJson.put("error", "SQL Exception: " + e.getMessage());
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(responseJson);
            out.flush();
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
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
    }
}
