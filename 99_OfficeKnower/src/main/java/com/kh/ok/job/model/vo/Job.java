package com.kh.ok.job.model.vo;

public class Job {
	private String com_no;
	private String job;
	
	public Job() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Job(String com_no, String job) {
		super();
		this.com_no = com_no;
		this.job = job;
	}

	public String getCom_no() {
		return com_no;
	}

	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	@Override
	public String toString() {
		return "Job [com_no=" + com_no + ", job=" + job + "]";
	}
	
	
}
