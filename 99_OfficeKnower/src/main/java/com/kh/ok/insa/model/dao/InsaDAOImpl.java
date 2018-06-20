package com.kh.ok.insa.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.member.model.vo.Member;

@Repository
public class InsaDAOImpl implements InsaDAO {
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Member> memberListAll(String com_no) {
		return sqlSession.selectList("insa.memberListAll",com_no);
	}

	@Override
	public int profileUpdate(Member m) {
		return sqlSession.update("insa.profileUpdate",m);
	}
}
