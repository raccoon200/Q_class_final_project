package com.kh.ok.board.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.board.model.dao.BoardDAO;
import com.kh.ok.board.model.vo.Board;

@Service
public class BoardServiceImpl implements BoardService{
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private BoardDAO boardDAO;
	@Override
	public List<Map<String, String>> selectBoardBasicList(int cPage, int numPerPage) {
		return boardDAO.selectBoardBasicList(cPage, numPerPage);
	}
	@Override
	public int selectBoardCount() {
		return boardDAO.selectBoardCount();
	}
	@Override
	public int insertBasicBoard(Board board) {
		return boardDAO.insertBasicBoard(board);
	}
	
}
