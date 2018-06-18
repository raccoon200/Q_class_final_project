package com.kh.ok.job.model.service;

import java.util.List;

import com.kh.ok.job.model.vo.Job;

public interface JobService {

	List<Job> selectJobList(String com_no);
	
}
