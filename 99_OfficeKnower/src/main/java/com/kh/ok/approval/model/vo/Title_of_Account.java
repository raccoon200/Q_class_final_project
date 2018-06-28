package com.kh.ok.approval.model.vo;

public class Title_of_Account {
	private String code;
	private String com_no;
	private String title_of_account;
	/**
	 * 
	 */
	public Title_of_Account() {
		super();
	}
	/**
	 * @param code
	 * @param com_no
	 * @param title_of_account
	 */
	public Title_of_Account(String code, String com_no, String title_of_account) {
		super();
		this.code = code;
		this.com_no = com_no;
		this.title_of_account = title_of_account;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCom_no() {
		return com_no;
	}
	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}
	public String getTitle_of_account() {
		return title_of_account;
	}
	public void setTitle_of_account(String title_of_account) {
		this.title_of_account = title_of_account;
	}
	@Override
	public String toString() {
		return "Title_of_Account [code=" + code + ", com_no=" + com_no + ", title_of_account=" + title_of_account + "]";
	}
	
	
}
