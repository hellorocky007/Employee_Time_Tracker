package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Util.DBConnection;
import model.Task;

public class showDAO {

    public List<Task> getTasks() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT id, uid, task, task_category, description, date, start_time, end_time, duration, employee_name FROM tasks";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setUid(rs.getInt("uid"));
                task.setTask(rs.getString("task"));
                task.setTaskCategory(rs.getString("task_category"));
                task.setDescription(rs.getString("description"));
                task.setDate(rs.getDate("date"));
                task.setStartTime(rs.getTime("start_time"));
                task.setEndTime(rs.getTime("end_time"));
                task.setDuration(rs.getInt("duration"));
                task.setEmployeeName(rs.getString("employee_name"));  // Set the employee name
                tasks.add(task);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error retrieving tasks from the database: " + e.getMessage());
        }

        return tasks;
    }
}
