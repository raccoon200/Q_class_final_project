package com.kh.ok.reservation.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.reservation.model.vo.Reservation;

@Repository
public class ReservationDAOImpl implements ReservationDAO {
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public List<Reservation> reservationListPage(String userId) {
		return sqlsession.selectList("reservation.reservationListPage", userId);
	}

}
