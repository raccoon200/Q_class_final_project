package com.kh.ok.calendar.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.calendar.model.dao.CalendarDAO;
import com.kh.ok.calendar.model.vo.Schedule;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDAO calendarDAO;
	

	@Override
	public List<Schedule> selectSechedule(Map<String, String> map) {
		return calendarDAO.selectSechedule(map);
	}


	@Override
	public int selectInsert(Schedule schedule) {
		return calendarDAO.selectInsert(schedule);
	}


	@Override
	public List<String>selectCalendar(String userId) {
		return calendarDAO.selectCalendar(userId);
	}


	@Override
	public int scheduleUpdate(Schedule schedule) {
		return calendarDAO.scheduleUpdate(schedule);
	}


	@Override
	public int scheduleDelete(String sid) {
		return calendarDAO.scheduleDelete(sid);
	}


	@Override
	public List<Schedule> calendarView(Map<String, String> map) {
		return calendarDAO.calendarView(map);
	}


	@Override
	public int calUpdate(Map<String, String> map) {
		return calendarDAO.calUpdate(map);
	}


	@Override
	public int calInsert(Map<String, String> map) {
		return calendarDAO.calInsert(map);
	}


	@Override
	public int caldelete(String calId) {
		return calendarDAO.calInsert(calId);
	}


	@Override
	public List<Schedule> shareCal(String type) {
		return calendarDAO.shareCal(type);
	}


	@Override
	public List<Schedule> myCal(Map<String, String> map) {
		return calendarDAO.myCal(map);
	}


	



}
