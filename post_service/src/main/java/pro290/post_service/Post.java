package pro290.post_service;

import org.springframework.data.annotation.Id;

import java.io.Serial;
import java.io.Serializable;
import java.util.UUID;

public class Post implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    private UUID id;

    private String userId;

    private String content;

    private String location;

    private String time;
    private String date;



    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getTime(String string) {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }


}
