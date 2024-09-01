package Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/expense";
    private static final String USER = "root";
    private static final String PASSWORD = "jay@19691";

    public static Connection getConnection() throws ClassNotFoundException {
        Connection connection = null;
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database connection established successfully.");
        } catch (SQLException e) {
            System.err.println("Failed to establish database connection: " + e.getMessage());
        }
        return connection;
    }
}
