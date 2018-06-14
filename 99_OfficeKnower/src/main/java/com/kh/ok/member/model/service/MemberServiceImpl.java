package com.kh.ok.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.member.model.dao.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;

	@Override
	public int memberLogin(String userId, String password) {
		return 2;
	}

}
