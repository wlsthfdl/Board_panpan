package com.spring.board_fubao.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board_fubao.common.Sha256;
import com.spring.board_fubao.model.MemberVO;
import com.spring.board_fubao.service.InterBoardService;

@Component
@Controller
public class FubaoBoardController {


    @Autowired         
    private InterBoardService service;
   
    
	/*메인 페이지*/
	@RequestMapping(value="/index.fu")
	public ModelAndView index(ModelAndView mav) {
		
		mav.setViewName("board/home.tiles1");
		
		return mav;
	}

	
	
	@RequestMapping(value="/join.fu")
	public ModelAndView join(ModelAndView mav) {
		
		mav.setViewName("member/join.tiles1");
		
		return mav;
	}
 
	
	// ID 중복 체크 Ajax
   @ResponseBody
   @RequestMapping(value = "/id_check.fu", method = {RequestMethod.POST})
   public String id_check(HttpServletRequest request, HttpServletResponse response) {
      String id = request.getParameter("id");
      int n = 0;
      try {
         n = service.id_check(id);
      } catch (Throwable e) {
            e.printStackTrace();
      }
      System.out.println(n);
      JSONObject jsonObj = new JSONObject();
      jsonObj.put("n", n);

      
      return jsonObj.toString();
      
   }
   
   // 닉네임 중복체크 Ajax
   @ResponseBody
   @RequestMapping(value = "/nickname_check.fu", method = {RequestMethod.POST})
   public String nickname_check(HttpServletRequest request, HttpServletResponse response) {
      String nickname = request.getParameter("nickname");
      int n = 0;
      try {
         n = service.nickname_check(nickname);
      } catch (Throwable e) {
            e.printStackTrace();
      }
      System.out.println(n);
      JSONObject jsonObj = new JSONObject();
      jsonObj.put("n", n);

      
      return jsonObj.toString();
      
   }

	
	
	// 회원가입  요청 처리 (insert)
	@RequestMapping(value="/join_complete.fu", method = {RequestMethod.POST})
	public ModelAndView join_complete(MemberVO membervo, ModelAndView mav) {
		service.encryptPassword(membervo);
		//비밀번호 암호화
		
		int n = service.insertMember(membervo);
		if(n==1) {
			mav.setViewName("member/join_complete.tiles1");
		}
		else {
			mav.setViewName("board/home.tiles1");

		}
		return mav;
	}
 
	
	// 로그인 폼페이지 요청 
	@RequestMapping(value="/login.fu")
	public ModelAndView login(ModelAndView mav) {
		
		mav.setViewName("member/login.tiles1");
		
		return mav;
	}
	
	
	//로그인 처리
	@RequestMapping(value="/login_end.fu", method= {RequestMethod.POST})
	public ModelAndView login_end(ModelAndView mav, HttpServletRequest request) {
		
		String id = request.getParameter("id");
	    String pwd = request.getParameter("pwd");

	    Map<String, String> paraMap = new HashMap<String, String>();
	    paraMap.put("id", id);
	    paraMap.put("pwd", Sha256.encrypt(pwd));

	    mav = service.login_end(mav, request, paraMap);		    		 
    
	    return mav;
	}
	
	//로그아웃 처리
	@RequestMapping(value="/logout.fu")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
	    if (session != null) {
	        session.invalidate();
	    }

		String message = "로그아웃 되었습니다.";
		String loc = request.getContextPath()+"/index.fu";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg"); 
		
		return mav;
	}
	
	@RequestMapping(value="/list.fu")
	public ModelAndView board_list(ModelAndView mav) {
		
		mav.setViewName("board/list.tiles1");
		
		return mav;
	}

/*
	@RequestMapping(value="/view.fu")
	public ModelAndView board_view(ModelAndView mav) {
		
		mav.setViewName("board/view.tiles1");
		
		return mav;
	}
*/

	@RequestMapping(value="/board_write.fu")
	public ModelAndView board_write(ModelAndView mav) {
		
		mav.setViewName("board/write.tiles1");
		
		return mav;
	}

	
}
