package com.spring.board_fubao.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.spring.board_fubao.model.BoardVO;
import com.spring.board_fubao.model.CategoryVO;
import com.spring.board_fubao.model.CommentVO;
import com.spring.board_fubao.model.MemberVO;

public interface InterBoardService {

	//카테고리 리스트 가져오기
	List<CategoryVO> get_category(int category_idx);

	//회원가입 정보 insert
	int insertMember(MemberVO membervo);

	//ID 중복체크 Ajax
	int id_check(String id);

	//닉네임 중복체크 Ajax
	int nickname_check(String nickname);

	//비밀번호 암호화
	void encryptPassword(MemberVO membervo);

	//로그인 처리
	ModelAndView login_end(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap, HttpServletResponse response);

	//게시글쓰기 처리
	int write_end(BoardVO boardvo);

	//페이징 처리 안 한 게시글 목록 가져오기
	//List<BoardVO> get_boardList(HashMap<String, Object> paraMap);

	//게시글조회 (조회수 증가)
	BoardVO getView(Map<String, String> paraMap);

	//게시글 조회 (조회수 증가 없음)
	BoardVO getViewNoCnt(Map<String, String> paraMap);

	//모든 카테고리 조회
	List<CategoryVO> get_all_category(int role);

	//글 수정
	int edit(BoardVO boardvo);

	//글 삭제
	int del(String b_idx);

	//댓글쓰기
	int add_comment(CommentVO commentvo);
	
	//댓글쓰기 (첨부파일)
	int add_commentWithFile(CommentVO commentvo);

	//게시글에 달린 댓글보기
	List<CommentVO> get_commentList(String b_idx_fk);

	//게시글에 달린 댓글보기 (페이징처리)
	List<CommentVO> get_commentListPaging(Map<String, String> paraMap);
	
	// 원글 글번호에 해당하는 댓글의 totalPage 알아오기
	String getCommentTotalPage(Map<String, String> paraMap);

	//댓글작성후 최근 댓글띄우기 위해 c_cnt 가져오기
	int getC_cnt(String b_idx_fk);

	//카테고리 별 게시글 총 개수 구해오기 (board_list 페이징)
	int getTotalCnt(int category_idx);

	//페이징처리한 글목록 가져오기
	List<BoardVO> boardListPagination(HashMap<String, Object> paraMap);
	//페이징처리한 글목록 가져오기(인기글)
	List<BoardVO> boardListHitsPagination(HashMap<String, Object> paraMap);

	//좋아요 insert
	int boardLike(Map<String, String> paraMap);

	//좋아요 되어있는지 체크
	int checkLikeList(Map<String, String> paraMap);

	//좋아요 취소
	int boardLikeDelete(Map<String, String> paraMap);

	//좋아요 개수 띄우기(ajax)
	int boardLikeCnt(String b_idx_fk);

	//댓글 삭제
	int comment_del(Map<String, String> paraMap);

	

	
}
