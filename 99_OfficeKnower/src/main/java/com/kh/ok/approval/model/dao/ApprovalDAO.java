package com.kh.ok.approval.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.ok.approval.model.vo.Account;
import com.kh.ok.approval.model.vo.Connect;
import com.kh.ok.approval.model.vo.Dept;
import com.kh.ok.approval.model.vo.Title_of_Account;
import com.kh.ok.member.model.vo.Member;

public interface ApprovalDAO {

	int checkCodeDuplicate(Map<String, String> map);

	int connectionInsert(Connect connection);

	int gajongInsert(Title_of_Account gajong);

	int deptInsert(Dept dept);

	List<Connect> selectListConnect(String com_no);

	List<Title_of_Account> selectListToa(String com_no);

	List<Dept> selectListDept(String com_no);

	int connectionUpdate(Map<String, Object> map);

	int gajongUpdate(Map<String, Object> map);

	int deptUpdate(Map<String, Object> map);

	int deleteCode(Map<String, String> map);

	int deleteCodes(Map<String, Object> map);

	List<Account> selectListAccount(String com_no);

	List<Member> selectListByName(Map<String, String> map);

	int accountInsert(Account account);

	int accountDuplicate(Map<String, Object> map);

	int accountUpdate(Account account);

	int accountDelete(String userId);

	List<Member> selectaccountListByName(Map<String, String> map);

	List<Member> selectListMember(String com_no);
	int signUpdate(Member m);

	List<Map<String, String>> selectListAdmin(String com_no);

	int deleteAdmin(Member m);

	List<Map<String, String>> adminSelect(Member m);

	int adminInsert(Member m);

	Member selectMember(String userId);

}
