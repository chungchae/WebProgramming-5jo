package model;

public class Category {
    private int id;              // 카테고리 ID
    private String categoryName; // 카테고리 이름

    // 기본 생성자
    public Category() {}

    // 생성자
    public Category(int id, String categoryName) {
        this.id = id;
        this.categoryName = categoryName;
    }

    // Getter와 Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", categoryName='" + categoryName + '\'' +
                '}';
    }
}
