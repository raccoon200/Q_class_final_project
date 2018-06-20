package com.kh.ok.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.ok.board.model.vo.Board;
import com.kh.ok.board.model.vo.BoardMenu;

public interface BoardService {

	List<Map<String, String>> selectBoardBasicList(int cPage, int numPerPage);

	int selectBoardCount();

	int insertBasicBoard(Board board);

	Board selectBoardView(int boardNo);

	int updateBasicBoard(Board board);

	int deleteBoard(int boardNo);

	int insertBoardMenu(BoardMenu boardMenu);
	
}
