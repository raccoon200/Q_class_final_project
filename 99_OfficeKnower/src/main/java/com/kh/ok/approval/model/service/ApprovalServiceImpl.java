package com.kh.ok.approval.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.approval.model.dao.ApprovalDAO;
import com.kh.ok.approval.model.vo.Account;
import com.kh.ok.approval.model.vo.Connect;
import com.kh.ok.approval.model.vo.Dept;
import com.kh.ok.approval.model.vo.Title_of_Account;
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
	public int updateSign(Member m) {
		return approvalDAO.signUpdate(m);
	}
	@Override
	public List<Map<String, String>> selectListAdmin() {
		return approvalDAO.selectListAdmin();
	}
	@Override
	public int deleteAdmin(Member m) {
		return approvalDAO.deleteAdmin(m);
	}
	@Override
	public List<Map<String, String>> selectAdmin(String userName) {
		return approvalDAO.adminSelect(userName);
	}
	@Override
	public int adminInsert(Member m ) {
		return approvalDAO.adminInsert(m);
	}
	@Override
	public Member selectMember(String userId) {
		return approvalDAO.selectMember(userId);
	}
	
}
