 package Dao;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import Util.DBConnection;
import model.User;

public class UserDAO {
    
    static {
        try {
            // Load MySQL JDBC driver class
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new IllegalStateException("Failed to load MySQL JDBC driver: " + e.getMessage());
        }
    }

    public boolean registerUser(String uname, String uemail, String upass) throws ClassNotFoundException {
        try (Connection connection = DBConnection.getConnection()) {
            String sql = "INSERT INTO users (uname, uemail, upass, Creation_date) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, uname);
            statement.setString(2, uemail);
            statement.setString(3, upass);
            statement.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            int rowsInserted = statement.executeUpdate();

            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public User getUser(String uemail, String upass) throws ClassNotFoundException {
        try (Connection connection = DBConnection.getConnection();) {
            String sql = "SELECT uid, uname FROM users WHERE uemail =? AND upass =?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, uemail);
            statement.setString(2, upass);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getInt("uid"));
                user.setName(resultSet.getString("uname"));
                return user;
            } else {
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}