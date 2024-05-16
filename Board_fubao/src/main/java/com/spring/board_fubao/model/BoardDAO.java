package com.spring.board_fubao.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	//ID 중복체크 Ajax
	@Override
	public int id_check(String id) {
		int n = sqlsession.selectOne("board.id_check", id);
		return n;	
	}

	//닉네임 중복체크 Ajax
	@Override
	public int nickname_check(String nickname) {
		int n = sqlsession.selectOne("board.nickname_check", nickname);
		return n;	
	}

	//로그인처리
	@Override
	public MemberVO get_login_member(Map<String, String> paraMap) {
		MemberVO login_user = sqlsession.selectOne("board.get_login_member", paraMap);		
		return login_user;
	}

	//게시글쓰기
	@Override
	public int write_end(BoardVO boardvo) {
		int n = sqlsession.insert("board.write_end", boardvo);
		return n;
	}

	//카테고리 리스트
	@Override
	public List<CategoryVO> get_category(int category_idx) {
		List<CategoryVO> cate_list = sqlsession.selectList("board.get_category", category_idx);
		return cate_list;
	} 
	
	//페이징처리 안한 게시글목록
	@Override
	public List<BoardVO> get_boardList(HashMap<String, Object> paraMap) {
		List<BoardVO> board_list = sqlsession.selectList("board.get_boardList", paraMap);
		return board_list;
	}

}
