package com.kh.ok.job.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.job.model.dao.JobDAO;
import com.kh.ok.job.model.vo.Job;

@Service
public class JobServiceImpl implements JobService {
	@Autowired
	private JobDAO jobDAO;

	@Override
	public List<Job> selectJobList(String com_no) {
		return jobDAO.selectJobList(com_no);
	}
}
