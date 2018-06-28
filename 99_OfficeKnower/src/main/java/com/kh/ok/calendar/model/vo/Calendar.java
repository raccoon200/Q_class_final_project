package com.kh.ok.calendar.model.vo;

public class Calendar {
	private String calendarid;
	private String calendar_name;
	private String color;
	private String type;
	private String userid;
	
	
	public Calendar() {}

	


	public Calendar(String calendarid, String calendar_name, String color, String type, String userid) {
		super();
		this.calendarid = calendarid;
		this.calendar_name = calendar_name;
		this.color = color;
		this.type = type;
		this.userid = userid;
	}




	public String getUserid() {
		return userid;
	}




	public void setUserid(String userid) {
		this.userid = userid;
	}




	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCalendarid() {
		return calendarid;
	}


	public void setCalendarid(String calendarid) {
		this.calendarid = calendarid;
	}


	public String getCalendar_name() {
		return calendar_name;
	}


	public void setCalendar_name(String calendar_name) {
		this.calendar_name = calendar_name;
	}


	public String getColor() {
		return color;
	}


	public void setColor(String color) {
		this.color = color;
	}




	@Override
	public String toString() {
		return "Calendar [calendarid=" + calendarid + ", calendar_name=" + calendar_name + ", color=" + color
				+ ", type=" + type + ", userid=" + userid + "]";
	}

	


	
}
