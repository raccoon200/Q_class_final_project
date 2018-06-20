package com.kh.ok.member.model.service;

import java.util.List;
import java.util.Map;

import com.kh.ok.member.model.vo.Member;

public interface MemberService {

	Member selectUserId(String userId);

	int checkIdDuplicate(String userId);

	List<Map<String, String>> memberCompanyListAll(String com_no);

}
