package test.remote.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import test.remote.board.dao.BoardDao;
import test.remote.board.domain.Board;
import test.remote.board.service.BoardService;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	BoardDao boardDao;

	@Override
	public List<Board> getBoardDetailList(String error_type, String sector, int offset, int listCount) {
		return boardDao.selectBoardAjaxList(error_type, sector, offset, listCount);
	}
	
	@Override
	public int getBoardListCount(String error_type, String sector) throws Exception {
		return boardDao.boardListCount(error_type, sector);
	}
	
	
}
