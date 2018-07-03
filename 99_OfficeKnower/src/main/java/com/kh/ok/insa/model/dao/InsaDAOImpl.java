package com.kh.ok.insa.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.insa.model.vo.Position;
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

	@Override
	public List<Member> insaSelectMemberSearch(String com_no, int numPerPage, int cPage, Map<String, String> map) {
		return sqlSession.selectList("insa.insaSelectMemberSearch",map,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectSelectMemberListCnt(Map<String, String> map) {
		return sqlSession.selectOne("insa.selectSelectMemberListCnt",map);
	}

	@Override
	public Member memberSelectManagement(String userId) {
		return sqlSession.selectOne("insa.memberSelectManagement",userId);
	}

	@Override
	public List<Position> selectPositionList(String com_no) {
		return sqlSession.selectList("insa.selectPositionList",com_no);
	}

	@Override
	public int checkIdDuplicate(Map<String, String> no) {
		return sqlSession.selectOne("insa.checkIdDuplicate",no);
	}

	@Override
	public int insaMemberOneUpdate(Member member) {
		return sqlSession.update("insa.insaMemberOneUpdate",member);
	}

	@Override
	public int insaMemberDelete(Map<String, Object> map) {
		return sqlSession.delete("insa.insaMemberDelete",map);
	}

	@Override
	public int insaMemberUpdate(Map<String, Object> map) {
		return sqlSession.update("insa.insaMemberUpdate",map);
	}

	@Override
	public int positionInsert(Map<String, Object> map) {
		return sqlSession.insert("insa.positionInsert",map);
	}

	@Override
	public int updatePositionModal(Map<String, Object> map) {
		return sqlSession.update("insa.updatePositionModal",map);
	}

	@Override
	public int insaPositionDelete(Map<String, Object> map) {
		return sqlSession.delete("insa.insaPositionDelete",map);
	}

	@Override
	public int insaPositionUpdate(Map<String, Object> map) {
		return sqlSession.update("insa.insaPositionUpdate",map);
	}

	@Override
	public int insaJobInsert(Map<String, String> map) {
		return sqlSession.insert("insa.insaJobInsert",map);
	}

	@Override
	public int insaJobDelete(Map<String, String> map) {
		return sqlSession.delete("insa.insaJobDelete",map);
	}

	@Override
	public int insaJobUpdate(Map<String, String> map) {
		return sqlSession.update("insa.insaJobUpdate",map);
	}
}
