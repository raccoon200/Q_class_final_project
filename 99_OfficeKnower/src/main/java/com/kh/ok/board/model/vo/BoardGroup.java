package com.kh.ok.board.model.vo;

public class BoardGroup {
	private int board_menu_no;
	private String userId;
	
	public BoardGroup() {
		
	}
	
	public BoardGroup(int board_menu_no, String userId) {
		this.board_menu_no = board_menu_no;
		this.userId = userId;
	}

	public int getBoard_menu_no() {
		return board_menu_no;
	}

	public void setBoard_menu_no(int board_menu_no) {
		this.board_menu_no = board_menu_no;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "BoardGroup [board_menu_no=" + board_menu_no + ", userId=" + userId + "]";
	}

	
	
	
}
