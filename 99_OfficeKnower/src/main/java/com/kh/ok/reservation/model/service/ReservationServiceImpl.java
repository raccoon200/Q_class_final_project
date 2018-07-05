package com.kh.ok.reservation.model.service;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.member.model.vo.Member;
import com.kh.ok.reservation.model.dao.ReservationDAO;
import com.kh.ok.reservation.model.vo.Reservation;
import com.kh.ok.reservation.model.vo.Resources;

@Service
public class ReservationServiceImpl implements ReservationService {
	@Autowired
	private ReservationDAO reservationDAO;
	
	@Override
	public List<Reservation> reservationListPage(String userId) {
		return reservationDAO.reservationListPage(userId);
	}

	@Override
	public List<Resources> selectResources(String com_no) {
		return reservationDAO.selectResourcesList(com_no);
	}

	@Override
	public List<Map<String, String>> selectCategory(String com_no) {
		return reservationDAO.selectCategory(com_no);
	}

	@Override
	public int reservationEnroll(Reservation reservation) {
		return reservationDAO.reservationEnroll(reservation);
	}

	@Override
	public List<Reservation> reservationListPageN(String userId) {
		return reservationDAO.reservationListPageN(userId);
	}

	@Override
	public Reservation selectOneReservationNo(int reservationNo) {
		return reservationDAO.selectOneReservationNo(reservationNo);
	}

	@Override
	public int reservationDeleteOne(int reservation_no) {
		return reservationDAO.reservationDeleteOne(reservation_no);
	}

	@Override
	public List<Map<String, String>> selectListAdmin(String com_no) {
		return reservationDAO.selectListAdmin(com_no);
	}

	@Override
	public int deleteAdmin(Member member) {
		return reservationDAO.deleteAdmin(member);
	}

	@Override
	public List<Map<String, String>> selectAdmin(Member m) {
		return reservationDAO.selectAdmin(m);
	}

	@Override
	public Member selectMember(String userId) {
		return reservationDAO.selectMember(userId);
	}

	@Override
	public int adminInsert(Member m) {
		return reservationDAO.adminInsert(m);
	}

	public int reservationReturn(int reservation_no) {
		return reservationDAO.reservationReturn(reservation_no);
	}
	
	@Override
	public List<Reservation> reservationApprovalNull() {
		return reservationDAO.reservationApprovalNull();
	}
	
	@Override
	public List<Reservation> reservationApprovalYes() {
		return reservationDAO.reservationApprovalYes();
	}
	
	@Override
	public List<Reservation> reservationApprovalNo() {
		return reservationDAO.reservationApprovalNo();
	}

	@Override
	public int reservationApprovalSetYes(int reservationNo) {
		return reservationDAO.reservationApprovalSetYes(reservationNo);
	}

	@Override
	public int reservationApprovalSetNot(int reservation_no) {
		return reservationDAO.reservationApprovalSetNot(reservation_no);
	}

	@Override
	public List<Reservation> selectReturnListN() {
		return reservationDAO.selectReturnListN();
	}

	@Override
	public List<Reservation> selectReturnListY() {
		return reservationDAO.selectReturnListY();
	}

	@Override
	public int reservationQuitStatusSetYes(int reservation_no) {
		return reservationDAO.reservationQuitStatusSetYes(reservation_no);
	}

	@Override
	public List<Map<String, String>> reservationCategoryListCnt(String com_no) {
		return reservationDAO.reservationCategoryListCnt(com_no);
	}

	@Override
	public int reservationCategoryAdd(HashMap<String, String> map) {
		return reservationDAO.reservationCategoryAdd(map);
	}

	@Override
	public int reservationCategoryUpdate(HashMap<String, String> map) {
		return reservationDAO.reservationCategoryUpdate(map);
	}

	@Override
	public int reservationCategoryDelete(HashMap<String, String> map) {
		return reservationDAO.reservationCategoryDelete(map);
	}

}
