package com.kh.ok.member.model.dao;

import com.kh.ok.member.model.vo.Member;

public interface MemberDAO {

	Member selectUserId(String userId);

	int checkIdDuplicate(String userId);

	int memberEnrollEnd(Member m);

	int memberOneUpdate(Member member);

	int checkComNameDuplicate(String comName);

}
