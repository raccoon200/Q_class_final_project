package com.kh.ok.job.model.dao;

import java.util.List;

import com.kh.ok.job.model.vo.Job;

public interface JobDAO {

	List<Job> selectJobList(String com_no);

}
