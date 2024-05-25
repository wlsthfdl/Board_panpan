package com.spring.board_fubao.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterBoardDAO {

	//회원가입 정보 insert
	int insertMember(MemberVO membervo);

	//ID 중복체크 Ajax
	int id_check(String id);

	//닉네임 중복체크 Ajax
	int nickname_check(String nickname);

	//로그인 처리
	MemberVO get_login_member(Map<String, String> paraMap);

	//게시글 쓰기
	int write_end(BoardVO boardvo);

	//카테고리 리스트
	List<CategoryVO> get_category(int category_idx);
	
	//페이징처리 안한 게시글목록
	List<BoardVO> get_boardList(HashMap<String, Object> paraMap);

	//게시글 한개 보기
	BoardVO getView(Map<String, String> paraMap);
	//게시글 조회수 증가
	void setAddReadCnt(int b_idx);

	//모든 카테고리 조회
	List<CategoryVO> get_all_category(int role);

	//글 수정하기
	int edit(BoardVO boardvo);

	//글 삭제하기
	int del(String b_idx);


}
