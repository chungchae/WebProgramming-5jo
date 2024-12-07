package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://54.180.141.141:3306/5jo?useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root_user"; // MySQL 사용자명
    private static final String PASSWORD = "123"; // MySQL 비밀번호

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found!");
        }
    }
}
