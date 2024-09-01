package model;

import java.sql.Date;
import java.sql.Time;

public class Task {
    private int id;
    private int uid;
    private String task;
    private String taskCategory;
    private String description;
    private Date date;
    private Time startTime;
    private Time endTime;
    private int duration;
    private String employeeName;
    private int dailyHours;// Add this line

    // Getters and setters for all fields including employeeName

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getTask() {
        return task;
    }

    public void setTask(String task) {
        this.task = task;
    }

    public String getTaskCategory() {
        return taskCategory;
    }

    public void setTaskCategory(String taskCategory) {
        this.taskCategory = taskCategory;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getEmployeeName() {  // Add this method
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {  // Add this method
        this.employeeName = employeeName;
    }

    public int getDailyHours() {  // Add this method
        return dailyHours;
    }

    public void setDailyHours(int dailyHours) {  // Add this method
        this.dailyHours = dailyHours;
    }}
