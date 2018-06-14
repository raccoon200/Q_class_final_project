package com.kh.ok.calendar.model.vo;

public class Schedule {
	private int schedule_no;
	private String writer;
	private String calendar_name;
	private String title;
	private String content;
	private String startdate;
	private String quitdate;
	private String status;
	private String com_no;
	
	
	public Schedule() {}


	public Schedule(int schedule_no, String writer, String calendar_name, String title, String content,
			String startdate, String quitdate, String status, String com_no) {
		super();
		this.schedule_no = schedule_no;
		this.writer = writer;
		this.calendar_name = calendar_name;
		this.title = title;
		this.content = content;
		this.startdate = startdate;
		this.quitdate = quitdate;
		this.status = status;
		this.com_no = com_no;
	}


	public int getSchedule_no() {
		return schedule_no;
	}


	public void setSchedule_no(int schedule_no) {
		this.schedule_no = schedule_no;
	}


	public String getWriter() {
		return writer;
	}


	public void setWriter(String writer) {
		this.writer = writer;
	}


	public String getCalendar_name() {
		return calendar_name;
	}


	public void setCalendar_name(String calendar_name) {
		this.calendar_name = calendar_name;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
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


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getCom_no() {
		return com_no;
	}


	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}


	@Override
	public String toString() {
		return "Schedule [schedule_no=" + schedule_no + ", writer=" + writer + ", calendar_name=" + calendar_name
				+ ", title=" + title + ", content=" + content + ", startdate=" + startdate + ", quitdate=" + quitdate
				+ ", status=" + status + ", com_no=" + com_no + "]";
	}
	
	
	
	
	
	
}
