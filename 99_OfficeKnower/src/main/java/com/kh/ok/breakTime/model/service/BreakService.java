package com.kh.ok.breakTime.model.service;

import java.util.List;
import java.util.Map;

import com.kh.ok.breakTime.model.vo.Break;
import com.kh.ok.breakTime.model.vo.BreakRequest;
import com.kh.ok.breakTime.model.vo.BreakSetting;

public interface BreakService {

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


}
