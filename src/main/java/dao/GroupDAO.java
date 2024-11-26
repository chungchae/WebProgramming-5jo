package dao;

import db.DBConnection;
import model.Group;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class GroupDAO {
    public List<Group> findGroups(String groupType, String groupName) {
        List<Group> groups = new ArrayList<>();
        String query = "SELECT * FROM groups WHERE category = ? AND title LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, groupType);
            pstmt.setString(2, "%" + groupName + "%");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Group group = new Group(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getInt("max_members"),
                        rs.getInt("current_members")
                );
                groups.add(group);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groups;
    }

    public boolean createGroup(String title, String category, String description, String imageUrl, int maxMembers) {
        String query = "INSERT INTO group_table (title, category, description, image_url, max_members, current_members) " +
                "VALUES (?, ?, ?, ?, ?, 0)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, title);
            pstmt.setString(2, category);
            pstmt.setString(3, description);
            pstmt.setString(4, imageUrl);
            pstmt.setInt(5, maxMembers);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0; // 성공적으로 삽입되면 true 반환
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
