package com.kh.ok.breakTime.controller.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.breakTime.controller.model.dao.BreakDAO;

@Service
public class BreakServiceImpl implements BreakService {
	@Autowired
	BreakDAO breakDao;
}
