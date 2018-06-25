package com.kh.ok.reservation.model.service;

import java.util.List;

import com.kh.ok.reservation.model.vo.Reservation;

public interface ReservationService {

	List<Reservation> reservationListPage(String userId);
	
}
