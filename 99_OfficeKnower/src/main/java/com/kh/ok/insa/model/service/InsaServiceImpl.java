package com.kh.ok.insa.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.insa.model.dao.InsaDAO;
import com.kh.ok.member.model.vo.Member;

@Service
public class InsaServiceImpl implements InsaService {

	@Autowired
	private InsaDAO insaDAO;
	
	@Override
	public List<Member> memberListAll(String com_no) {
		return insaDAO.memberListAll(com_no);
	}

	@Override
	public int profileUpdate(Member m) {
		return insaDAO.profileUpdate(m);
	}

	@Override
	public List<String> yearListGroup(String com_no) {
		return insaDAO.yearListGroup(com_no);
	}

	@Override
	public List<String> positionListGroup(String com_no) {
		return insaDAO.positionListGroup(com_no);
	}

}
