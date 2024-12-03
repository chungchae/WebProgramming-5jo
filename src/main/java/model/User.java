package model;

public class User {
	public User(Long id, String name, String password, String univ, String major, String introduction, int grade, String email, String hobby) {
		this.id = id;
		this.name = name;
		this.password = password;
		this.univ = univ;
		this.major = major;
		this.introduction = introduction;
		this.grade = grade;
		this.email = email;
		this.hobby = hobby;
	}

	public User() {

	}

    private long id;
    private String name;
    private String email;
    private String password;
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
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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
