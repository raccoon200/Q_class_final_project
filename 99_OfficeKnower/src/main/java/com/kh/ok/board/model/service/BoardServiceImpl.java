package com.kh.ok.board.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.ok.board.model.dao.BoardDAO;
import com.kh.ok.board.model.vo.Board;
import com.kh.ok.board.model.vo.BoardBookMark;
import com.kh.ok.board.model.vo.BoardGroup;
import com.kh.ok.board.model.vo.BoardMenu;

@Service
public class BoardServiceImpl implements BoardService{
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private BoardDAO boardDAO;
	@Override
	public List<Map<String, String>> selectBoardBasicList(int cPage, int numPerPage, int boardMenuNo) {
		return boardDAO.selectBoardBasicList(cPage, numPerPage, boardMenuNo);
	}
	@Override
	public int selectBoardCount() {
		return boardDAO.selectBoardCount();
	}
	@Override
	public int insertBasicBoard(Board board) {
		return boardDAO.insertBasicBoard(board);
	}
	@Override
	public Board selectBoardView(int boardNo) {
		return boardDAO.selectBoardView(boardNo);
	}
	@Override
	public int updateBasicBoard(Board board) {
		return boardDAO.updateBasicBoard(board);
	}
	@Override
	public int deleteBoard(int boardNo) {
		return boardDAO.deleteBoard(boardNo);
	}
	@Override
	public int insertBoardMenu(BoardMenu boardMenu) {
		return boardDAO.insertBoardMenu(boardMenu);
	}
	@Override
	public int insertBoardGroup(BoardGroup boardGroup) {
		return boardDAO.insertBoardGroup(boardGroup);
	}
	@Override
	public int importantApply(BoardBookMark bbm) {
		return boardDAO.importantApply(bbm);
	}
	@Override
	public int importantDelete(BoardBookMark bbm) {
		return boardDAO.importantDelete(bbm);
	}
	@Override
	public int increaseBoardCount(int boardNo) {
		return boardDAO.increaseBoardCount(boardNo);
	}
	@Override
	public int selectBoardBookMark(BoardBookMark bbm) {
		return boardDAO.selectBoardBookMark(bbm);
	}
	@Override
	public List<Map<String, String>> selectBoardImportantList(int cPage, int numPerPage, String userId) {
		return boardDAO.selectBoardImportantList(cPage, numPerPage, userId);
	}
	@Override
	public int selectBoardImportantCount(String userId) {
		return boardDAO.selectBoardImportantCount(userId);
	}
	@Override
	public List<Map<String, String>> selectBoardRecentList(String userId) {
		return boardDAO.selectBoardRecentList(userId);
	}
	@Override
	public List<Map<String, String>> selectBoardMenuList(String userId) {
		return boardDAO.selectBoardMenuList(userId);
	}
	@Override
	public List<Map<String, String>> selectBoardGroupList(String string) {
		return boardDAO.selectBoardGroupList(string);
	}
	@Override
	public List<Map<String, String>> selectBoardBasicList(String string) {
		return boardDAO.selectBoardBasicList(string);
	}
	
}
