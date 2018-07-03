package com.kh.ok.breakTime.model.vo;

public class BreakRequest {
	
	private String break_request_no;
	private String userid;
	private String kind;
	private String startdate;
	private String breakdays;
	private String reason;
	private String renamed_file_name;
	private String com_no;
	private String approvals;
	private int approval_status;
	private String enddate;
	
	
	public BreakRequest() {	}





	public BreakRequest(String break_request_no, String userid, String kind, String startdate, String breakdays,
			String reason, String renamed_file_name, String com_no, String approvals, int approval_status,
			String enddate) {
		super();
		this.break_request_no = break_request_no;
		this.userid = userid;
		this.kind = kind;
		this.startdate = startdate;
		this.breakdays = breakdays;
		this.reason = reason;
		this.renamed_file_name = renamed_file_name;
		this.com_no = com_no;
		this.approvals = approvals;
		this.approval_status = approval_status;
		this.enddate = enddate;
	}





	public String getBreak_request_no() {
		return break_request_no;
	}


	public void setBreak_request_no(String break_request_no) {
		this.break_request_no = break_request_no;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public String getKind() {
		return kind;
	}


	public void setKind(String kind) {
		this.kind = kind;
	}




	public String getBreakdays() {
		return breakdays;
	}


	public void setBreakdays(String breakdays) {
		this.breakdays = breakdays;
	}


	public String getReason() {
		return reason;
	}


	public void setReason(String reason) {
		this.reason = reason;
	}


	public String getRenamed_file_name() {
		return renamed_file_name;
	}


	public void setRenamed_file_name(String renamed_file_name) {
		this.renamed_file_name = renamed_file_name;
	}


	public String getCom_no() {
		return com_no;
	}


	public void setCom_no(String com_no) {
		this.com_no = com_no;
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


	

	public String getStartdate() {
		return startdate;
	}





	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}





	public String getEnddate() {
		return enddate;
	}





	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}





	@Override
	public String toString() {
		return "BreakRequest [break_request_no=" + break_request_no + ", userid=" + userid + ", kind=" + kind
				+ ", startdate=" + startdate + ", breakdays=" + breakdays + ", reason=" + reason
				+ ", renamed_file_name=" + renamed_file_name + ", com_no=" + com_no + ", approvals=" + approvals
				+ ", approval_status=" + approval_status + ", enddate=" + enddate + "]";
	}



	
	
}
