package com.kh.ok.breakTime.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.breakTime.model.vo.Break;

@Repository
public class BreakDAOImpl implements BreakDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<Break> selectMyBreak(String userId) {
		return sqlSession.selectList("break.selectMyBreak",userId);
	}

	@Override
	public List<Map<String, String>> selectBreakList(String comId) {
		return sqlSession.selectList("break.selectBreakList",comId);
	}

	@Override
	public List<Map<String, String>> searchMember(Map<String, String> map) {
		return sqlSession.selectList("break.searchMember",map);
	}



	@Override
	public List<Map<String, String>> choiceMember(Map<String, Object> map) {
		return sqlSession.selectList("break.choiceMember",map);
	}

}
