package model;

public class Category {
    private int id;         // 카테고리 ID
    private String name;    // 카테고리 이름

    // 기본 생성자
    public Category() {}

    // 생성자
    public Category(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getter와 Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
