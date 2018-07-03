package com.kh.ok.board.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.ok.board.model.vo.Board;
import com.kh.ok.board.model.vo.BoardBookMark;
import com.kh.ok.board.model.vo.BoardGroup;
import com.kh.ok.board.model.vo.BoardMenu;
import com.kh.ok.board.model.vo.Comment;
import com.kh.ok.member.model.vo.Member;

public interface BoardDAO {

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

	List<Map<String, String>> selectBoardGroupList(BoardMenu boardMenu);

	List<Map<String, String>> selectBoardBasicList(BoardMenu boardMenu);

	int insertComment(Comment comment);

	int deleteComment(int comment_no);

	List<Map<String, String>> selectCommentList(int boardNo);

	List<Map<String, String>> selectBoardMenuManageList(Member m);

	BoardMenu selectBoardMenu(int board_menu_no);

	int deleteBoardMenu(int boardMenuNo);

	List<Map<String, String>> selectDeptList(String com_no);

	List<Map<String, String>> selectBoardMenuMember(Member member);

	String selectComName(String com_no);

	List<Map<String, String>> selectBoardMemberList(int board_menu_no);

	int updateBoardMenu(BoardMenu boardMenu);

	List<Map<String, String>> selectListAdmin(String com_no);

	int deleteAdmin(Member member);

	List<Map<String, String>> adminSelect(Member m);

	Member selectMember(String userId);

	int adminInsert(Member m);

	List<Member> selectListMember(String com_no);

	List<Map<String, String>> memberCompanyListAll(String com_no);
}
