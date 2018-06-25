package com.kh.ok.calendar.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.calendar.model.vo.Schedule;

@Repository
public class CalendarDAOImpl implements CalendarDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;


	@Override
	public List<Schedule> selectSechedule(Map<String, String> map) {
		return sqlSession.selectList("calendar.selectSechedule",map);
	}


	@Override
	public int selectInsert(Schedule schedule) {
		return sqlSession.insert("calendar.selectInsert",schedule);
	}


	@Override
	public List<String> selectCalendar(String userId) {
		return sqlSession.selectList("calendar.selectCalendar",userId);
	}


	@Override
	public int scheduleUpdate(Schedule schedule) {
		return sqlSession.update("calendar.scheduleUpdate",schedule);
	}


	@Override
	public int scheduleDelete(String sid) {
		return sqlSession.delete("calendar.scheduleDelete",sid);
	}


	@Override
	public List<Schedule> calendarView(Map<String, String> map) {
		return sqlSession.selectList("calendar.calendarView",map);
	}


	@Override
	public int calUpdate(Map<String, String> map) {
		return sqlSession.update("calendar.calUpdate",map);
	}


	@Override
	public int calInsert(Map<String, String> map) {
		return sqlSession.insert("calendar.calInsert",map);
	}


	@Override
	public int calInsert(String calId) {
		return sqlSession.insert("calendar.caldelete",calId);
	}



}
