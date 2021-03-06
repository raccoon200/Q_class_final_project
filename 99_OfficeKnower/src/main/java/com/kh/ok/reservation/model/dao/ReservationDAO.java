package com.kh.ok.reservation.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.ok.member.model.vo.Member;
import com.kh.ok.reservation.model.vo.Reservation;
import com.kh.ok.reservation.model.vo.Resources;

public interface ReservationDAO {

	List<Reservation> reservationListPage(String userId);

	List<Map<String, String>> selectResourcesList(String com_no);

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

	int reservationReturn(int reservation_no);

	List<Reservation> reservationApprovalNull();

	List<Reservation> reservationApprovalYes();

	List<Reservation> reservationApprovalNo();

	int reservationApprovalSetYes(int reservationNo);

	int reservationApprovalSetNot(int reservation_no);

	List<Reservation> selectReturnListN();

	List<Reservation> selectReturnListY();

	int reservationQuitStatusSetYes(int reservation_no);

	List<Map<String, String>> reservationCategoryListCnt(String com_no);

	int reservationCategoryAdd(HashMap<String, String> map);

	int reservationCategoryUpdate(HashMap<String, String> map);

	int reservationCategoryDelete(HashMap<String, String> map);

	int reservationResourcesAdd(Resources resources);

	int reservationResourcesUpdate(Resources resources);

	int reservationResourcesDelete(int res_no);

	List<Reservation> reservationListCategory(HashMap<String, String> map);

	List<Reservation> reservationListCategoryNull(HashMap<String, String> map);

	List<Map<String, String>> selectReservationDateList(String com_no);

}
