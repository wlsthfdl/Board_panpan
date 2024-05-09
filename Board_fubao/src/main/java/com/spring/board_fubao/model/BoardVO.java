package com.spring.board_fubao.model;

public class BoardVO {

	private int b_idx;				//글 번호
	private String id_fk;			//아이디
	private String nickname;		//닉네임
	private int category_idx_fk;	//카테고리번호
	private String b_title;			//글 제목
	private String b_content;		//글 내용
	private String b_date;			//글 등록일
	private int b_like;				//좋아요 개수
	private int b_hit;				//조회수
	private int b_status;			//글 삭제여부
	private int c_cnt;				//댓글 개수
	
	
	
	public int getB_idx() {
		return b_idx;
	}
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public String getId_fk() {
		return id_fk;
	}
	public void setId_fk(String id_fk) {
		this.id_fk = id_fk;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getCategory_idx_fk() {
		return category_idx_fk;
	}
	public void setCategory_idx_fk(int category_idx_fk) {
		this.category_idx_fk = category_idx_fk;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_date() {
		return b_date;
	}
	public void setB_date(String b_date) {
		this.b_date = b_date;
	}
	public int getB_like() {
		return b_like;
	}
	public void setB_like(int b_like) {
		this.b_like = b_like;
	}
	public int getB_hit() {
		return b_hit;
	}
	public void setB_hit(int b_hit) {
		this.b_hit = b_hit;
	}
	public int getB_status() {
		return b_status;
	}
	public void setB_status(int b_status) {
		this.b_status = b_status;
	}
	public int getC_cnt() {
		return c_cnt;
	}
	public void setC_cnt(int c_cnt) {
		this.c_cnt = c_cnt;
	}
	
}
