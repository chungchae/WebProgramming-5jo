package model;

public class Alert {
    private Long userId;
    private String userName;
    private String groupTitle;
    private Long groupId;


    public Alert(Long userId, String userName, String groupTitle, Long groupId) {
        this.userId = userId;
        this.userName = userName;
        this.groupTitle = groupTitle;
        this.groupId = groupId;
    }

    public Long getUserId() {
        return userId;
    }

    public String getUserName() {
        return userName;
    }

    public String getGroupTitle() {
        return groupTitle;
    }

    public Long getGroupId() {
        return groupId;
    }
}
