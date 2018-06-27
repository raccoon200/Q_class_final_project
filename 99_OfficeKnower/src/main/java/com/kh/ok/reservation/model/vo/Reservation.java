package com.kh.ok.reservation.model.vo;

import java.sql.Date;

public class Reservation {
	private int reservation_no;
	private String writer;
	private String category;
	private int res_no;
	private String startdate;
	private String quitdate;
	private String purpose;
	private String quit_status;
	private String photo;
	private String approval_status;
	private String com_no;
	private String res_name;
	
	public int getReservation_no() {
		return reservation_no;
	}
	public void setReservation_no(int reservation_no) {
		this.reservation_no = reservation_no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getRes_no() {
		return res_no;
	}
	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getQuitdate() {
		return quitdate;
	}
	public void setQuitdate(String quitdate) {
		this.quitdate = quitdate;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getQuit_status() {
		return quit_status;
	}
	public void setQuit_status(String quit_status) {
		this.quit_status = quit_status;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getApproval_status() {
		return approval_status;
	}
	public void setApproval_status(String approval_status) {
		this.approval_status = approval_status;
	}
	public String getCom_no() {
		return com_no;
	}
	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}
	public String getRes_name() {
		return res_name;
	}
	public void setRes_name(String res_name) {
		this.res_name = res_name;
	}
	
	public Reservation(int reservation_no, String writer, String category, int res_no, String startdate, String quitdate,
			String purpose, String quit_status, String photo, String approval_status, String com_no, String res_name) {
		this.reservation_no = reservation_no;
		this.writer = writer;
		this.category = category;
		this.res_no = res_no;
		this.startdate = startdate;
		this.quitdate = quitdate;
		this.purpose = purpose;
		this.quit_status = quit_status;
		this.photo = photo;
		this.approval_status = approval_status;
		this.com_no = com_no;
		this.res_name = res_name;
	}
	
	public Reservation() {}
	
	@Override
	public String toString() {
		return "Reservation [reservation_no=" + reservation_no + ", writer=" + writer + ", category=" + category
				+ ", res_no=" + res_no + ", startdate=" + startdate + ", quitdate=" + quitdate + ", purpose=" + purpose
				+ ", quit_status=" + quit_status + ", photo=" + photo + ", approval_status=" + approval_status
				+ ", com_no=" + com_no +", res_name="+ res_name + "]";
	}
	
}
