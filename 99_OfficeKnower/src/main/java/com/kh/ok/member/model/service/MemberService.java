package com.kh.ok.member.model.service;

import com.kh.ok.member.model.vo.Member;

public interface MemberService {

	Member selectUserId(String userId);

	int checkIdDuplicate(String userId);

	int memberEnrollEnd(Member m);

	int memberOneUpdate(Member member);

	int checkComNameDuplicate(String comName);

	int selectComSEQ();

}
