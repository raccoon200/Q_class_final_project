package com.kh.ok.insa.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
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

	@Override
	public List<String> yearListGroup(String com_no) {
		return sqlSession.selectList("insa.yearListGroup",com_no);
	}

	@Override
	public List<String> positionListGroup(String com_no) {
		return sqlSession.selectList("insa.positionListGroup",com_no);
	}

	@Override
	public List<Member> selectmemberListAll(String com_no, int numPerPage, int cPage) {
		return sqlSession.selectList("insa.selectmemberListAll",com_no,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectMemberListCnt(String com_no) {
		return sqlSession.selectOne("insa.selectMemberListCnt",com_no);
	}

	@Override
	public List<Member> insaMemberSearch(Map<String, String> map) {
		return sqlSession.selectList("insa.insaMemberSearch",map);
	}
}
