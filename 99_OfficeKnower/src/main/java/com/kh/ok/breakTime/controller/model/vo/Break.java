package com.kh.ok.breakTime.controller.model.vo;

public class Break {
	private String userid;
	private int regular_break;
	private int reward_break;
	private int regular_used_break;
	private int reward_used_break;
	
	
	public Break() {}


	public Break(String userid, int regular_break, int reward_break, int regular_used_break, int reward_used_break) {
		super();
		this.userid = userid;
		this.regular_break = regular_break;
		this.reward_break = reward_break;
		this.regular_used_break = regular_used_break;
		this.reward_used_break = reward_used_break;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public int getRegular_break() {
		return regular_break;
	}


	public void setRegular_break(int regular_break) {
		this.regular_break = regular_break;
	}


	public int getReward_break() {
		return reward_break;
	}


	public void setReward_break(int reward_break) {
		this.reward_break = reward_break;
	}


	public int getRegular_used_break() {
		return regular_used_break;
	}


	public void setRegular_used_break(int regular_used_break) {
		this.regular_used_break = regular_used_break;
	}


	public int getReward_used_break() {
		return reward_used_break;
	}


	public void setReward_used_break(int reward_used_break) {
		this.reward_used_break = reward_used_break;
	}


	@Override
	public String toString() {
		return "Break [userid=" + userid + ", regular_break=" + regular_break + ", reward_break=" + reward_break
				+ ", regular_used_break=" + regular_used_break + ", reward_used_break=" + reward_used_break + "]";
	}
	
	
	
	
}
