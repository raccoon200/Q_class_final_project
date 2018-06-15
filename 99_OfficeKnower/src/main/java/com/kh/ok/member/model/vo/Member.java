package com.kh.ok.member.model.vo;

import java.sql.Date;

public class Member {
	private String userId;
	private String password;
	private String userName;
	private String dept;
	private String position;
	private String job;
	private String phone_com;
	private String phone_cell;
	private String email;
	private Date joinDate;
	private Date quitDate;
	private String status;
	private Date birthday;
	private String address;
	private String etc_inf;
	private String photo;
	private String com_no;
	private String emp_no;
	private String sign;
	private String col;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(String userId, String password, String userName, String dept, String position, String job,
			String phone_com, String phone_cell, String email, Date joinDate, Date quitDate, String status,
			Date birthday, String address, String etc_inf, String photo, String com_no, String emp_no, String sign,
			String col) {
		super();
		this.userId = userId;
		this.password = password;
		this.userName = userName;
		this.dept = dept;
		this.position = position;
		this.job = job;
		this.phone_com = phone_com;
		this.phone_cell = phone_cell;
		this.email = email;
		this.joinDate = joinDate;
		this.quitDate = quitDate;
		this.status = status;
		this.birthday = birthday;
		this.address = address;
		this.etc_inf = etc_inf;
		this.photo = photo;
		this.com_no = com_no;
		this.emp_no = emp_no;
		this.sign = sign;
		this.col = col;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getPhone_com() {
		return phone_com;
	}

	public void setPhone_com(String phone_com) {
		this.phone_com = phone_com;
	}

	public String getPhone_cell() {
		return phone_cell;
	}

	public void setPhone_cell(String phone_cell) {
		this.phone_cell = phone_cell;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public Date getQuitDate() {
		return quitDate;
	}

	public void setQuitDate(Date quitDate) {
		this.quitDate = quitDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEtc_inf() {
		return etc_inf;
	}

	public void setEtc_inf(String etc_inf) {
		this.etc_inf = etc_inf;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getCom_no() {
		return com_no;
	}

	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public String getCol() {
		return col;
	}

	public void setCol(String col) {
		this.col = col;
	}

	@Override
	public String toString() {
		return "Member [userId=" + userId + ", password=" + password + ", userName=" + userName + ", dept=" + dept
				+ ", position=" + position + ", job=" + job + ", phone_com=" + phone_com + ", phone_cell=" + phone_cell
				+ ", email=" + email + ", joinDate=" + joinDate + ", quitDate=" + quitDate + ", status=" + status
				+ ", birthday=" + birthday + ", address=" + address + ", etc_inf=" + etc_inf + ", photo=" + photo
				+ ", com_no=" + com_no + ", emp_no=" + emp_no + ", sign=" + sign + ", col=" + col + "]";
	}

	
	
}
