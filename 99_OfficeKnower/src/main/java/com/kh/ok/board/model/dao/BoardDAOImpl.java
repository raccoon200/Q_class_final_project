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
import com.kh.ok.board.model.vo.BoardBookMark;
import com.kh.ok.board.model.vo.BoardGroup;
import com.kh.ok.board.model.vo.BoardMenu;
import com.kh.ok.board.model.vo.Comment;

@Repository
public class BoardDAOImpl implements BoardDAO{
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Override
	public List<Map<String, String>> selectBoardBasicList(int cPage, int numPerPage, int boardMenuNo) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("board.selectBoardBasicList" , boardMenuNo, rowBounds);
	}
	@Override
	public int selectBoardCount() {
		return sqlSession.selectOne("board.selectBoardCount");
	}
	@Override
	public int insertBasicBoard(Board board) {
		if(board.getOriginal_file_name() != null && board.getRenamed_file_name()!=null) {
			return sqlSession.insert("board.insertBasicBoard",board);
		}else {
			return sqlSession.insert("board.insertBasicBoardNoFile",board);
		}
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
	@Override
	public int insertBoardMenu(BoardMenu boardMenu) {
		return sqlSession.insert("board.insertBoardMenu", boardMenu);
	}
	@Override
	public int insertBoardGroup(BoardGroup boardGroup) {
		return sqlSession.insert("board.insertBoardGroup", boardGroup);
	}
	@Override
	public int importantApply(BoardBookMark bbm) {
		return sqlSession.insert("board.importantApply", bbm);
		//return 0;
	}
	@Override
	public int importantDelete(BoardBookMark bbm) {
		return sqlSession.delete("board.importantDelete",bbm);
		//return 0;
	}
	@Override
	public int increaseBoardCount(int boardNo) {
		return sqlSession.update("board.increaseBoardCount",boardNo);
	}
	@Override
	public int selectBoardBookMark(BoardBookMark bbm) {
		return sqlSession.selectOne("board.selectBoardBookMark", bbm);
	}
	@Override
	public List<Map<String, String>> selectBoardImportantList(int cPage, int numPerPage, String userId) {
		RowBounds bound = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("board.selectBoardImportantList", userId, bound);
	}
	@Override
	public int selectBoardImportantCount(String userId) {
		return sqlSession.selectOne("board.selectBoardImportantCount", userId);
	}
	@Override
	public List<Map<String, String>> selectBoardRecentList(String userId) {
		return sqlSession.selectList("board.selectBoardRecentList", userId);
	}
	@Override
	public List<Map<String, String>> selectBoardMenuList(String userId) {
		return sqlSession.selectList("board.selectBoardMenuList", userId);
	}
	@Override
	public List<Map<String, String>> selectBoardGroupList(String string) {
		return sqlSession.selectList("board.selectBoardGroupList", string);
	}
	@Override
	public List<Map<String, String>> selectBoardBasicList(String string) {
		return sqlSession.selectList("board.selectBoardBasicList_", string);
	}
	@Override
	public int insertComment(Comment comment) {
		return sqlSession.insert("board.insertComment", comment);
	}
	@Override
	public int deleteComment(int comment_no) {
		return sqlSession.delete("board.deleteComment", comment_no);
	}
	@Override
	public List<Map<String, String>> selectCommentList(int boardNo) {
		return sqlSession.selectList("board.selectCommentList", boardNo);
	}
	
	
}
