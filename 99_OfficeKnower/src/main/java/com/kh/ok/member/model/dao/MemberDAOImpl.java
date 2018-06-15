package com.kh.ok.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Member memberOneSelect(String userId) {
		return sqlSession.selectOne("member.memberOneSelect",userId);
	}

}
