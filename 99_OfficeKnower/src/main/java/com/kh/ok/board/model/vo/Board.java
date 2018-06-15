package com.kh.ok.board.model.vo;

import java.sql.Date;

public class Board {
	private int board_no;
	private int board_menu_no;
	private String title;
	private Date writeDate;
	private String content;
	private String writer;
	private String status;
	private String original_file_name;
	private String renamed_file_name;
	
	public Board() {}

	
	public Board(int board_menu_no, String title, String content, String writer, String original_file_name,
			String renamed_file_name) {
		super();
		this.board_menu_no = board_menu_no;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.original_file_name = original_file_name;
		this.renamed_file_name = renamed_file_name;
	}


	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
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

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getOriginal_file_name() {
		return original_file_name;
	}

	public void setOriginal_file_name(String original_file_name) {
		this.original_file_name = original_file_name;
	}

	public String getRenamed_file_name() {
		return renamed_file_name;
	}

	public void setRenamed_file_name(String renamed_file_name) {
		this.renamed_file_name = renamed_file_name;
	}


	@Override
	public String toString() {
		return "Board [board_no=" + board_no + ", board_menu_no=" + board_menu_no + ", title=" + title + ", writeDate="
				+ writeDate + ", content=" + content + ", writer=" + writer + ", status=" + status
				+ ", original_file_name=" + original_file_name + ", renamed_file_name=" + renamed_file_name + "]";
	}
	
	
}
