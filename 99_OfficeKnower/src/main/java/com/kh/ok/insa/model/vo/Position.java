package com.kh.ok.insa.model.vo;

public class Position {
	private String com_no;
	private String position;
	private String position_level;
	
	
	public Position() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Position(String com_no, String position, String position_level) {
		super();
		this.com_no = com_no;
		this.position = position;
		this.position_level = position_level;
	}


	public String getCom_no() {
		return com_no;
	}


	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}


	public String getPosition() {
		return position;
	}


	public void setPosition(String position) {
		this.position = position;
	}


	public String getPosition_level() {
		return position_level;
	}


	public void setPosition_level(String position_level) {
		this.position_level = position_level;
	}


	@Override
	public String toString() {
		return "Position [com_no=" + com_no + ", position=" + position + ", position_level=" + position_level + "]";
	}
	
	
}
