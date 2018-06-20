package com.kh.ok.board.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.ok.board.model.vo.Board;

public interface BoardDAO {

	List<Map<String, String>> selectBoardBasicList(int cPage, int numPerPage);

	int selectBoardCount();

	int insertBasicBoard(Board board);

	Board selectBoardView(int boardNo);

	int updateBasicBoard(Board board);

	int deleteBoard(int boardNo);

}
