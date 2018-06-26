package com.kh.ok.insa.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.ok.insa.model.vo.Position;
import com.kh.ok.member.model.vo.Member;

public interface InsaDAO {

	List<Member> memberListAll(String com_no);

	int profileUpdate(Member m);

	List<String> yearListGroup(String com_no);

	List<String> positionListGroup(String com_no);

	List<Member> selectmemberListAll(String com_no, int numPerPage, int cPage);

	int selectMemberListCnt(String com_no);

	List<Member> insaMemberSearch(Map<String, String> map);

	List<Member> insaSelectMemberSearch(String com_no, int numPerPage, int cPage, Map<String, String> map);

	int selectSelectMemberListCnt(Map<String, String> map);

	Member memberSelectManagement(String userId);

	List<Position> selectPositionList(String com_no);

	int checkIdDuplicate(Map<String, String> no);

}
