package com.kh.ok.reservation.model.vo;

public class Resources {
	private int res_no;
	private String resource__name;
	private String category;
	private String com_no;
	public int getRes_no() {
		return res_no;
	}
	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}
	public String getResource__name() {
		return resource__name;
	}
	public void setResource__name(String resource__name) {
		this.resource__name = resource__name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getCom_no() {
		return com_no;
	}
	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}
	public Resources(int res_no, String resource__name, String category, String com_no) {
		this.res_no = res_no;
		this.resource__name = resource__name;
		this.category = category;
		this.com_no = com_no;
	}
	public Resources() {}
	@Override
	public String toString() {
		return "Resources [res_no=" + res_no + ", resource__name=" + resource__name + ", category=" + category
				+ ", com_no=" + com_no + "]";
	}
	
}
