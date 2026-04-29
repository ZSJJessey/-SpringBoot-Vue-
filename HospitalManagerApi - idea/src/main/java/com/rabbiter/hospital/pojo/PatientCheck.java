package com.rabbiter.hospital.pojo;

public class PatientCheck {

    private String check_name;
    private String count;

    public PatientCheck(String check_name, String count) {
        this.check_name = check_name;
        this.count = count;
    }


    public String getCheck_name() {
        return check_name;
    }

    public void setCheck_name(String check_name) {
        this.check_name = check_name;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }
}
