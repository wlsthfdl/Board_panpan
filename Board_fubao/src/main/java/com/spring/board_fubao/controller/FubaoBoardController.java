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
		
		mav.setViewName("board/main.tiles1");
		//   /WEB-INF/views/main/index.jsp 파일을 생성한다.
		
		return mav;
	}
	   
	@RequestMapping(value="/login.fu")
	public ModelAndView login_form(ModelAndView mav) {
		
		mav.setViewName("member/login.tiles1");
		//   /WEB-INF/views/main/index.jsp 파일을 생성한다.
		
		return mav;
	}
 
	@RequestMapping(value="/list.fu")
	public ModelAndView board_list(ModelAndView mav) {
		
		mav.setViewName("board/list.tiles1");
		//   /WEB-INF/views/main/index.jsp 파일을 생성한다.
		
		return mav;
	}

	
	
}
