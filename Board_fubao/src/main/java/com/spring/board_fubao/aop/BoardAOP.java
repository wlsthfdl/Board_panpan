package com.spring.board_fubao.aop;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.spring.board_fubao.common.MyUtil;

@Aspect
@Component		//bean 등록
public class BoardAOP {

	//포인트컷
	@Pointcut("execution(public * com.spring..*Controller.requiredLogin_*(..) )") 
	public void requiredLogin() {}
	
	
	@Before("requiredLogin()")
	public void loginChk(JoinPoint joinpoint) {
	    HttpServletRequest request = null;
        HttpServletResponse response = null;

        for (Object arg : joinpoint.getArgs()) {
            if (arg instanceof HttpServletRequest) {
                request = (HttpServletRequest) arg;
            } else if (arg instanceof HttpServletResponse) {
                response = (HttpServletResponse) arg;
            }
        }

        if (request == null || response == null) {
            throw new IllegalStateException("HttpServletRequest and HttpServletResponse are required.");
        }

		HttpSession session = request.getSession();
		if(session.getAttribute("login_user")==null) {
			String message = "로그인 해주세요.";
			String loc = request.getContextPath()+"/login.fu";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			String url = MyUtil.getCurrentURL(request);
			
			session.setAttribute("goBackURL", url);
			System.out.println("goBackURL : " + url);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp"); 

			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
			
		}
		
		
	}
	
}
