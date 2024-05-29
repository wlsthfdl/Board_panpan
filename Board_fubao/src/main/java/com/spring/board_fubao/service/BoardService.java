package com.spring.board_fubao.service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board_fubao.common.AES256;
import com.spring.board_fubao.common.FileManager;
import com.spring.board_fubao.model.BoardVO;
import com.spring.board_fubao.model.CategoryVO;
import com.spring.board_fubao.model.CommentVO;
import com.spring.board_fubao.model.InterBoardDAO;
import com.spring.board_fubao.model.MemberVO;

import oracle.security.o3logon.b;

@Service
public class BoardService implements InterBoardService{
	
	@Autowired  
	private InterBoardDAO dao;
	
	@Autowired
    private AES256 aes;   
	
    @Autowired     
    private FileManager fileManager;
	  
    
    
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

	//글쓰기 완료
	@Override
	public int write_end(BoardVO boardvo) {
		int n = dao.write_end(boardvo);
		return n;
	}

	//카테고리 별 목록보기
	@Override
	public List<CategoryVO> get_category(int category_idx) {
		List<CategoryVO> cate_list = dao.get_category(category_idx);	//n은 0 또는 1
		return cate_list;
	}

	//페이징 처리 안한 글목록
	@Override
	public List<BoardVO> get_boardList(HashMap<String, Object> paraMap) {
		List<BoardVO> board_list = dao.get_boardList(paraMap);
		return board_list;
	}

	//게시글 조회 (조회수 증가)
	@Override
	public BoardVO getView(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap);
		
		String login_userId = paraMap.get("login_userId");

		if(login_userId != null && boardvo != null &&
			!login_userId.equals(boardvo.getId_fk())) {
			
			dao.setAddReadCnt(boardvo.getB_idx());
			boardvo = dao.getView(paraMap);
		}
		
		return boardvo;
	}
	
	//게시글 조회(조회수 증가 없음)
	@Override
	public BoardVO getViewNoCnt(Map<String, String> paraMap) {
		BoardVO boardvo = dao.getView(paraMap);
		return boardvo;
	}

	
	//모든 카테고리 조회 (파라미터없음)
	@Override
	public List<CategoryVO> get_all_category(int role) {
		List<CategoryVO> cate_list_all = dao.get_all_category(role);
		return cate_list_all;
	}

	
	//글 수정하기
	@Override
	public int edit(BoardVO boardvo) {
		int n = dao.edit(boardvo);
		return n;
	}

	//글 삭제하기
	@Override
	public int del(String b_idx) {
		int n = dao.del(b_idx);
		return n;
	}

	//댓글쓰기 (트랜잭션 처리)
	//tbl_board 테이블에 c_cnt 컬럼이 1 증가하여야 함 
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int add_comment(CommentVO commentvo) {
		int n = 0, result = 0;
		
		n = dao.add_comment(commentvo);	 	//댓글쓰기 insert
		
		if(n==1) {
			result = dao.update_c_cnt(commentvo.getB_idx_fk());
			//System.out.println("~~~~확인용: result " + result);
		}
		
		return result;
	}

	//댓글쓰기 첨부파일 (트랜잭션 처리)
	@Override
	public int add_commentWithFile(CommentVO commentvo) {
		int n = 0, result = 0;
		
		n = dao.add_commentWithFile(commentvo);	 	//댓글쓰기 insert
		
		if(n==1) {
			result = dao.update_c_cnt(commentvo.getB_idx_fk());
			//System.out.println("~~~~확인용: result " + result);
		}
		
		return result;
	}

	
	//게시글에 달린 댓글보기
	@Override
	public List<CommentVO> get_commentList(String b_idx_fk) {
		List<CommentVO> c_list = dao.get_commentList(b_idx_fk);
		return c_list;
	}

	//게시글에 달린 댓글보기 (첨부파일 및 페이징)
	@Override
	public List<CommentVO> get_commentListPaging(Map<String, String> paraMap) {
		List<CommentVO> c_list = dao.get_commentListPaging(paraMap);
		return c_list;
	}
	
	// 원글 글번호에 해당하는 댓글의 totalPage 알아오기
	@Override
	public String getCommentTotalPage(Map<String, String> paraMap) {
		int totalPage = dao.getCommentTotalPage(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalPage", totalPage);		//dao에서 int로 받아왔기 때문에 String으로 바꿔야함
		
		return jsonObj.toString();
	}

    
	
	
	
	
}
