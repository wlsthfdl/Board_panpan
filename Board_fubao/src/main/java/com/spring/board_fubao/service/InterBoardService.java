package com.spring.board_fubao.service;

import com.spring.board_fubao.model.MemberVO;

public interface InterBoardService {

	//회원가입 정보 insert
	int insertMember(MemberVO membervo);

	//ID 중복체크 Ajax
	int id_check(String id);

	//닉네임 중복체크 Ajax
	int nickname_check(String nickname);

	//비밀번호 암호화
	void encryptPassword(MemberVO membervo);

}
