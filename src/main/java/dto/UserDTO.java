package dto;

import java.sql.Timestamp;
import java.util.Date;

public class UserDTO {
    private String userId;
    private String name;
    private String password;
    private Date birthDate;
    private String profileImage;
    private boolean isAdmin;
    private Timestamp joinDate;

    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public Date getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }
    public boolean isAdmin() {
        return isAdmin;
    }
    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }
    public Timestamp getJoinDate() {
        return joinDate;
    }
    public void setJoinDate(Timestamp joinDate) {
        this.joinDate = joinDate;
    }
    public String getProfileImage() {
    	return profileImage;
    }
    public void setProfileImage(String profileImage) {
    	this.profileImage = profileImage;
    }
}