package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Task;
import Util.DBConnection;

public class TaskDAO {
    public List<Task> getTasks(String userId) throws ClassNotFoundException {
        List<Task> tasks = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT task, SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS daily_hours " +
                         "FROM tasks WHERE uid = ? AND date = ? GROUP BY task";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            stmt.setString(2, java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ISO_DATE));
            rs = stmt.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setTask(rs.getString("task"));
                task.setDailyHours(Math.abs(rs.getInt("daily_hours")));
                tasks.add(task);
            }

            // Weekly and monthly tasks logic here...

        } catch (SQLException e) {
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

        return tasks;
    }
}
