package com.kh.ok.breakTime.model.vo;

public class BreakSetting {
	private String n;
	private String n1;
	private String n2;
	private String n3;
	private String n4;
	private String n5;
	private String n6;
	private String n7;
	private String n8;
	private String n9;
	private String n10;
	private String n11;
	private String n12;
	private String breakdays;
	private int createdate;
	private String com_no;
	/**
	 * 
	 */
	public BreakSetting() {
		super();
	}
	/**
	 * @param n
	 * @param n1
	 * @param n2
	 * @param n3
	 * @param n4
	 * @param n5
	 * @param n6
	 * @param n7
	 * @param n8
	 * @param n9
	 * @param n10
	 * @param n11
	 * @param n12
	 * @param breakdays
	 * @param createdate
	 * @param com_no
	 */
	public BreakSetting(String n, String n1, String n2, String n3, String n4, String n5, String n6, String n7,
			String n8, String n9, String n10, String n11, String n12, String breakdays, int createdate, String com_no) {
		super();
		this.n = n;
		this.n1 = n1;
		this.n2 = n2;
		this.n3 = n3;
		this.n4 = n4;
		this.n5 = n5;
		this.n6 = n6;
		this.n7 = n7;
		this.n8 = n8;
		this.n9 = n9;
		this.n10 = n10;
		this.n11 = n11;
		this.n12 = n12;
		this.breakdays = breakdays;
		this.createdate = createdate;
		this.com_no = com_no;
	}
	public String getN() {
		return n;
	}
	public void setN(String n) {
		this.n = n;
	}
	public String getN1() {
		return n1;
	}
	public void setN1(String n1) {
		this.n1 = n1;
	}
	public String getN2() {
		return n2;
	}
	public void setN2(String n2) {
		this.n2 = n2;
	}
	public String getN3() {
		return n3;
	}
	public void setN3(String n3) {
		this.n3 = n3;
	}
	public String getN4() {
		return n4;
	}
	public void setN4(String n4) {
		this.n4 = n4;
	}
	public String getN5() {
		return n5;
	}
	public void setN5(String n5) {
		this.n5 = n5;
	}
	public String getN6() {
		return n6;
	}
	public void setN6(String n6) {
		this.n6 = n6;
	}
	public String getN7() {
		return n7;
	}
	public void setN7(String n7) {
		this.n7 = n7;
	}
	public String getN8() {
		return n8;
	}
	public void setN8(String n8) {
		this.n8 = n8;
	}
	public String getN9() {
		return n9;
	}
	public void setN9(String n9) {
		this.n9 = n9;
	}
	public String getN10() {
		return n10;
	}
	public void setN10(String n10) {
		this.n10 = n10;
	}
	public String getN11() {
		return n11;
	}
	public void setN11(String n11) {
		this.n11 = n11;
	}
	public String getN12() {
		return n12;
	}
	public void setN12(String n12) {
		this.n12 = n12;
	}
	public String getBreakdays() {
		return breakdays;
	}
	public void setBreakdays(String breakdays) {
		this.breakdays = breakdays;
	}
	public int getCreatedate() {
		return createdate;
	}
	public void setCreatedate(int createdate) {
		this.createdate = createdate;
	}
	public String getCom_no() {
		return com_no;
	}
	public void setCom_no(String com_no) {
		this.com_no = com_no;
	}
	@Override
	public String toString() {
		return "BreakSetting [n=" + n + ", n1=" + n1 + ", n2=" + n2 + ", n3=" + n3 + ", n4=" + n4 + ", n5=" + n5
				+ ", n6=" + n6 + ", n7=" + n7 + ", n8=" + n8 + ", n9=" + n9 + ", n10=" + n10 + ", n11=" + n11 + ", n12="
				+ n12 + ", breakdays=" + breakdays + ", createdate=" + createdate + ", com_no=" + com_no + "]";
	}
}
