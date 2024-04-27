package com.spring.board_fubao.service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board_fubao.common.AES256;
import com.spring.board_fubao.common.FileManager;
import com.spring.board_fubao.model.InterBoardDAO;
import com.spring.board_fubao.model.MemberVO;

@Service
public class BoardService implements InterBoardService{
	
	@Autowired  
	private InterBoardDAO dao;
	
	@Autowired
    private AES256 aes;   
	
    @Autowired     
    private FileManager fileManager;
	  
    
/*
	// 암호화
	private String encryptSHA256(String data) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedHash = digest.digest(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedHash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
	
	*/
    
    @Override
    public int insertMember(MemberVO membervo) {
    	int n = dao.insertMember(membervo);
    	return n;
    }
    
}
