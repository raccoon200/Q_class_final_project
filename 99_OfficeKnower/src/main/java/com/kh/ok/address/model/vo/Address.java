package com.kh.ok.address.model.vo;

import java.sql.Date;


public class Address implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private int address_no;
	private String userId;
	private String com_No;
	private String name;		
	private String email;
	private String phone;
	private String tag;   
	private String company;
	private String address;
	private Date anniversary;
	private String memo;
	private String status;
	
	public Address(){
		
	}

	public Address(int address_no, String userId, String com_No, String name, String email, String phone, String tag,
			String company, String address, Date anniversary, String memo, String status) {
		super();
		this.address_no = address_no;
		this.userId = userId;
		this.com_No = com_No;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.tag = tag;
		this.company = company;
		this.address = address;
		this.anniversary = anniversary;
		this.memo = memo;
		this.status = status;
	}

	public int getAddress_no() {
		return address_no;
	}

	public void setAddress_no(int address_no) {
		this.address_no = address_no;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCom_No() {
		return com_No;
	}

	public void setCom_No(String com_No) {
		this.com_No = com_No;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getAnniversary() {
		return anniversary;
	}

	public void setAnniversary(Date anniversary) {
		this.anniversary = anniversary;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Address [address_no=" + address_no + ", userId=" + userId + ", com_No=" + com_No + ", name=" + name
				+ ", email=" + email + ", phone=" + phone + ", tag=" + tag + ", company=" + company + ", address="
				+ address + ", anniversary=" + anniversary + ", memo=" + memo + ", status=" + status + "]";
	}

	
}
