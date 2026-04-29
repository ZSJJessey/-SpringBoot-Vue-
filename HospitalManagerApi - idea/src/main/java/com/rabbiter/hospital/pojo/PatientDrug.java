package com.rabbiter.hospital.pojo;

public class PatientDrug {

    private String medicine_name;
    private String count;

    public PatientDrug(String medicine_name, String count) {
        this.medicine_name = medicine_name;
        this.count = count;
    }

    public String getMedicine_name() {
        return medicine_name;
    }

    public void setMedicine_name(String medicine_name) {
        this.medicine_name = medicine_name;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }
}
