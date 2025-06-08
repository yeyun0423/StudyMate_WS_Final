package dto;

import java.util.List;

public class StudyGroupDTO {
    private String subject;          
    private String leaderName;        
    private List<String> memberNames; 
    private String createdAt;         
    private int groupId;
    private String leaderId;
    
    
  
    public StudyGroupDTO() {}

   
    public StudyGroupDTO(String subject, String leaderName, List<String> memberNames, String createdAt) {
        this.subject = subject;
        this.leaderName = leaderName;
        this.memberNames = memberNames;
        this.createdAt = createdAt;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getLeaderName() {
        return leaderName;
    }

    public void setLeaderName(String leaderName) {
        this.leaderName = leaderName;
    }

    public List<String> getMemberNames() {
        return memberNames;
    }

    public void setMemberNames(List<String> memberNames) {
        this.memberNames = memberNames;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
    
    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public String getLeaderId() {
        return leaderId;
    }

    public void setLeaderId(String leaderId) {
        this.leaderId = leaderId;
    }


    @Override
    public String toString() {
        return "StudyGroupDTO{" +
                "subject='" + subject + '\'' +
                ", leaderName='" + leaderName + '\'' +
                ", memberNames=" + memberNames +
                ", createdAt='" + createdAt + '\'' +
                '}';
    }
}
