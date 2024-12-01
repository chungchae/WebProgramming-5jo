package dao;

import db.DBConnection;
import model.Day;
import model.Group;
import model.User;

import java.sql.*;
import java.util.*;

public class GroupDAO {
    //main 화면, 최신 그룹 4개
    public List<Group> findLatestGroups() {
        List<Group> groups = new ArrayList<>();
        String query = "SELECT * FROM group_table ORDER BY id DESC LIMIT 4";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                groups.add(mapResultSetToGroup(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groups;
    }

    //main 화면, 카테고리 검색
    public List<Group> findGroupsByCategory(String category) {
        List<Group> groups = new ArrayList<>();
        String query = "SELECT * FROM group_table WHERE category = ? ORDER BY id DESC LIMIT 4";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                groups.add(mapResultSetToGroup(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groups;
    }

    private Group mapResultSetToGroup(ResultSet rs) throws SQLException {
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
    private List<Day> getDaysByGroupId(int groupId) {
        List<Day> days = new ArrayList<>();
        String query = "SELECT * FROM Day WHERE group_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, groupId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Day day = new Day();
                day.setDay(rs.getString("day"));
                day.setStartTime(rs.getString("start_time"));
                day.setEndTime(rs.getString("end_time"));
                days.add(day);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return days;
    }

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
                group.setDays(getDaysByGroupId(group.getId())); // Days 포함
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
                group.setDays(getDaysByGroupId(group.getId())); // Days 포함
                groups.add(group);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groups;
    }


    public boolean createGroup(String title, String description, String imageUrl, int maxMembers,
                               String[] categories, String[] days, String[] startTimes, String[] endTimes) {
        String groupQuery = "INSERT INTO group_table (title, description, image_url, max_members) VALUES (?, ?, ?, ?)";
        String categoryQuery = "INSERT INTO Category (group_id, category_name) VALUES (?, ?)";
        String dayQuery = "INSERT INTO Day (group_id, day, start_time, end_time) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // 그룹 생성
            int groupId = 0;
            try (PreparedStatement groupStmt = conn.prepareStatement(groupQuery, Statement.RETURN_GENERATED_KEYS)) {
                groupStmt.setString(1, title);
                groupStmt.setString(2, description);
                groupStmt.setString(3, imageUrl);
                groupStmt.setInt(4, maxMembers);
                groupStmt.executeUpdate();

                ResultSet rs = groupStmt.getGeneratedKeys();
                if (rs.next()) {
                    groupId = rs.getInt(1);
                }
            }

            // 카테고리 저장
            try (PreparedStatement categoryStmt = conn.prepareStatement(categoryQuery)) {
                for (String category : categories) {
                    if (category != null && !category.trim().isEmpty()) { // 빈 값이나 null인 경우 제외
                        categoryStmt.setInt(1, groupId);
                        categoryStmt.setString(2, category);
                        categoryStmt.addBatch();
                    }
                }
                categoryStmt.executeBatch();
            }


            // 운영 시간 저장
            if (days != null && startTimes != null && endTimes != null) {
                try (PreparedStatement dayStmt = conn.prepareStatement(dayQuery)) {
                    for (int i = 0; i < days.length; i++) {
                        dayStmt.setInt(1, groupId);
                        dayStmt.setString(2, days[i]);
                        dayStmt.setString(3, startTimes[i]);
                        dayStmt.setString(4, endTimes[i]);
                        dayStmt.addBatch();
                    }
                    dayStmt.executeBatch();
                }
            }

            conn.commit();
            return true;
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
                Group group = new Group(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getInt("max_members"),
                        rs.getInt("current_members")
                );
                group.setDays(getDaysByGroupId(id)); // Days 포함
                return group;
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
                user.setMajor(rs.getString("major"));
                user.setGrade(rs.getInt("grade"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<String> getCategoriesByGroupId(int groupId) {
        List<String> categories = new ArrayList<>();
        String query = "SELECT category_name FROM Category WHERE group_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, groupId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                categories.add(rs.getString("category_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
}
