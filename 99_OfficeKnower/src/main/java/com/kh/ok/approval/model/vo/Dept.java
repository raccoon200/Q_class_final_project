package com.kh.ok.approval.model.vo;

public class Dept {
	private String com_no;
	private String dept;
	private int dept_level;
	private String code;
	/**
	 * 
	 */
	public Dept() {
		super();
	}
	/**
	 * @param com_no
	 * @param dept
	 * @param dept_level
	 * @param code
	 */
	public Dept(String com_no, String dept, int dept_level, String code) {
		super();
		this.com_no = com_no;
		this.dept = dept;
		this.dept_level = dept_level;
		this.code = code;
	}
	public String getCom_no() {
		return com_no;
	}
	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public int getDept_level() {
		return dept_level;
	}
	public void setDept_level(int dept_level) {
		this.dept_level = dept_level;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	@Override
	public String toString() {
		return "Dept [com_no=" + com_no + ", dept=" + dept + ", dept_level=" + dept_level + ", code=" + code + "]";
	}
	
	
}
