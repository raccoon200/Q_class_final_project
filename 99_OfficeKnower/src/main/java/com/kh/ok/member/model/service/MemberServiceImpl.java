package com.kh.ok.member.model.service;

import java.util.List;
import java.util.Map;

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
	public List<Map<String, String>> memberCompanyListAll(String com_no) {
		return memberDAO.memberCompanyListAll(com_no);
	}

}
