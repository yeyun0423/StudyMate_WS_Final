package dto;

import java.util.List;

public class StudyGroupDTO {
    private String subject;           // 과목명
    private String leaderName;        // 리더 이름
    private List<String> memberNames; // 멤버 이름 리스트
    private String createdAt;         // 생성일 (yyyy-MM-dd HH:mm:ss)
    private int groupId;
    private String leaderId;
    
    
    // 기본 생성자
    public StudyGroupDTO() {}

    // 전체 필드 생성자
    public StudyGroupDTO(String subject, String leaderName, List<String> memberNames, String createdAt) {
        this.subject = subject;
        this.leaderName = leaderName;
        this.memberNames = memberNames;
        this.createdAt = createdAt;
    }

    // getter/setter
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

    // toString() - 디버깅용
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
