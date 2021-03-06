package com.kh.ok.member.model.dao;

import java.util.List;
import java.util.Map;

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
	public int checkIdDuplicate(String userId) {
		return sqlSession.selectOne("member.checkIdDuplicate", userId);
	}

	@Override

	public List<Map<String, String>> memberCompanyListAll(String com_no) {
		return sqlSession.selectList("member.memberCompanyListAll", com_no);
	}
	public int memberEnrollEnd(Member m) {
		if(m.getCom_no().equals("") || m.getCom_name().equals(""))
			return sqlSession.insert("member.memberEnrollEnd", m);
		else {
			sqlSession.insert("member.memberComCreate", m);
			return sqlSession.insert("member.memberEnrollEndCom", m);
		}
	}
	public int memberOneUpdate(Member member) {
		return sqlSession.update("member.memberOneUpdate",member);

	}

	@Override
	public int checkComNameDuplicate(String comName) {
		return sqlSession.selectOne("member.checkComNameDuplicate", comName);
	}

	@Override
	public int selectComSEQ() {
		return sqlSession.selectOne("member.selectComSEQ");
	}
}
