package com.kh.ok.board.model.vo;

import java.sql.Date;

public class BoardMenu {
	private int board_menu_no;
	private String title;
	private Date createDate;
	private String status;
	private String kind;
	private String userId;
	private String com_no;
	
	
	public BoardMenu() {}
	public BoardMenu(int board_menu_no, String title, Date createDate, String status, String kind, String userId,
			String com_no) {
		super();
		this.board_menu_no = board_menu_no;
		this.title = title;
		this.createDate = createDate;
		this.status = status;
		this.kind = kind;
		this.userId = userId;
		this.com_no = com_no;
	}
	public int getBoard_menu_no() {
		return board_menu_no;
	}
	public void setBoard_menu_no(int board_menu_no) {
		this.board_menu_no = board_menu_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCom_no() {
		return com_no;
	}
	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}
	@Override
	public String toString() {
		return "BoardMenu [board_menu_no=" + board_menu_no + ", title=" + title + ", createDate=" + createDate
				+ ", status=" + status + ", kind=" + kind + ", userId=" + userId + ", com_no=" + com_no + "]";
	}
	
	
}
