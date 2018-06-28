package com.kh.ok.calendar.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.ok.calendar.model.vo.Schedule;

public interface CalendarDAO {

	List<Schedule> selectSechedule(Map<String, String> map);

	int selectInsert(Schedule schedule);

	List<String> selectCalendar(String userId);

	int scheduleUpdate(Schedule schedule);

	int scheduleDelete(String sid);

	List<Schedule> calendarView(Map<String, String> map);

	int calUpdate(Map<String, String> map);

	int calInsert(Map<String, String> map);

	int calInsert(String calId);

	List<Schedule> shareCal(String type);

	List<Schedule> myCal(Map<String, String> map);

	

}
