package com.spring.board_fubao.model;

import java.util.List;
import java.util.Map;

public interface InterBoardDAO {

	//카테고리 리스트
	List<CategoryVO> get_category();
	
	//회원가입 정보 insert
	int insertMember(MemberVO membervo);

	//ID 중복체크 Ajax
	int id_check(String id);

	//닉네임 중복체크 Ajax
	int nickname_check(String nickname);

	//로그인 처리
	MemberVO get_login_member(Map<String, String> paraMap);


}
