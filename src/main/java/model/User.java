package model;

public class User {
    private long id;
    private String name;
    private String email;
    private String univ;
    private String major;
    private int grade;
    private String hobby;
    private String introduction;
    
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUniv() {
		return univ;
	}

	public void setUniv(String univ) {
		this.univ = univ;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
}
