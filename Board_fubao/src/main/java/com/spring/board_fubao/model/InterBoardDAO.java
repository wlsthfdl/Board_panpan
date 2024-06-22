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
	//List<BoardVO> get_boardList(HashMap<String, Object> paraMap);

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

	//댓글쓰기
	int add_comment(CommentVO commentvo);

	//댓글쓰기 첨부파일
	int add_commentWithFile(CommentVO commentvo);
	
	//댓글쓰면 tbl_board의 c_cnt 1증가
	int update_c_cnt(int b_idx_fk);
	
	//게시글에 달린 댓글 리스트 조회
	List<CommentVO> get_commentList(String b_idx_fk);

	//게시글에 달린 댓글 리스트 조회 (페이징처리)
	List<CommentVO> get_commentListPaging(Map<String, String> paraMap);

	// 원글 글번호에 해당하는 댓글의 totalPage 알아오기
	int getCommentTotalPage(Map<String, String> paraMap);

	//댓글작성후 최근 댓글띄우기 위해 c_cnt 가져오기
	int getC_cnt(String b_idx_fk);
	
	//카테고리 별 게시글 총 개수 구해오기 (board_list 페이징)
	int getTotalCnt(int category_idx);

	//페이징처리 한 글 목록
	List<BoardVO> boardListPagination(HashMap<String, Object> paraMap);
	//페이징처리 한 글 목록(인기글)
	List<BoardVO> boardListHitsPagination(HashMap<String, Object> paraMap);

	//좋아요 기능
	int boardLike(Map<String, String> paraMap);

	//좋아요 되어있는지 체크
	int checkLikeList(Map<String, String> paraMap);

	//좋아요 취소
	int boardLikeDelete(Map<String, String> paraMap);

	//좋아요 개수(b_like 컬럼) 1증가
	int updateB_like(Map<String, String> paraMap);

	//좋아요 개수 1 감소
	int updateB_like_minus(Map<String, String> paraMap);

	//좋아요 개수 띄우기
	int boardLikeCnt(String b_idx_fk);

	//댓글 삭제
	int comment_del(Map<String, String> paraMap);

	//댓글 개수 감소
	int updateC_cnt(Map<String, String> paraMap);

	//메인페이지 인기글 조회
	List<BoardVO> boardListHitsMain();



}
