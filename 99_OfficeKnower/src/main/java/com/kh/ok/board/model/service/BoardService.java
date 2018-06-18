package com.kh.ok.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.ok.board.model.vo.Board;

public interface BoardService {

	List<Map<String, String>> selectBoardBasicList(int cPage, int numPerPage);

	int selectBoardCount();

	int insertBasicBoard(Board board);
	
}
