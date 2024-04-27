package com.spring.board_fubao.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
 
	/*회원가입  요청 처리 (insert)
	@RequestMapping(value="/join_complete.fu", method= {RequestMethod.POST})
	public ModelAndView register(MemberVO membervo, ModelAndView mav) {
		int n = service.insertMember(membervo);
		System.out.println(n);
		mav.setViewName("member/join_complete.tiles1");

		return mav;
	}*/
	
	@RequestMapping(value="/join_complete.fu", method = {RequestMethod.POST})
	public ModelAndView join_complete(MemberVO membervo, ModelAndView mav) {
		int n = service.insertMember(membervo);
		if(n==1) {
			mav.setViewName("member/join_complete.tiles1");
		}
		else {
			mav.setViewName("board/home.tiles1");

		}
		return mav;
	}
 

	@RequestMapping(value="/login.fu")
	public ModelAndView login(ModelAndView mav) {
		
		mav.setViewName("member/login.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/list.fu")
	public ModelAndView board_list(ModelAndView mav) {
		
		mav.setViewName("board/list.tiles1");
		
		return mav;
	}


	@RequestMapping(value="/view.fu")
	public ModelAndView board_view(ModelAndView mav) {
		
		mav.setViewName("board/view.tiles1");
		
		return mav;
	}

	
}
