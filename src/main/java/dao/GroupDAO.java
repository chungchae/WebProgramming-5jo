package dao;

import db.DBConnection;
import model.Category;
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
                Group group = new Group(
                        rs.getInt("id"),
                        rs.getString("title"),
                        null, // Category는 별도로 설정
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getInt("max_members"),
                        rs.getInt("current_members")
                );

                // Days 설정
                group.setDays(getDaysByGroupId(group.getId()));

                // Categories 설정
                group.setCategories(getCategoriesByGroupId(group.getId()));

                groups.add(group);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groups;
    }

    //main 화면, 카테고리 검색
    public List<Group> findGroupsByCategory(String categoryName) {
        List<Group> groups = new ArrayList<>();
        String query = "SELECT g.* FROM group_table g " +
                "JOIN Category c ON g.id = c.group_id " +
                "WHERE c.category_name = ? " +
                "ORDER BY g.id DESC " +
                "LIMIT 4";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, categoryName);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                // 그룹 기본 정보 매핑
                Group group = new Group(
                        rs.getInt("id"),
                        rs.getString("title"),
                        null, // 카테고리는 아래에서 추가
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getInt("max_members"),
                        rs.getInt("current_members")
                );

                // Days 설정
                group.setDays(getDaysByGroupId(group.getId()));

                // Categories 설정
                group.setCategories(getCategoriesByGroupId(group.getId()));

                groups.add(group);
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
                        null, // Category는 별도로 설정
                        rs.getString("description"),
                        rs.getString("image_url"),
                        rs.getInt("max_members"),
                        rs.getInt("current_members")
                );

                // Days 설정
                group.setDays(getDaysByGroupId(group.getId()));

                // Categories 설정
                group.setCategories(getCategoriesByGroupId(group.getId()));

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
                               String[] categories, String[] days, String[] startTimes, String[] endTimes, Long userId) {
        String groupQuery = "INSERT INTO group_table (title, description, image_url, max_members,current_members) VALUES (?, ?, ?, ?,?)";
        String categoryQuery = "INSERT INTO Category (group_id, category_name) VALUES (?, ?)";
        String dayQuery = "INSERT INTO Day (group_id, day, start_time, end_time) VALUES (?, ?, ?, ?)";
        String groupUserQuery = "INSERT INTO GroupUser (group_table_id, user_id, statement) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // 그룹 생성
            int groupId = 0;
            try (PreparedStatement groupStmt = conn.prepareStatement(groupQuery, Statement.RETURN_GENERATED_KEYS)) {
                groupStmt.setString(1, title);
                groupStmt.setString(2, description);
                groupStmt.setString(3, imageUrl);
                groupStmt.setInt(4, maxMembers);
                groupStmt.setInt(5,1);
                groupStmt.executeUpdate();

                ResultSet rs = groupStmt.getGeneratedKeys();
                if (rs.next()) {
                    groupId = rs.getInt(1);
                }
            }

            // 카테고리 저장
            if (categories != null) {
                try (PreparedStatement categoryStmt = conn.prepareStatement(categoryQuery)) {
                    for (String category : categories) {
                        if (!category.isEmpty()) {
                            categoryStmt.setInt(1, groupId);
                            categoryStmt.setString(2, category);
                            categoryStmt.addBatch();
                        }
                    }
                    categoryStmt.executeBatch();
                }
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

            // GroupUser에 리더로 등록
            try (PreparedStatement groupUserStmt = conn.prepareStatement(groupUserQuery)) {
                groupUserStmt.setInt(1, groupId);
                groupUserStmt.setLong(2, userId);
                groupUserStmt.setString(3, "방장"); // statement 필드를 "leader"로 설정
                groupUserStmt.executeUpdate();
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


    public boolean updateGroup(int id, String title, String description, String imageUrl, int maxMembers,
                               String[] categories, String[] days, String[] startTimes, String[] endTimes) {
        String updateGroupQuery = "UPDATE group_table SET title = ?, description = ?, image_url = ?, max_members = ? WHERE id = ?";
        String deleteCategoriesQuery = "DELETE FROM category WHERE group_id = ?";
        String deleteDaysQuery = "DELETE FROM Day WHERE group_id = ?";
        String insertCategoryQuery = "INSERT INTO category (group_id, category_name) VALUES (?, ?)";
        String insertDayQuery = "INSERT INTO Day (group_id, day, start_time, end_time) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // 그룹 정보 업데이트
            try (PreparedStatement updateGroupStmt = conn.prepareStatement(updateGroupQuery)) {
                updateGroupStmt.setString(1, title);
                updateGroupStmt.setString(2, description);
                updateGroupStmt.setString(3, imageUrl);
                updateGroupStmt.setInt(4, maxMembers);
                updateGroupStmt.setInt(5, id);
                updateGroupStmt.executeUpdate();
            }

            // 기존 카테고리 삭제
            try (PreparedStatement deleteCategoryStmt = conn.prepareStatement(deleteCategoriesQuery)) {
                deleteCategoryStmt.setInt(1, id);
                deleteCategoryStmt.executeUpdate();
            }

            // 새 카테고리 추가
            if (categories != null) {
                try (PreparedStatement insertCategoryStmt = conn.prepareStatement(insertCategoryQuery)) {
                    for (String category : categories) {
                        if (!category.isEmpty()) {
                            insertCategoryStmt.setInt(1, id);
                            insertCategoryStmt.setString(2, category);
                            insertCategoryStmt.addBatch();
                        }
                    }
                    insertCategoryStmt.executeBatch();
                }
            }

            // 기존 운영 시간 삭제
            try (PreparedStatement deleteDaysStmt = conn.prepareStatement(deleteDaysQuery)) {
                deleteDaysStmt.setInt(1, id);
                deleteDaysStmt.executeUpdate();
            }

            // 새 운영 시간 추가
            if (days != null && startTimes != null && endTimes != null) {
                try (PreparedStatement insertDayStmt = conn.prepareStatement(insertDayQuery)) {
                    for (int i = 0; i < days.length; i++) {
                        insertDayStmt.setInt(1, id);
                        insertDayStmt.setString(2, days[i]);
                        insertDayStmt.setString(3, startTimes[i]);
                        insertDayStmt.setString(4, endTimes[i]);
                        insertDayStmt.addBatch();
                    }
                    insertDayStmt.executeBatch();
                }
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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
        String query = "SELECT u.id, u.name, u.major, u.grade FROM User u " +
                "JOIN GroupUser gu ON u.id = gu.user_id " +
                "WHERE gu.group_table_id = ? AND gu.statement IN ('방장', '회원')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, groupId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
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


    public List<Category> getCategoriesByGroupId(int groupId) {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT category_name FROM Category WHERE group_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, groupId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryName(rs.getString("category_name")); // Category 객체의 setter 사용
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }


    public Long getGroupLeaderUserId(int groupId) {
        String query = "SELECT user_id FROM GroupUser WHERE group_table_id = ? AND statement = '방장'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, groupId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getLong("user_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // 리더가 없으면 null 반환
    }
    public String getUserStatement(int groupId, Long userId) {
        String query = "SELECT statement FROM GroupUser WHERE group_table_id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, groupId);
            pstmt.setLong(2, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("statement");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // statement가 없으면 null 반환
    }

}
