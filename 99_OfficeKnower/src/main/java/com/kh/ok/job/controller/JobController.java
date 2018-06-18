package com.kh.ok.job.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kh.ok.job.model.service.JobService;

@Controller
public class JobController {
	@Autowired
	private JobService jobService;
}
