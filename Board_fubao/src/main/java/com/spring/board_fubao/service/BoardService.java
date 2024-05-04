package com.spring.board_fubao.service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board_fubao.common.AES256;
import com.spring.board_fubao.common.FileManager;
import com.spring.board_fubao.model.CategoryVO;
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
	  
    

    //카테고리 리스트
	@Override
	public List<CategoryVO> get_category() {
		List<CategoryVO> cate_list = dao.get_category();
		return cate_list;
	}
    
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

	//비밀번호 암호화
	@Override
	public void encryptPassword(MemberVO membervo) {
		String password = membervo.getPwd();
        // 비밀번호 암호화
        String encryptedPassword = encryptSHA256(password);
        membervo.setPwd(encryptedPassword);
	}
	
   
    // 회원가입 요청처리 insert
    @Override
    public int insertMember(MemberVO membervo) {
    	int n = dao.insertMember(membervo);
    	return n;
    }

    // ID 중복체크 Ajax
	@Override
	public int id_check(String id) {
		int n = dao.id_check(id);	//n은 0 또는 1
		return n;
	}
	
    // 닉네임 중복체크 Ajax
	@Override
	public int nickname_check(String nickname) {
		int n = dao.nickname_check(nickname);	//n은 0 또는 1
		return n;
	}

	// 로그인처리
	@Override
	public ModelAndView login_end(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {
		MemberVO login_user = dao.get_login_member(paraMap);

		if(login_user == null) {	//로그인 실패시
			String message = "아이디 또는 암호가 일치하지 않습니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message", message);
			mav.addObject("loc", loc);					
			
			mav.setViewName("msg");
		}else { //아이디와 암호 존재하는 경우
			if(login_user.getStatus() != 1) {	//탈퇴 회원일 경우
				String message = "탈퇴한 회원입니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
				return mav;
			}else {		//탈퇴한 회원이 아닐 경우
				HttpSession session = request.getSession();
				
				session.setAttribute("login_user", login_user);

				String goBackURL = (String) session.getAttribute("goBackURL");
				
				if(goBackURL != null) {
					mav.setViewName("redirect:"+goBackURL);
					session.removeAttribute("goBackURL"); // 세션에서 제거
				}
				else {
					mav.setViewName("redirect:/index.fu");
				}
			}
		}
		return mav;
	}


    
}
