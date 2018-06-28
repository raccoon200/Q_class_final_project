package com.kh.ok.reservation.model.service;

import java.util.List;
import java.util.Map;

import com.kh.ok.reservation.model.vo.Reservation;
import com.kh.ok.reservation.model.vo.Resources;

public interface ReservationService {

	List<Reservation> reservationListPage(String userId);

	List<Resources> selectResources(String com_no);

	List<Map<String, String>> selectCategory(String com_no);

	int reservationEnroll(Reservation reservation);

	List<Reservation> reservationListPageN(String userId);
	
}
