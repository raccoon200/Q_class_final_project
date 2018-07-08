package com.kh.ok.breakTime.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.breakTime.model.vo.Break;
import com.kh.ok.breakTime.model.vo.BreakRequest;
import com.kh.ok.breakTime.model.vo.BreakSetting;

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

	@Override
	public List<Map<String, String>> choiceMemberDelete(Map<String, Object> map) {
		return sqlSession.selectList("break.choiceMemberDelete",map);
	}

	@Override
	public int insertReward(Map<String, Object> map) {
		return sqlSession.insert("break.insertReward",map);
	}

	@Override
	public int updateReward(Map<String, Object> map) {
		return sqlSession.update("break.updateReward",map);
	}

	@Override
	public List<Map<String, String>> afterInsert(Map<String, Object> map) {
		return sqlSession.selectList("break.afterInsert",map);
	}

	@Override
	public List<Map<String, String>> afterUpdate(Map<String, Object> map) {
		return sqlSession.selectList("break.afterUpdate",map);
	}

	@Override
	public List<Map<String, String>> personBreak(String userId) {
		return sqlSession.selectList("break.personBreak",userId);
	}

	@Override
	public Map<String, String> selectMyInfo(String userId) {
		return sqlSession.selectOne("break.selectMyInfo",userId);
	}

	@Override
	public int breakInesert(BreakRequest breakrequest) {
		return sqlSession.insert("break.breakInesert",breakrequest);
	}


	@Override
	public int selectBreakRequestCnt(String comId) {
		return sqlSession.selectOne("break.selectBreakRequestCnt",comId);
	}

	@Override
	public List<Map<String, Object>> selectBreakRequest(int cPage, int numPerPage, String comId) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("break.selectBreakRequest" , comId, rowBounds);
	}

	@Override

	public int deleteBreak(String breakid) {
		return sqlSession.update("break.deleteBreak",breakid);
	}
	public BreakSetting selectBreakSetting(String com_no) {
		return sqlSession.selectOne("break.selectBreakSetting", com_no);
	}

	@Override
	public int updateBreakSetting(BreakSetting bs) {
		return sqlSession.update("break.updateBreakSetting", bs);

	}

	@Override
	public List<Map<String, Object>> alllBreakList(String comId,int numPerPage, int cPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		
		System.out.println("daoImpl numPerPage" + numPerPage);
		return sqlSession.selectList("break.alllBreakList", comId, rowBounds);
		
	}

	@Override
	public int allBreakListCnt(String comId) {
		return sqlSession.selectOne("break.allBreakListCnt", comId);
	}

	@Override
	public int updateBreakInfo(Map<String, String> map) {
		return sqlSession.update("break.updateBreakInfo", map);
	}

	@Override
	public List<Map<String, Object>> searchKindList(String userid) {
		return sqlSession.selectList("break.searchKindList", userid);
	}

	@Override
	public List<Map<String, Object>> personBreakRequestList(String userid) {
		return sqlSession.selectList("break.personBreakRequestList", userid);
	}

	@Override
	public int callProc_break_manual(BreakSetting bs) {
		return sqlSession.update("break.callProc_break_manual", bs);
	}

	@Override
	public List<BreakRequest> selectBreakRequestUserIdList(Map<String, String> map) {
		return sqlSession.selectList("break.selectBreakRequestUserIdList", map);
	}

}
