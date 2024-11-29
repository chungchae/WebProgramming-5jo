package model;

public class User {
    private long id;
    private String name;
    private String major;
    private int grade;
    
    // Getters and Setters
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String getMajor() {
    	return major;
    }
    
    public void setMajor(String major) {
    	this.major = major;
    }
    
    public int getGrade() {
    	return grade;
    }
    
    public void setGrade(int grade) {
    	this.grade = grade;
    }
}
