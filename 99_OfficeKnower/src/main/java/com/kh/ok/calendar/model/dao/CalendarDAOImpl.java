package com.kh.ok.calendar.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.calendar.model.vo.Schedule;

@Repository
public class CalendarDAOImpl implements CalendarDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;


	@Override
	public List<Schedule> selectSechedule(String userId) {
		return sqlSession.selectList("calendar.selectSechedule",userId);
	}

}
