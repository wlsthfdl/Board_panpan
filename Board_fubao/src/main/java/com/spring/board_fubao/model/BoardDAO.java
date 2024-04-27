package com.spring.board_fubao.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO implements InterBoardDAO{

	@Resource
	private SqlSessionTemplate sqlsession;

	//============================================//
	
	//회원가입 정보 insert
	@Override
	public int insertMember(MemberVO membervo) {
		int n = sqlsession.insert("board.insertMember", membervo);
		return n;
	}  
}
