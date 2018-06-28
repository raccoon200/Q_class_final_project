package com.kh.ok.breakTime.model.service;

import java.util.List;
import java.util.Map;

import com.kh.ok.breakTime.model.vo.Break;

public interface BreakService {

	List<Break> selectMyBreak(String userId);

	List<Map<String, String>> selectBreakList(String comId);

	List<Map<String, String>> searchMember(Map<String, String> map);

	List<Map<String, String>> choiceMember(Map<String, Object> map);

}
