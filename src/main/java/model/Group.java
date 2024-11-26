package model;

public class Group {
    private int id;
    private String title;
    private String category;
    private String description;
    private String imageUrl;
    private int maxMembers;
    private int currentMembers;

    // 생성자
    public Group(int id, String title, String category, String description, String imageUrl, int maxMembers, int currentMembers) {
        this.id = id;
        this.title = title;
        this.category = category;
        this.description = description;
        this.imageUrl = imageUrl;
        this.maxMembers = maxMembers;
        this.currentMembers = currentMembers;
    }

    // Getter와 Setter
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getCategory() { return category; }
    public String getDescription() { return description; }
    public String getImageUrl() { return imageUrl; }
    public int getMaxMembers() { return maxMembers; }
    public int getCurrentMembers() { return currentMembers; }
}
