package com.kh.ok.insa.model.service;

import java.util.List;

import com.kh.ok.member.model.vo.Member;

public interface InsaService {

	List<Member> memberListAll(String com_no);

	int profileUpdate(Member m);

}