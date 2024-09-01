package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Util.DBConnection;
import model.Task;

public class UpdateDAO {
   

    public Task getTask(int taskId) {
        Task task = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM tasks WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, taskId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                task = new Task();
                task.setId(rs.getInt("id"));
                task.setUid(rs.getInt("uid"));
                task.setTask(rs.getString("task"));
                task.setTaskCategory(rs.getString("task_category"));
                task.setDescription(rs.getString("description"));
                task.setDate(rs.getDate("date"));
                task.setStartTime(rs.getTime("start_time"));
                task.setEndTime(rs.getTime("end_time"));
                task.setDuration(rs.getInt("duration"));
                task.setEmployeeName(rs.getString("employee_name"));
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return task;
    }

    public boolean updateTask(int taskId, String startTime, String endTime, String description) {
        boolean updated = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DBConnection.getConnection();
            String sql = "UPDATE tasks SET start_time = ?, end_time = ?, description = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, startTime);
            stmt.setString(2, endTime);
            stmt.setString(3, description);
            stmt.setInt(4, taskId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                updated = true;
            }

            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return updated;
    }
}
