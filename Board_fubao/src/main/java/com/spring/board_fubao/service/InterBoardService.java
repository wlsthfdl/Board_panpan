package com.spring.board_fubao.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.spring.board_fubao.model.CategoryVO;
import com.spring.board_fubao.model.MemberVO;

public interface InterBoardService {

	//카테고리 리스트 가져오기
	List<CategoryVO> get_category();

	//회원가입 정보 insert
	int insertMember(MemberVO membervo);

	//ID 중복체크 Ajax
	int id_check(String id);

	//닉네임 중복체크 Ajax
	int nickname_check(String nickname);

	//비밀번호 암호화
	void encryptPassword(MemberVO membervo);

	//로그인 처리
	ModelAndView login_end(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap);

}
