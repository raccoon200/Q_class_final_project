package com.kh.ok.breakTime.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.ok.breakTime.model.vo.Break;
import com.kh.ok.breakTime.model.vo.BreakRequest;
import com.kh.ok.breakTime.model.vo.BreakSetting;

public interface BreakDAO {

	List<Break> selectMyBreak(String userId);

	List<Map<String, String>> selectBreakList(String comId);

	List<Map<String, String>> searchMember(Map<String, String> map);

	List<Map<String, String>> choiceMember(Map<String, Object> map);

	List<Map<String, String>> choiceMemberDelete(Map<String, Object> map);

	int insertReward(Map<String, Object> map);

	int updateReward(Map<String, Object> map);

	List<Map<String, String>> afterInsert(Map<String, Object> map);

	List<Map<String, String>> afterUpdate(Map<String, Object> map);

	List<Map<String, String>> personBreak(String userId);

	Map<String, String> selectMyInfo(String userId);

	int breakInesert(BreakRequest breakrequest);

	int selectBreakRequestCnt(String comId);

	List<Map<String, Object>> selectBreakRequest(int cPage, int numPerPage, String comId);


	int deleteBreak(String breakid);

	BreakSetting selectBreakSetting(String com_no);

	int updateBreakSetting(BreakSetting bs);

	int callProc_break_manual(BreakSetting bs);

	List<Map<String, Object>> alllBreakList(String comId,int numPerPage, int cPage);

	int allBreakListCnt(String comId);

	int updateBreakInfo(Map<String, String> map);

	List<Map<String, Object>> searchKindList(String userid);

	List<Map<String, Object>> personBreakRequestList(String userid);

	List<BreakRequest> selectBreakRequestUserIdList(Map<String, String> map);

	List<Map<String, Object>> checkBreak(String userid);

	int insertBreakInfo(Map<String, String> map);

}
