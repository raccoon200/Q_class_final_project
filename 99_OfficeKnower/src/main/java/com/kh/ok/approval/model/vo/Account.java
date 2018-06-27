package com.kh.ok.approval.model.vo;

import java.sql.Date;

public class Account {
	private String userId;
	private String name;
	private String bankName;
	private String account_no;
	private Date reg_date;
	private String com_no;
	/**
	 * 
	 */
	public Account() {
		super();
	}
	/**
	 * @param userId
	 * @param name
	 * @param bankName
	 * @param account_no
	 * @param reg_date
	 * @param com_no
	 */
	public Account(String userId, String name, String bankName, String account_no, Date reg_date, String com_no) {
		super();
		this.userId = userId;
		this.name = name;
		this.bankName = bankName;
		this.account_no = account_no;
		this.reg_date = reg_date;
		this.com_no = com_no;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAccount_no() {
		return account_no;
	}
	public void setAccount_no(String account_no) {
		this.account_no = account_no;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getCom_no() {
		return com_no;
	}
	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}
	@Override
	public String toString() {
		return "Account [userId=" + userId + ", name=" + name + ", bankName=" + bankName + ", account_no=" + account_no
				+ ", reg_date=" + reg_date + ", com_no=" + com_no + "]";
	}
	
	
}
