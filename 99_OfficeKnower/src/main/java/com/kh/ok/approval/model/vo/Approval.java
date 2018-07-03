package com.kh.ok.approval.model.vo;

import java.sql.Date;

public class Approval {
	private String approval_no;
	private String title;
	private Date writeDate;
	private String writer;
	private String content;
	private String status;
	private String approvals;
	private int approval_status;
	private String com_no;
	
	public Approval() {}

	public String getApproval_no() {
		return approval_no;
	}

	public void setApproval_no(String approval_no) {
		this.approval_no = approval_no;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getApprovals() {
		return approvals;
	}

	public void setApprovals(String approvals) {
		this.approvals = approvals;
	}

	public int getApproval_status() {
		return approval_status;
	}

	public void setApproval_status(int approval_status) {
		this.approval_status = approval_status;
	}

	public String getCom_no() {
		return com_no;
	}

	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}

	@Override
	public String toString() {
		return "Approval [approval_no=" + approval_no + ", title=" + title + ", writeDate=" + writeDate + ", writer="
				+ writer + ", content=" + content + ", status=" + status + ", approvals=" + approvals
				+ ", approval_status=" + approval_status + ", com_no=" + com_no + "]";
	}
	
	
}
