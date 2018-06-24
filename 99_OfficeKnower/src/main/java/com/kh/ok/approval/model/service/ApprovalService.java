package com.kh.ok.approval.model.service;

import java.util.List;
import java.util.Map;

import com.kh.ok.approval.model.vo.Connect;
import com.kh.ok.approval.model.vo.Dept;
import com.kh.ok.approval.model.vo.Title_of_Account;

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

}
