package com.spring.board_fubao.controller;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Component

@Controller
public class FubaoBoardController {


	@RequestMapping(value="/index.fu")
	public ModelAndView index(ModelAndView mav) {
		
		mav.setViewName("board/home.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/join.fu")
	public ModelAndView login(ModelAndView mav) {
		
		mav.setViewName("member/join.tiles1");
		
		return mav;
	}
 

	@RequestMapping(value="/login.fu")
	public ModelAndView join(ModelAndView mav) {
		
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
