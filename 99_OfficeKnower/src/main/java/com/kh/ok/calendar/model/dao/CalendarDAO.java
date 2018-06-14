package com.kh.ok.calendar.model.dao;

import java.util.List;

import com.kh.ok.calendar.model.vo.Schedule;

public interface CalendarDAO {

	List<Schedule> selectSechedule();

}
