package com.kh.ok.board.model.vo;

import java.sql.Date;

public class Comment {
	private int comment_no;
	private int board_no;
	private String writer;
	private String content;
	private Date writeDate;
	private String status;
	private String photo;
	public Comment() {}

	
	public int getComment_no() {
		return comment_no;
	}

	@Override
	public String toString() {
		return "Comment [comment_no=" + comment_no + ", board_no=" + board_no + ", writer=" + writer + ", content="
				+ content + ", writeDate=" + writeDate + ", status=" + status + ","+photo+ "]";
	}


	public String getPhoto() {
		return photo;
	}


	public void setPhoto(String photo) {
		this.photo = photo;
	}


	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
