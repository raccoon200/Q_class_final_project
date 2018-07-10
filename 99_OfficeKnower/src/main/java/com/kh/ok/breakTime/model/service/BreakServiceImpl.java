package com.kh.ok.breakTime.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.breakTime.model.dao.BreakDAO;
import com.kh.ok.breakTime.model.vo.Break;
import com.kh.ok.breakTime.model.vo.BreakRequest;
import com.kh.ok.breakTime.model.vo.BreakSetting;

@Service
public class BreakServiceImpl implements BreakService {
	@Autowired
	BreakDAO breakDao;

	@Override
	public List<Break> selectMyBreak(String userId) {
		return breakDao.selectMyBreak(userId);
	}

	@Override
	public List<Map<String, String>> selectBreakList(String comId) {
		return breakDao.selectBreakList(comId);
	}

	@Override
	public List<Map<String, String>> searchMember(Map<String, String> map) {
		return breakDao.searchMember(map);
	}


	@Override
	public List<Map<String, String>> choiceMember(Map<String, Object> map) {
		return breakDao.choiceMember(map);
	}

	@Override
	public List<Map<String, String>> choiceMemberDelete(Map<String, Object> map) {
		return breakDao.choiceMemberDelete(map);
	}

	@Override
	public int insertReward(Map<String, Object> map) {
		return breakDao.insertReward(map);
	}

	@Override
	public int updateReward(Map<String, Object> map) {
		return breakDao.updateReward(map);
	}

	@Override
	public List<Map<String, String>> afterInsert(Map<String, Object> map) {
		return breakDao.afterInsert(map);
	}

	@Override
	public List<Map<String, String>> afterUpdate(Map<String, Object> map) {
		return breakDao.afterUpdate(map);
	}

	@Override
	public List<Map<String, String>> personBreak(String userId) {
		return breakDao.personBreak(userId);
	}

	@Override
	public Map<String, String> selectMyInfo(String userId) {
		return breakDao.selectMyInfo(userId);
	}

	@Override
	public int breakInesert(BreakRequest breakrequest) {
		return breakDao.breakInesert(breakrequest);
	}


	@Override
	public int selectBreakRequestCnt(String comId) {
		return breakDao.selectBreakRequestCnt(comId);
	}

	@Override
	public List<Map<String, Object>> selectBreakRequest(int cPage, int numPerPage, String comId) {
		return breakDao.selectBreakRequest(cPage,numPerPage,comId);
	}

	@Override

	public int deleteBreak(String breakid) {
		return breakDao.deleteBreak(breakid);
	}
	public BreakSetting selectBreakSetting(String com_no) {
		return breakDao.selectBreakSetting(com_no);
	}

	@Override
	public int updateBreakSetting(BreakSetting bs) {
		return breakDao.updateBreakSetting(bs);

	}

	@Override
	public List<Map<String, Object>> alllBreakList(String comId, int numPerPage, int cPage) {
		return breakDao.alllBreakList(comId,numPerPage,cPage);
	}

	@Override
	public int allBreakListCnt(String comId) {
		return breakDao.allBreakListCnt(comId);
	}

	@Override
	public int updateBreakInfo(Map<String, String> map) {
		return breakDao.updateBreakInfo(map);
	}

	@Override
	public List<Map<String, Object>> searchKindList(String userid) {
		return breakDao.searchKindList(userid);
	}

	@Override
	public List<Map<String, Object>> personBreakRequestList(String userid) {
		return breakDao.personBreakRequestList(userid);
	}

	@Override
	public int callProc_break_manual(BreakSetting bs) {
		return breakDao.callProc_break_manual(bs);
	}

	@Override
	public List<BreakRequest> selectBreakRequestUserIdList(Map<String, String> map) {
		return breakDao.selectBreakRequestUserIdList(map);
	}

	@Override
	public List<Map<String, Object>> checkBreak(String userid) {
		return breakDao.checkBreak(userid);
	}

	@Override
	public int insertBreakInfo(Map<String, String> map) {
		return breakDao.insertBreakInfo(map);
	}

	@Override
	public List<Map<String, Object>> selectMybreaklist(String userId) {
		return breakDao.selectMybreaklist(userId);
	}
}
