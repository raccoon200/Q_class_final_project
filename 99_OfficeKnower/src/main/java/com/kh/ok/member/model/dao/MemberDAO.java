package com.kh.ok.member.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.ok.member.model.vo.Member;

public interface MemberDAO {

	Member selectUserId(String userId);

	int checkIdDuplicate(String userId);

	List<Map<String, String>> memberCompanyListAll(String com_no);

}
