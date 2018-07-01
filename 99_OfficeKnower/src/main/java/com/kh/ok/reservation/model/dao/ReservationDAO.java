package com.kh.ok.reservation.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.ok.reservation.model.vo.Reservation;
import com.kh.ok.reservation.model.vo.Resources;

public interface ReservationDAO {

	List<Reservation> reservationListPage(String userId);

	List<Resources> selectResourcesList(String com_no);

	List<Map<String, String>> selectCategory(String com_no);

	int reservationEnroll(Reservation reservation);

	List<Reservation> reservationListPageN(String userId);

	Reservation selectOneReservationNo(int reservationNo);

	int reservationDeleteOne(int reservation_no);

	int reservationReturn(int reservation_no);

	List<Reservation> reservationApprovalNo(String userId);

}
