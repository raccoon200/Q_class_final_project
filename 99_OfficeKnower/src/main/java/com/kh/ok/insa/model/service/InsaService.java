package com.kh.ok.insa.model.service;

import java.util.List;
import java.util.Map;

import com.kh.ok.member.model.vo.Member;

public interface InsaService {

	List<Member> memberListAll(String com_no);

	int profileUpdate(Member m);

	List<String> yearListGroup(String com_no);

	List<String> positionListGroup(String com_no);

	List<Member> selectmemberListAll(String com_no, int numPerPage, int cPage);

	int selectMemberListCnt(String com_no);

	List<Member> insaMemberSearch(Map<String, String> map);

}
