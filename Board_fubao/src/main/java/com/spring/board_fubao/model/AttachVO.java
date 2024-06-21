package com.spring.board_fubao.model;

public class AttachVO {
	private int file_idx;
	private int b_idx_fk;
	private String org_file_name;	//원본 파일이름
	private String save_file_name;	//저장된 파일이름
	private int file_size;			//파일 사이즈
	
	
	
	public int getFile_idx() {
		return file_idx;
	}
	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
	}
	public int getB_idx_fk() {
		return b_idx_fk;
	}
	public void setB_idx_fk(int b_idx_fk) {
		this.b_idx_fk = b_idx_fk;
	}
	public String getOrg_file_name() {
		return org_file_name;
	}
	public void setOrg_file_name(String org_file_name) {
		this.org_file_name = org_file_name;
	}
	public String getSave_file_name() {
		return save_file_name;
	}
	public void setSave_file_name(String save_file_name) {
		this.save_file_name = save_file_name;
	}
	public int getFile_size() {
		return file_size;
	}
	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}
	
}
