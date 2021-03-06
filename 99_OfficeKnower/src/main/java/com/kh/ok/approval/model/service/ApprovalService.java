package com.kh.ok.approval.model.service;

import java.util.List;
import java.util.Map;

import com.kh.ok.approval.model.vo.Account;
import com.kh.ok.approval.model.vo.Approval;
import com.kh.ok.approval.model.vo.Connect;
import com.kh.ok.approval.model.vo.Dept;
import com.kh.ok.approval.model.vo.Title_of_Account;
import com.kh.ok.breakTime.model.vo.BreakRequest;
import com.kh.ok.member.model.vo.Member;

public interface ApprovalService {

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
	
	int updateSign(Member m);

	List<Member> selectaccountListByName(Map<String, String> map);

	List<Member> selectListMember(String com_no);

	List<Map<String, String>> selectListAdmin(String com_no);

	int deleteAdmin(Member m);

	List<Map<String, String>> selectAdmin(Member m);

	int adminInsert(Member m);

	Member selectMember(String userId);

	int approvalInsert(Approval approval);

	List<Map<String, String>> selectTitle_Of_Account(String com_no);

	List<Map<String, String>> selectDeptList(String com_no);


	int approvalDataListCount(String com_no);

	List<Map<String, String>> selectApprovalDataList(int cPage, int numPerPage, String com_no);

	List<Map<String, Object>> selectApprovalList(String com_no);

	List<Map<String, Object>> selectBreakRequestList(String com_no);

	Approval selectApprovalOne(String approval_no);

	String selectComName(String com_no);

	int approvalAccept(Approval approval);

	int approvalReject(Approval approval);

	List<Approval> selectAllApproval(Member m);

	List<BreakRequest> selectAllBreakRequest(Member m);

	List<Approval> select84Approval(Member m);

	List<BreakRequest> select84BreakRequest(Member m);

	List<Approval> selectComApproval(Member m);

	List<BreakRequest> selectComBreakRequest(Member m);

	List<Approval> selectReApproval(Member m);

	List<BreakRequest> selectReBreakRequest(Member m);

	String selectUserName(String spender);

	BreakRequest selectBreakRequestOne(String break_request_no);

	int breakRequestAccept(BreakRequest breakRequest);

	int breakRequestReject(BreakRequest breakRequest);
}
