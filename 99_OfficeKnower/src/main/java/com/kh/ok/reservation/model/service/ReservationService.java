package com.kh.ok.reservation.model.service;

import java.util.List;
import java.util.Map;

import com.kh.ok.member.model.vo.Member;
import com.kh.ok.reservation.model.vo.Reservation;
import com.kh.ok.reservation.model.vo.Resources;

public interface ReservationService {

	List<Reservation> reservationListPage(String userId);

	List<Resources> selectResources(String com_no);

	List<Map<String, String>> selectCategory(String com_no);

	int reservationEnroll(Reservation reservation);

	List<Reservation> reservationListPageN(String userId);

	Reservation selectOneReservationNo(int reservationNo);

	int reservationDeleteOne(int reservation_no);

	List<Map<String, String>> selectListAdmin(String com_no);

	int deleteAdmin(Member member);

	List<Map<String, String>> selectAdmin(Member m);

	Member selectMember(String userId);

	int adminInsert(Member m);
	
}
