package com.kh.ok.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.member.model.dao.MemberDAO;
import com.kh.ok.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;

	@Override
	public Member selectUserId(String userId) {
		return memberDAO.selectUserId(userId);
	}

	@Override
	public int checkIdDuplicate(String userId) {
		return memberDAO.checkIdDuplicate(userId);
	}

	@Override
	public int memberEnrollEnd(Member m) {
		return memberDAO.memberEnrollEnd(m);
	}
	public int memberOneUpdate(Member member) {
		return memberDAO.memberOneUpdate(member);
	}

	@Override
	public int checkComNameDuplicate(String comName) {
		return memberDAO.checkComNameDuplicate(comName);
	}

	@Override
	public int selectComSEQ() {
		return memberDAO.selectComSEQ();
	}

}
