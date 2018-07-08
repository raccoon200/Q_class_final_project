package com.kh.ok.approval.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.approval.model.dao.ApprovalDAO;
import com.kh.ok.approval.model.vo.Account;
import com.kh.ok.approval.model.vo.Approval;
import com.kh.ok.approval.model.vo.Connect;
import com.kh.ok.approval.model.vo.Dept;
import com.kh.ok.approval.model.vo.Title_of_Account;
import com.kh.ok.breakTime.model.vo.BreakRequest;
import com.kh.ok.member.model.vo.Member;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	@Autowired
	private ApprovalDAO approvalDAO;
	@Override
	public int checkCodeDuplicate(Map<String, String> map) {
		return approvalDAO.checkCodeDuplicate(map);
	}
	@Override
	public int connectionInsert(Connect connection) {
		return approvalDAO.connectionInsert(connection);
	}
	@Override
	public int gajongInsert(Title_of_Account gajong) {
		return approvalDAO.gajongInsert(gajong);
	}
	@Override
	public int deptInsert(Dept dept) {
		return approvalDAO.deptInsert(dept);
	}
	@Override
	public List<Connect> selectListConnect(String com_no) {
		return approvalDAO.selectListConnect(com_no);
	}
	@Override
	public List<Title_of_Account> selectListToa(String com_no) {
		return approvalDAO.selectListToa(com_no);
	}
	@Override
	public List<Dept> selectListDept(String com_no) {
		return approvalDAO.selectListDept(com_no);
	}
	@Override
	public int connectionUpdate(Map<String, Object> map) {
		return approvalDAO.connectionUpdate(map);
	}
	@Override
	public int gajongUpdate(Map<String, Object> map) {
		return approvalDAO.gajongUpdate(map);
	}
	@Override
	public int deptUpdate(Map<String, Object> map) {
		return approvalDAO.deptUpdate(map);
	}
	@Override
	public int deleteCode(Map<String, String> map) {
		return approvalDAO.deleteCode(map);
	}
	@Override
	public int deleteCodes(Map<String, Object> map) {
		return approvalDAO.deleteCodes(map);
	}
	@Override
	public List<Account> selectListAccount(String com_no) {
		return approvalDAO.selectListAccount(com_no);
	}
	@Override
	public List<Member> selectListByName(Map<String, String> map) {
		return approvalDAO.selectListByName(map);
	}
	@Override
	public int accountInsert(Account account) {
		return approvalDAO.accountInsert(account);
	}
	@Override
	public int accountDuplicate(Map<String, Object> map) {
		return approvalDAO.accountDuplicate(map);
	}
	@Override
	public int accountUpdate(Account account) {
		return approvalDAO.accountUpdate(account);
	}
	@Override
	public int accountDelete(String userId) {
		return approvalDAO.accountDelete(userId);
	}
	@Override
	public List<Member> selectaccountListByName(Map<String, String> map) {
		return approvalDAO.selectaccountListByName(map);
	}
	@Override
	public List<Member> selectListMember(String com_no) {
		return approvalDAO.selectListMember(com_no);
	}
	@Override
	public int updateSign(Member m) {
		return approvalDAO.signUpdate(m);
	}
	@Override
	public List<Map<String, String>> selectListAdmin(String com_no) {
		return approvalDAO.selectListAdmin(com_no);
	}
	@Override
	public int deleteAdmin(Member m) {
		return approvalDAO.deleteAdmin(m);
	}
	@Override
	public List<Map<String, String>> selectAdmin(Member m) {
		return approvalDAO.adminSelect(m);
	}
	@Override
	public int adminInsert(Member m ) {
		return approvalDAO.adminInsert(m);
	}
	@Override
	public Member selectMember(String userId) {
		return approvalDAO.selectMember(userId);
	}
	@Override
	public int approvalInsert(Approval approval) {
		return approvalDAO.approvalInsert(approval);
	}
	@Override
	public List<Map<String, String>> selectTitle_Of_Account(String com_no) {
		return approvalDAO.selectTitle_Of_Account(com_no);
	}
	@Override
	public List<Map<String, String>> selectDeptList(String com_no) {
		return approvalDAO.selectDeptList(com_no);
	}
	@Override
	public List<Map<String, String>> selectApprovalDataList(int cPage, int numPerPage, String com_no) {
		return approvalDAO.selectApprovalDataList(cPage, numPerPage, com_no);
	}
	@Override
	public int approvalDataListCount(String com_no) {
		return approvalDAO.approvalDataListCount(com_no);
	}
	@Override
	public List<Map<String, Object>> selectApprovalList(String com_no) {
		return approvalDAO.selectApprovalList(com_no);
	}
	@Override
	public List<Map<String, Object>> selectBreakRequestList(String com_no) {
		return approvalDAO.selectBreakRequestList(com_no);
	}
	@Override
	public Approval selectApprovalOne(String approval_no) {
		return approvalDAO.selectApprovalOne(approval_no);
	}
	@Override
	public String selectComName(String com_no) {
		return approvalDAO.selectComName(com_no);
	}
	@Override
	public int approvalAccept(Approval approval) {
		return approvalDAO.approvalAccept(approval);
	}
	@Override
	public int approvalReject(Approval approval) {
		return approvalDAO.approvalReject(approval);
	}
	@Override
	public List<Approval> selectAllApproval(Member m) {
		return approvalDAO.selectAllApproval(m);
	}
	@Override
	public List<BreakRequest> selectAllBreakRequest(Member m) {
		return approvalDAO.selectAllBreakRequest(m);
	}
	@Override
	public List<Approval> select84Approval(Member m) {
		return approvalDAO.select84Approval(m);
	}
	@Override
	public List<BreakRequest> select84BreakRequest(Member m) {
		return approvalDAO.select84BreakRequest(m);
	}
	@Override
	public List<Approval> selectComApproval(Member m) {
		return approvalDAO.selectComApproval(m);
	}
	@Override
	public List<BreakRequest> selectComBreakRequest(Member m) {
		return approvalDAO.selectComBreakRequest(m);
	}
	@Override
	public List<Approval> selectReApproval(Member m) {
		return approvalDAO.selectReApproval(m);
	}
	@Override
	public List<BreakRequest> selectReBreakRequest(Member m) {
		return approvalDAO.selectReBreakRequest(m);
	}
	@Override
	public String selectUserName(String spender) {
		return approvalDAO.selectUserName(spender);
	}
	@Override
	public BreakRequest selectBreakRequestOne(String break_request_no) {
		return approvalDAO.selectBreakRequestOne(break_request_no);
	}
	@Override
	public int breakRequestAccept(BreakRequest breakRequest) {
		return approvalDAO.breakRequestAccept(breakRequest);
	}
	@Override
	public int breakRequestReject(BreakRequest breakRequest) {
		return approvalDAO.breakRequestReject(breakRequest);
	}
	
}
