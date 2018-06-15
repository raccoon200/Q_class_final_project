package com.kh.ok.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.member.model.dao.MemberDAO;
import com.kh.ok.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public Member memberOneSelect(String userId) {
		return memberDAO.memberOneSelect(userId);
	}

}
