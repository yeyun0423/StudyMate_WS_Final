package dto;

public class TimetableDTO {
    private int timetableId;
    private String userId;
    private String dayOfWeek;
    private int period;
    private String subject;


    public int getTimetableId() { return timetableId; }
    public void setTimetableId(int timetableId) { this.timetableId = timetableId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getDayOfWeek() { return dayOfWeek; }
    public void setDayOfWeek(String dayOfWeek) { this.dayOfWeek = dayOfWeek; }

    public int getPeriod() { return period; }
    public void setPeriod(int period) { this.period = period; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
}
