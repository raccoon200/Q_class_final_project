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
import com.kh.ok.board.model.vo.Comment;
import com.kh.ok.member.model.vo.Member;

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
	public int selectBoardCount(int board_menu_no) {
		return boardDAO.selectBoardCount(board_menu_no);
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
	public List<Map<String, String>> selectBoardGroupList(BoardMenu boardMenu) {
		return boardDAO.selectBoardGroupList(boardMenu);
	}
	@Override
	public List<Map<String, String>> selectBoardBasicList(BoardMenu boardMenu) {
		return boardDAO.selectBoardBasicList(boardMenu);
	}
	@Override
	public int insertComment(Comment comment) {
		return boardDAO.insertComment(comment);
	}
	@Override
	public int deleteComment(int comment_no) {
		return boardDAO.deleteComment(comment_no);
	}
	@Override
	public List<Map<String, String>> selectCommentList(int boardNo) {
		return boardDAO.selectCommentList(boardNo);
	}
	@Override
	public List<Map<String, String>> selectBoardMenuManageList(Member m) {
		return boardDAO.selectBoardMenuManageList(m);
	}
	@Override
	public BoardMenu selectBoardMenu(int board_menu_no) {
		return boardDAO.selectBoardMenu(board_menu_no);
	}
	@Override
	public int deleteBoardMenu(int boardMenuNo) {
		return boardDAO.deleteBoardMenu(boardMenuNo);
	}
	@Override
	public List<Map<String, String>> selectDeptList(String com_no) {
		return boardDAO.selectDeptList(com_no);
	}
	@Override
	public List<Map<String, String>> selectBoardMenuMember(Member member) {
		return boardDAO.selectBoardMenuMember(member);
	}
	@Override
	public String selectComName(String com_no) {
		return boardDAO.selectComName(com_no);
	}
	@Override
	public List<Map<String, String>> selectBoardMemberList(int board_menu_no) {
		return boardDAO.selectBoardMemberList(board_menu_no);
	}
	@Override
	public int updateBoardMenu(BoardMenu boardMenu) {
		return boardDAO.updateBoardMenu(boardMenu);
	}
	@Override
	public List<Map<String, String>> selectListAdmin(String com_no) {
		return boardDAO.selectListAdmin(com_no);
	}
	@Override
	public int deleteAdmin(Member m) {
		return boardDAO.deleteAdmin(m);
	}
	@Override
	public List<Map<String, String>> selectAdmin(Member m) {
		return boardDAO.adminSelect(m);
	}
	@Override
	public int adminInsert(Member m ) {
		return boardDAO.adminInsert(m);
	}
	@Override
	public Member selectMember(String userId) {
		return boardDAO.selectMember(userId);
	}
	@Override
	public List<Member> selectListMember(String com_no) {
		return boardDAO.selectListMember(com_no);
	}
	@Override
	public List<Map<String, String>> memberCompanyListAll(String com_no) {
		return boardDAO.memberCompanyListAll(com_no);
	}

	
}
