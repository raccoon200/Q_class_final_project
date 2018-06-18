package com.kh.ok.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO{
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public Member selectUserId(String userId) {
		return sqlSession.selectOne("member.selectUserId", userId);
	}

	@Override
	public int memberOneUpdate(Member member) {
		return sqlSession.update("member.memberOneUpdate",member);
	}
}
