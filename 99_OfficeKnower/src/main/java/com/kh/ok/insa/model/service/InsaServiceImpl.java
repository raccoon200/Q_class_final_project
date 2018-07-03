package com.kh.ok.insa.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.insa.model.dao.InsaDAO;
import com.kh.ok.insa.model.vo.Position;
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

	@Override
	public List<Member> selectmemberListAll(String com_no, int numPerPage, int cPage) {
		return insaDAO.selectmemberListAll(com_no, numPerPage, cPage);
	}

	@Override
	public int selectMemberListCnt(String com_no) {
		return insaDAO.selectMemberListCnt(com_no);
	}

	@Override
	public List<Member> insaMemberSearch(Map<String, String> map) {
		return insaDAO.insaMemberSearch(map);
	}

	@Override
	public List<Member> insaSelectMemberSearch(String com_no, int numPerPage, int cPage, Map<String, String> map) {
		return insaDAO.insaSelectMemberSearch(com_no, numPerPage, cPage, map);
	}

	@Override
	public int selectSelectMemberListCnt(Map<String, String> map) {
		return insaDAO.selectSelectMemberListCnt(map);
	}

	@Override
	public Member memberSelectManagement(String userId) {
		return insaDAO.memberSelectManagement(userId);
	}

	@Override
	public List<Position> selectPositionList(String com_no) {
		return insaDAO.selectPositionList(com_no);
	}

	@Override
	public int checkIdDuplicate(Map<String, String> no) {
		return insaDAO.checkIdDuplicate(no);
	}

	@Override
	public int insaMemberOneUpdate(Member member) {
		return insaDAO.insaMemberOneUpdate(member);
	}

	@Override
	public int insaMemberDelete(Map<String, Object> map) {
		return insaDAO.insaMemberDelete(map);
	}

	@Override
	public int insaMemberUpdate(Map<String, Object> map) {
		return insaDAO.insaMemberUpdate(map);
	}

	@Override
	public int positionInsert(Map<String, Object> map) {
		return insaDAO.positionInsert(map);
	}

	@Override
	public int updatePositionModal(Map<String, Object> map) {
		return insaDAO.updatePositionModal(map);
	}

	@Override
	public int insaPositionDelete(Map<String, Object> map) {
		return insaDAO.insaPositionDelete(map);
	}

	@Override
	public int insaPositionUpdate(Map<String, Object> map) {
		return insaDAO.insaPositionUpdate(map);
	}

	@Override
	public int insaJobInsert(Map<String, String> map) {
		return insaDAO.insaJobInsert(map);
	}

	@Override
	public int insaJobDelete(Map<String, String> map) {
		return insaDAO.insaJobDelete(map);
	}

	@Override
	public int insaJobUpdate(Map<String, String> map) {
		return insaDAO.insaJobUpdate(map);
	}

}
