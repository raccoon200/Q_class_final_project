package com.kh.ok.breakTime.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.breakTime.model.dao.BreakDAO;
import com.kh.ok.breakTime.model.vo.Break;

@Service
public class BreakServiceImpl implements BreakService {
	@Autowired
	BreakDAO breakDao;

	@Override
	public List<Break> selectMyBreak(String userId) {
		return breakDao.selectMyBreak(userId);
	}

	@Override
	public List<Map<String, String>> selectBreakList(String comId) {
		return breakDao.selectBreakList(comId);
	}

	@Override
	public List<Map<String, String>> searchMember(Map<String, String> map) {
		return breakDao.searchMember(map);
	}


	@Override
	public List<Map<String, String>> choiceMember(Map<String, Object> map) {
		return breakDao.choiceMember(map);
	}

	@Override
	public List<Map<String, String>> choiceMemberDelete(Map<String, Object> map) {
		return breakDao.choiceMemberDelete(map);
	}
}
