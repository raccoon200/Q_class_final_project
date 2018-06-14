package com.kh.ok.member.model.vo;

import java.sql.Date;

public class Member {
	private String userId;
	private String password;
	private String userName;
	private String dept;
	private String position;
	private String job;
	private String phoneCom;
	private String phoneCell;
	private String email;
	private Date joinDate;
	private Date quitDate;
	private String status;
	private Date birthday;
	private String address;
	private String etcInf;
	private String photo;
	private String comNo;
	private String empNo;
	private String sign;
	private String col;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(String userId, String password, String userName, String dept, String position, String job,
			String phoneCom, String phoneCell, String email, Date joinDate, Date quitDate, String status, Date birthday,
			String address, String etcInf, String photo, String comNo, String empNo, String sign, String col) {
		super();
		this.userId = userId;
		this.password = password;
		this.userName = userName;
		this.dept = dept;
		this.position = position;
		this.job = job;
		this.phoneCom = phoneCom;
		this.phoneCell = phoneCell;
		this.email = email;
		this.joinDate = joinDate;
		this.quitDate = quitDate;
		this.status = status;
		this.birthday = birthday;
		this.address = address;
		this.etcInf = etcInf;
		this.photo = photo;
		this.comNo = comNo;
		this.empNo = empNo;
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

	public String getPhoneCom() {
		return phoneCom;
	}

	public void setPhoneCom(String phoneCom) {
		this.phoneCom = phoneCom;
	}

	public String getPhoneCell() {
		return phoneCell;
	}

	public void setPhoneCell(String phoneCell) {
		this.phoneCell = phoneCell;
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

	public String getEtcInf() {
		return etcInf;
	}

	public void setEtcInf(String etcInf) {
		this.etcInf = etcInf;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getComNo() {
		return comNo;
	}

	public void setComNo(String comNo) {
		this.comNo = comNo;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
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
				+ ", position=" + position + ", job=" + job + ", phoneCom=" + phoneCom + ", phoneCell=" + phoneCell
				+ ", email=" + email + ", joinDate=" + joinDate + ", quitDate=" + quitDate + ", status=" + status
				+ ", birthday=" + birthday + ", address=" + address + ", etcInf=" + etcInf + ", photo=" + photo
				+ ", comNo=" + comNo + ", empNo=" + empNo + ", sign=" + sign + ", col=" + col + "]";
	}
	
	
	
}
