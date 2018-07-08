package com.kh.ok.reservation.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.member.model.vo.Member;
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
	public List<Map<String, String>> selectResourcesList(String com_no) {
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

	@Override
	public Reservation selectOneReservationNo(int reservationNo) {
		return sqlsession.selectOne("reservation.selectOneReservationNo", reservationNo);
	}

	@Override
	public int reservationDeleteOne(int reservation_no) {
		return sqlsession.delete("reservation.reservationDeleteOne", reservation_no);
	}

	@Override
	public List<Map<String, String>> selectListAdmin(String com_no) {
		return sqlsession.selectList("reservation.selectListAdmin", com_no);
	}

	@Override
	public int deleteAdmin(Member member) {
		if(member.getGrade()!="") {
			return sqlsession.update("reservation.deleteAdmin", member);
		}else {
			return sqlsession.update("reservation.deleteAdminNull",member);
		}
	}

	@Override
	public List<Map<String, String>> selectAdmin(Member m) {
		return sqlsession.selectList("reservation.adminSelect", m);
	}

	@Override
	public Member selectMember(String userId) {
		return sqlsession.selectOne("approval.memberSelect", userId);
		
	}

	@Override
	public int adminInsert(Member m) {
		return sqlsession.update("reservation.adminInsert", m);
	}

	public int reservationReturn(int reservation_no) {
		return sqlsession.update("reservation.reservationReturn", reservation_no);
	}

	@Override
	public List<Reservation> reservationApprovalNull() {
		return sqlsession.selectList("reservation.reservationApprovalNull");
	}
	
	@Override
	public List<Reservation> reservationApprovalYes() {
		return sqlsession.selectList("reservation.reservationApprovalYes");
	}
	
	@Override
	public List<Reservation> reservationApprovalNo() {
		return sqlsession.selectList("reservation.reservationApprovalNo");
	}

	@Override
	public int reservationApprovalSetYes(int reservationNo) {
		return sqlsession.update("reservation.reservationApprovalSetYes", reservationNo);
	}

	@Override
	public int reservationApprovalSetNot(int reservation_no) {
		return sqlsession.update("reservation.reservationApprovalSetNot", reservation_no);
	}

	@Override
	public List<Reservation> selectReturnListN() {
		return sqlsession.selectList("reservation.selectReturnListN");
	}

	@Override
	public List<Reservation> selectReturnListY() {
		return sqlsession.selectList("reservation.selectReturnListY");
	}

	@Override
	public int reservationQuitStatusSetYes(int reservation_no) {
		return sqlsession.update("reservation.reservationQuitStatusSetYes", reservation_no);
	}

	@Override
	public List<Map<String, String>> reservationCategoryListCnt(String com_no) {
		return sqlsession.selectList("reservation.reservationCategoryListCnt", com_no);
	}

	@Override
	public int reservationCategoryAdd(HashMap<String, String> map) {
		return sqlsession.insert("reservation.reservationCategoryAdd", map);
	}

	@Override
	public int reservationCategoryUpdate(HashMap<String, String> map) {
		return sqlsession.update("reservation.reservationCategoryUpdate", map);
	}

	@Override
	public int reservationCategoryDelete(HashMap<String, String> map) {
		sqlsession.delete("reservation.reservationCateReservationDelete", map);
		sqlsession.delete("reservation.reservationCateResourcesDelete", map);		
		
		return sqlsession.delete("reservation.reservationCategoryDelete", map);
	}

	@Override
	public int reservationResourcesAdd(Resources resources) {
		return sqlsession.insert("reservation.reservationResourcesAdd", resources);
	}

	@Override
	public int reservationResourcesUpdate(Resources resources) {
		return sqlsession.update("reservation.reservationResourcesUpdate", resources);
	}

	@Override
	public int reservationResourcesDelete(int res_no) {
		sqlsession.delete("reservation.reservationResReservationDelete", res_no);
		return sqlsession.delete("reservation.reservationResourcesDelete", res_no);
	}

	@Override
	public List<Reservation> reservationListCategory(HashMap<String, String> map) {
		return sqlsession.selectList("reservation.reservationListCategory", map);
	}

	@Override
	public List<Reservation> reservationListCategoryNull(HashMap<String, String> map) {
		return sqlsession.selectList("reservation.reservationListCategoryNull", map);
	}

	@Override
	public List<Map<String, String>> selectReservationDateList(String com_no) {
		return sqlsession.selectList("reservation.selectReservationDateList", com_no);
	}

}
