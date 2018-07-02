package com.kh.ok.reservation.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.reservation.model.vo.Reservation;
import com.kh.ok.reservation.model.vo.Resources;

@Repository
public class ReservationDAOImpl implements ReservationDAO {
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public List<Reservation> reservationListPage(String userId) {
		return sqlsession.selectList("reservation.reservationListPage", userId);
	}
	
	@Override
	public List<Reservation> reservationListPageN(String userId) {
		return sqlsession.selectList("reservation.reservationListPageN", userId);
	}
	
	@Override
	public List<Resources> selectResourcesList(String com_no) {
		return sqlsession.selectList("reservation.selectResourcesList", com_no);
	}
	
	@Override
	public List<Map<String, String>> selectCategory(String com_no) {
		return sqlsession.selectList("reservation.selectCategory", com_no);
	}

	@Override
	public int reservationEnroll(Reservation reservation) {
		return sqlsession.insert("reservation.reservationEnroll", reservation);
	}

	@Override
	public Reservation selectOneReservationNo(int reservationNo) {
		return sqlsession.selectOne("reservation.selectOneReservationNo", reservationNo);
	}

	@Override
	public int reservationDeleteOne(int reservation_no) {
		return sqlsession.delete("reservation.reservationDeleteOne", reservation_no);
	}

	@Override
	public int reservationReturn(int reservation_no) {
		return sqlsession.update("reservation.reservationReturn", reservation_no);
	}

	@Override
	public List<Reservation> reservationApprovalNull() {
		return sqlsession.selectList("reservation.reservationApprovalNull");
	}
	
	@Override
	public List<Reservation> reservationApprovalYes() {
		return sqlsession.selectList("reservation.reservationApprovalYes");
	}
	
	@Override
	public List<Reservation> reservationApprovalNo() {
		return sqlsession.selectList("reservation.reservationApprovalNo");
	}

	@Override
	public int reservationApprovalSetYes(int reservationNo) {
		return sqlsession.update("reservation.reservationApprovalSetYes", reservationNo);
	}

	@Override
	public int reservationApprovalSetNot(int reservation_no) {
		return sqlsession.update("reservation.reservationApprovalSetNot", reservation_no);
	}

	@Override
	public List<Reservation> selectReturnListN() {
		return sqlsession.selectList("reservation.selectReturnListN");
	}

	@Override
	public List<Reservation> selectReturnListY() {
		return sqlsession.selectList("reservation.selectReturnListY");
	}

	@Override
	public int reservationQuitStatusSetYes(int reservation_no) {
		return sqlsession.update("reservation.reservationQuitStatusSetYes", reservation_no);
	}
	
}
