package com.kh.ok.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.ok.board.model.vo.Board;

@Repository
public class BoardDAOImpl implements BoardDAO{
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Override
	public List<Map<String, String>> selectBoardBasicList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("selectBoardBasicList" , null, rowBounds);
	}
	@Override
	public int selectBoardCount() {
		return sqlSession.selectOne("selectBoardCount");
	}
	@Override
	public int insertBasicBoard(Board board) {
		System.out.println("board : "+board);
		return sqlSession.insert("board.insertBasicBoard",board);
	}
	@Override
	public Board selectBoardView(int boardNo) {
		return sqlSession.selectOne("board.selectBoardView", boardNo);
	}
	@Override
	public int updateBasicBoard(Board board) {
		if(board.getOriginal_file_name() != null && board.getRenamed_file_name()!=null) {
			return sqlSession.update("board.updateBasicBoard",board);
		}else {
			return sqlSession.update("board.updateBasicBoardNoFile",board);
		}
	}
	@Override
	public int deleteBoard(int boardNo) {
		return sqlSession.delete("board.deleteBoard", boardNo);
	}
	
	
}
