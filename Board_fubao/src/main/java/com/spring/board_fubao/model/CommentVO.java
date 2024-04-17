package com.spring.board_fubao.model;

public class CommentVO {
	
	private int c_idx;			//댓글 번호
	private String id_fk;		//아이디
	private int b_idx_fk;		//글 번호
	private String nickname;	//닉네임
	private String c_content;	//댓글 내용
	private String c_date;		//댓글 작성 날짜
	private int c_status;		//댓글 삭제여부
	
	
	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}
	public String getId_fk() {
		return id_fk;
	}
	public void setId_fk(String id_fk) {
		this.id_fk = id_fk;
	}
	public int getB_idx_fk() {
		return b_idx_fk;
	}
	public void setB_idx_fk(int b_idx_fk) {
		this.b_idx_fk = b_idx_fk;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public String getC_date() {
		return c_date;
	}
	public void setC_date(String c_date) {
		this.c_date = c_date;
	}
	public int getC_status() {
		return c_status;
	}
	public void setC_status(int c_status) {
		this.c_status = c_status;
	}
	
	
	
}
