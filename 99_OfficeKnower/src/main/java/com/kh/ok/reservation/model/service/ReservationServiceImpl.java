package com.kh.ok.reservation.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
