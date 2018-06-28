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

	

}
