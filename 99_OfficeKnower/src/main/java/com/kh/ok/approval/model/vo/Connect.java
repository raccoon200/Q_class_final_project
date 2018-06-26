package com.kh.ok.approval.model.vo;

public class Connect {
	private String code;
	private String com_no;
	private String connection_name;
	/**
	 * 
	 */
	public Connect() {
		super();
	}
	/**
	 * @param code
	 * @param com_no
	 * @param connection_name
	 */
	public Connect(String code, String com_no, String connection_name) {
		super();
		this.code = code;
		this.com_no = com_no;
		this.connection_name = connection_name;
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
	public String getConnection_name() {
		return connection_name;
	}
	public void setConnection_name(String connection_name) {
		this.connection_name = connection_name;
	}
	@Override
	public String toString() {
		return "Connect [code=" + code + ", com_no=" + com_no + ", connection_name=" + connection_name + "]";
	}
	
	
}
