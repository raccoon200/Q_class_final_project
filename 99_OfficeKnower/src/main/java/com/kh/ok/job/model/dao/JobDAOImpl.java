package com.kh.ok.job.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.job.model.vo.Job;

@Repository
public class JobDAOImpl implements JobDAO{
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Job> selectJobList(String com_no) {
		return sqlSession.selectList("job.selectJobList",com_no);
	}
}
