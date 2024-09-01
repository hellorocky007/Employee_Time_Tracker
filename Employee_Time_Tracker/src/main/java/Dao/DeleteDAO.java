package Dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import Util.DBConnection;
import Util.DBConnection;
public class DeleteDAO {
    public boolean deleteTask(int taskId) {
        boolean deleted = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DBConnection.getConnection();
            String sql = "DELETE FROM tasks WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, taskId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                deleted = true;
            }

            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return deleted;
    }
}