package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/5jodb"; // 데이터베이스 이름 변경
    private static final String USER = "root"; // MySQL 사용자명
    private static final String PASSWORD = "root1234"; // MySQL 비밀번호

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found!");
        }
    }
}
