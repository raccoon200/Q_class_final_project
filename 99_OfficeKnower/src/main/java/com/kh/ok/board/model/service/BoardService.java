package com.kh.ok.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.ok.board.model.vo.Board;
import com.kh.ok.board.model.vo.BoardBookMark;
import com.kh.ok.board.model.vo.BoardGroup;
import com.kh.ok.board.model.vo.BoardMenu;

public interface BoardService {

	List<Map<String, String>> selectBoardBasicList(int cPage, int numPerPage, int boardMenuNo);

	int selectBoardCount();

	int insertBasicBoard(Board board);

	Board selectBoardView(int boardNo);

	int updateBasicBoard(Board board);

	int deleteBoard(int boardNo);

	int insertBoardMenu(BoardMenu boardMenu);

	int insertBoardGroup(BoardGroup boardGroup);

	int importantApply(BoardBookMark bbm);

	int importantDelete(BoardBookMark bbm);

	int increaseBoardCount(int boardNo);

	int selectBoardBookMark(BoardBookMark bbm);

	List<Map<String, String>> selectBoardImportantList(int cPage, int numPerPage, String userId);

	int selectBoardImportantCount(String userId);

	List<Map<String, String>> selectBoardRecentList(String userId);

	List<Map<String, String>> selectBoardMenuList(String userId);

	List<Map<String, String>> selectBoardGroupList(String string);
	
	List<Map<String, String>> selectBoardBasicList(String string);
}
