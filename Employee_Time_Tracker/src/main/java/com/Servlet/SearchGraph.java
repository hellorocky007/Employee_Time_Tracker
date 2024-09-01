package com.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import Util.DBConnection;

@WebServlet("/SearchGraph")
public class SearchGraph extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        JSONObject responseJson = new JSONObject();

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT task, SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS total_hours "
                       + "FROM tasks "
                       + "WHERE uid = ? AND DATE(date) BETWEEN ? AND ? "
                       + "GROUP BY task";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            stmt.setString(2, startDate);
            stmt.setString(3, endDate);
            rs = stmt.executeQuery();

            JSONArray tasks = new JSONArray();
            while (rs.next()) {
                JSONObject taskObj = new JSONObject();
                taskObj.put("task", rs.getString("task"));
                taskObj.put("total_hours", rs.getInt("total_hours")); // Removed Math.abs() as it might not be necessary
                tasks.add(taskObj);
            }

            responseJson.put("tasks", tasks);

            // Set response type to JSON
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(responseJson.toJSONString());
            out.flush();

        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            responseJson.put("error", "SQL Exception: " + e.getMessage());
            out.print(responseJson.toJSONString());
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
