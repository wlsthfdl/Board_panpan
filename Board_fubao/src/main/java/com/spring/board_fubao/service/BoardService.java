package com.spring.board_fubao.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board_fubao.common.AES256;
import com.spring.board_fubao.common.FileManager;
import com.spring.board_fubao.model.InterBoardDAO;

@Service
public class BoardService implements InterBoardService{
	
	@Autowired  
	private InterBoardDAO dao;
	
	@Autowired
    private AES256 aes;   
	
    @Autowired     
    private FileManager fileManager;
	   
	
}
