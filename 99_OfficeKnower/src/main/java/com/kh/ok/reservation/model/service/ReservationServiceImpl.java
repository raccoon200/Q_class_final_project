package com.kh.ok.reservation.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.reservation.model.dao.ReservationDAO;
import com.kh.ok.reservation.model.vo.Reservation;

@Service
public class ReservationServiceImpl implements ReservationService {
	@Autowired
	private ReservationDAO reservationDAO;
	
	@Override
	public List<Reservation> reservationListPage(String userId) {
		return reservationDAO.reservationListPage(userId);
	}

}
