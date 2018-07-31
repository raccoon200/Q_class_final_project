package com.kh.ok.test;

public class Test {
	private String name;
	private int age;
	private String gender;
	private String etc;
	
	
	/**
	 * 
	 */
	public Test() {
		super();
	}
	/**
	 * @param name
	 * @param age
	 * @param gender
	 * @param etc
	 */
	public Test(String name, int age, String gender, String etc) {
		super();
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.etc = etc;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	
	
}
