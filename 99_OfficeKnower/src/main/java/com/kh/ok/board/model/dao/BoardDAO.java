package com.kh.ok.board.model.dao;

import java.util.List;
import java.util.Map;

public interface BoardDAO {

	List<Map<String, String>> selectBoardBasicList(int cPage, int numPerPage);

	int selectBoardCount();

}
