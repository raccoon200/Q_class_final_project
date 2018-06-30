package com.kh.ok.reservation.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.member.model.vo.Member;
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
	public List<Map<String, String>> selectListAdmin(String com_no) {
		return sqlsession.selectList("reservation.selectListAdmin", com_no);
	}

	@Override
	public int deleteAdmin(Member member) {
		if(member.getGrade()!="") {
			return sqlsession.update("reservation.deleteAdmin", member);
		}else {
			return sqlsession.update("reservation.deleteAdminNull",member);
		}
	}

	@Override
	public List<Map<String, String>> selectAdmin(Member m) {
		return sqlsession.selectList("reservation.adminSelect", m);
	}

	@Override
	public Member selectMember(String userId) {
		return sqlsession.selectOne("approval.memberSelect", userId);
		
	}

	@Override
	public int adminInsert(Member m) {
		return sqlsession.update("reservation.adminInsert", m);
	}
}
