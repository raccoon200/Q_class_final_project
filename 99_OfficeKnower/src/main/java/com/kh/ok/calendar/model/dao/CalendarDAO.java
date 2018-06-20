package com.kh.ok.calendar.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.ok.calendar.model.vo.Schedule;

public interface CalendarDAO {

	List<Schedule> selectSechedule(String userId);

	int selectInsert(Schedule schedule);

	List<String> selectCalendar(String userId);

	int scheduleUpdate(Schedule schedule);

	int scheduleDelete(String sid);

	

}
