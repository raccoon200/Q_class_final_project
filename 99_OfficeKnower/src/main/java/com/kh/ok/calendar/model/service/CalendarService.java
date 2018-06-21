package com.kh.ok.calendar.model.service;

import java.util.List;
import java.util.Map;

import com.kh.ok.calendar.model.vo.Schedule;

public interface CalendarService {

	List<Schedule> selectSechedule(Map<String, String> map);

	int selectInsert(Schedule schedule);

	List<String> selectCalendar(String userId);

	int scheduleUpdate(Schedule schedule);

	int scheduleDelete(String sid);

	List<Schedule> calendarView(Map<String, String> map);


}
