package test.remote.board.dao;

import java.util.List;

import test.remote.board.domain.Board;

public interface BoardDao {
	int boardListCount(String error_type, String sector);
	List<Board> selectBoardAjaxList(String error_type, String sector, int offset, int listCount);
}
 