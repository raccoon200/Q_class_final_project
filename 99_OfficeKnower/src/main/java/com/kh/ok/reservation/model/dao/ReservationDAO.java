package com.kh.ok.reservation.model.dao;

import java.util.List;

import com.kh.ok.reservation.model.vo.Reservation;

public interface ReservationDAO {

	List<Reservation> reservationListPage(String userId);

}
