package com.kh.ok.approval.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.approval.model.vo.Account;
import com.kh.ok.approval.model.vo.Connect;
import com.kh.ok.approval.model.vo.Dept;
import com.kh.ok.approval.model.vo.Title_of_Account;
import com.kh.ok.member.model.vo.Member;

@Repository
public class ApprovalDAOImpl implements ApprovalDAO {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public int checkCodeDuplicate(Map<String, String> map) {
		return sqlSession.selectOne("approval.checkCodeDuplidate", map);
	}

	@Override
	public int connectionInsert(Connect connection) {
		return sqlSession.insert("approval.connectionInsert", connection);
	}

	@Override
	public int gajongInsert(Title_of_Account gajong) {
		return sqlSession.insert("approval.gajongInsert", gajong);
	}

	@Override
	public int deptInsert(Dept dept) {
		return sqlSession.insert("approval.deptInsert", dept);
	}

	@Override
	public List<Connect> selectListConnect(String com_no) {
		return sqlSession.selectList("approval.selectListConnect", com_no);
	}

	@Override
	public List<Title_of_Account> selectListToa(String com_no) {
		return sqlSession.selectList("approval.selectListToa", com_no);
	}

	@Override
	public List<Dept> selectListDept(String com_no) {
		return sqlSession.selectList("approval.selectListDept", com_no);
	}

	@Override
	public int connectionUpdate(Map<String, Object> map) {
		return sqlSession.update("approval.connectionUpdate", map);
	}

	@Override
	public int gajongUpdate(Map<String, Object> map) {
		return sqlSession.update("approval.gajongUpdate", map);
	}

	@Override
	public int deptUpdate(Map<String, Object> map) {
		return sqlSession.update("approval.deptUpdate", map);
	}

	@Override
	public int deleteCode(Map<String, String> map) {
		return sqlSession.delete("approval.deleteCode", map);
	}

	@Override
	public int deleteCodes(Map<String, Object> map) {
		return sqlSession.delete("approval.deleteCodes", map);
	}

	@Override
	public List<Account> selectListAccount(String com_no) {
		return sqlSession.selectList("approval.selectListAccount", com_no);
	}

	@Override
	public List<Member> selectListByName(Map<String, String> map) {
		return sqlSession.selectList("approval.selectListByName", map);
	}

	@Override
	public int accountInsert(Account account) {
		return sqlSession.insert("approval.accountInsert", account);
	}

	@Override
	public int accountDuplicate(Map<String, Object> map) {
		return sqlSession.selectOne("approval.accountDuplicate", map);
	}

	@Override
	public int accountUpdate(Account account) {
		return sqlSession.update("approval.accountUpdate", account);
	}

	@Override
	public int accountDelete(String userId) {
		return sqlSession.delete("approval.accountDelete", userId);
	}

}
