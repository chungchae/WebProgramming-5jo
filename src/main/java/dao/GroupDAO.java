package dao;

import db.DBConnection;
import model.Group;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class GroupDAO {
    public List<Group> findAllGroups() {
        List<Group> groups = new ArrayList<>();
        String query = "SELECT * FROM group_table";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

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

    public List<Group> findGroups(String groupType, String groupName) {
        List<Group> groups = new ArrayList<>();
        String query = "SELECT * FROM group_table WHERE category = ? AND title LIKE ?";

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

    public Group findGroupById(int id) {
        String query = "SELECT * FROM group_table WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Group(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getInt("max_members"),
                        rs.getInt("current_members")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateGroup(int id, String title, String category, String description, String imageUrl, int maxMembers) {
        String query = "UPDATE group_table SET title = ?, category = ?, description = ?, image_url = ?, max_members = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, title);
            pstmt.setString(2, category);
            pstmt.setString(3, description);
            pstmt.setString(4, imageUrl);
            pstmt.setInt(5, maxMembers);
            pstmt.setInt(6, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteGroup(int id) {
        String query = "DELETE FROM group_table WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<User> getUsersByGroupId(int groupId) {
        List<User> users = new ArrayList<>();
        String query = "SELECT u.user_id, u.name FROM User u " +
                "JOIN GroupUser gu ON u.user_id = gu.user_id " +
                "WHERE gu.group_table_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, groupId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("user_id"));
                user.setName(rs.getString("name"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
}
