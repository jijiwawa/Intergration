package com.mainpage.domain;

import java.math.BigDecimal;

public class User {
    private int id;
    private String phoneNumber;
    private String userName;
    private byte isMale;
    private BigDecimal property;
    private String headSculpture;
    private byte type;
    private String password;
    private double credit;
    private Integer trade_num;

    public Integer getTrade_num() {
        return trade_num;
    }

    public void setTrade_num(Integer trade_num) {
        this.trade_num = trade_num;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public byte getIsMale() {
        return isMale;
    }

    public void setIsMale(byte isMale) {
        this.isMale = isMale;
    }

    public BigDecimal getProperty() {
        return property;
    }

    public void setProperty(BigDecimal property) {
        this.property = property;
    }

    public String getHeadSculpture() {
        return headSculpture;
    }

    public void setHeadSculpture(String headSculpture) {
        this.headSculpture = headSculpture;
    }

    public byte getType() {
        return type;
    }

    public void setType(byte type) {
        this.type = type;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", userName='" + userName + '\'' +
                ", isMale=" + isMale +
                ", property=" + property +
                ", headSculpture='" + headSculpture + '\'' +
                ", type=" + type +
                ", password='" + password + '\'' +
                ", credit=" + credit +
                ", trade_num=" + trade_num +
                '}';
    }
}
