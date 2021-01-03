package test.remote.board.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import test.remote.board.dao.BoardDao;
import test.remote.board.domain.Board;

@Repository
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private SqlSessionTemplate sqlTemplate;

	public List<Board> selectBoardAjaxList(String error_type, String sector, int offset, int listCount) {
		Map<String, Object> params = new HashMap<>();
		params.put("error_type", error_type);
		params.put("sector", sector);
		params.put("offset", offset);
		params.put("listCount", listCount);
		
		return sqlTemplate.selectList("selectBoardAjaxList", params);
	}
	
	@Override
	public int boardListCount(String error_type, String sector) {
		Map<String, Object> params = new HashMap<>();
		params.put("error_type", error_type);
		params.put("sector", sector);
		return sqlTemplate.selectOne("selectBoardListCount", params);
	}
}
