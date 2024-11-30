package dao;

import db.DBConnection;
import model.Day;
import model.Group;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class GroupDAO {
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


    public boolean createGroup(String title, String category, String description, String imageUrl, int maxMembers,
                               String[] days, String[] startTimes, String[] endTimes) {
        Connection conn = null;
        PreparedStatement groupStmt = null;
        PreparedStatement dayStmt = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // 그룹 데이터 삽입
            String groupQuery = "INSERT INTO group_table (title, category, description, image_url, max_members, current_members) " +
                    "VALUES (?, ?, ?, ?, ?, 0)";
            groupStmt = conn.prepareStatement(groupQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            groupStmt.setString(1, title);
            groupStmt.setString(2, category);
            groupStmt.setString(3, description);
            groupStmt.setString(4, imageUrl);
            groupStmt.setInt(5, maxMembers);

            int rowsAffected = groupStmt.executeUpdate();
            if (rowsAffected == 0) {
                conn.rollback(); // 실패 시 롤백
                return false;
            }

            // 생성된 그룹 ID 가져오기
            ResultSet generatedKeys = groupStmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int groupId = generatedKeys.getInt(1);

                // Day 데이터 삽입
                String dayQuery = "INSERT INTO Day (group_id, day, start_time, end_time) VALUES (?, ?, ?, ?)";
                dayStmt = conn.prepareStatement(dayQuery);

                for (int i = 0; i < days.length; i++) {
                    dayStmt.setInt(1, groupId);
                    dayStmt.setString(2, days[i]);
                    dayStmt.setString(3, startTimes[i]);
                    dayStmt.setString(4, endTimes[i]);
                    dayStmt.addBatch(); // 배치 처리로 성능 최적화
                }

                dayStmt.executeBatch(); // 배치 실행
            }

            conn.commit(); // 성공 시 커밋
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback(); // 예외 발생 시 롤백
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            return false;
        } finally {
            try {
                if (groupStmt != null) groupStmt.close();
                if (dayStmt != null) dayStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
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
}
