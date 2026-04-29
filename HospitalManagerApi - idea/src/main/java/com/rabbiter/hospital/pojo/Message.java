package com.rabbiter.hospital.pojo;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 作者： Administrator
 * 日期: 2024/12/20/020
 * Description :
 */
@TableName("message")
public class Message {
    @TableId(value = "mid")
    @JsonProperty("mid")
    private int mid;
    @JsonProperty("message")
    private String message;
    @JsonProperty("dId")
    private int did;
    @JsonProperty("pid")
    private int pid;
    @JsonProperty("has_read")
    private boolean hasRead;
    @JsonProperty("send_time")
    private String sendTime;

    public Message(int mid, String message, int did, int pid, boolean hasRead, String sendTime) {
        this.mid = mid;
        this.message = message;
        this.did = did;
        this.pid = pid;
        this.hasRead = hasRead;
        this.sendTime = sendTime;
    }

    public int getMid() {
        return mid;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getDid() {
        return did;
    }

    public void setDid(int did) {
        this.did = did;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public boolean isHasRead() {
        return hasRead;
    }

    public void setHasRead(boolean hasRead) {
        this.hasRead = hasRead;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }
}
