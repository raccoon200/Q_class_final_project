package com.kh.ok.insa.model.dao;

import java.util.List;

import com.kh.ok.member.model.vo.Member;

public interface InsaDAO {

	List<Member> memberListAll(String com_no);

	int profileUpdate(Member m);

}
