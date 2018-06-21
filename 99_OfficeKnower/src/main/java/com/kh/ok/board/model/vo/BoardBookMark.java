package com.kh.ok.board.model.vo;

public class BoardBookMark {
	private int board_no;
	private String userId;
	
	public BoardBookMark() {}
	
	public BoardBookMark(int board_no, String userId) {
		this.board_no = board_no;
		this.userId = userId;
	}
	
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	
}
