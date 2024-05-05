package com.spring.board_fubao.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
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

import com.spring.board_fubao.common.FileManager;
import com.spring.board_fubao.common.Sha256;
import com.spring.board_fubao.model.BoardVO;
import com.spring.board_fubao.model.CategoryVO;
import com.spring.board_fubao.model.MemberVO;
import com.spring.board_fubao.service.InterBoardService;

@Component
@Controller
public class FubaoBoardController {


    @Autowired         
    private InterBoardService service;
    
    @Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
    private FileManager fileManager;
	   
    
	/*메인 페이지*/
	@RequestMapping(value="/index.fu")
	public ModelAndView index(ModelAndView mav, HttpServletRequest request) {
		List<CategoryVO> cate_list = service.get_category();

		System.out.println(cate_list);
		mav.addObject("cate_list", cate_list);
		mav.setViewName("board/home.tiles2");
		
		return mav;
	}

	
	
	//회원가입 페이지 띄우기
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
			mav.setViewName("board/home.tiles2");

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
	
	
	
	// '게시글쓰기'클릭시 불러올 페이지 요청
	@RequestMapping(value="/board_write.fu")
	public ModelAndView board_write(ModelAndView mav) {
		
		mav.setViewName("board/write.tiles2");
		
		return mav;
	}

	// 게시글쓰기 처리
	@RequestMapping(value="/write_end.fu", method={RequestMethod.POST})
	public ModelAndView write_end(ModelAndView mav, BoardVO boardvo) {
		
		int n = service.add(boardvo); 
		
		if(n==1) {  
			mav.setViewName("redirect:/board_write.fu");
		}
		else { 
			mav.setViewName("board/home.tiles2");
		}

		return mav;
		
	}
	

	//카테고리별로 게시판 불러오기

	@RequestMapping(value="/board_list.fu")
	public ModelAndView board_list(ModelAndView mav, HttpServletRequest request) {
		
		mav.setViewName("board/list.tiles2");
		
		return mav;
		
	}
	



   // ==== #스마트에디터. 드래그앤드롭을 사용한 다중사진 파일업로드 ====
   @RequestMapping(value="/image/multiplePhotoUpload.fu", method= {RequestMethod.POST} )
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
		// 절대경로
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources"+File.separator+"photo_upload";
		
		//	System.out.println("~~~~ 확인용 path => " + path);
		// ~~~~ 확인용  webapp 의 절대경로 => C:\NCS\workspace(spring)\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\photo_upload 
		
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		try {
			String filename = request.getHeader("file-name"); // 파일명(문자열)을 받는다 - 일반 원본파일명
			
			InputStream is = request.getInputStream(); // is는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일임.
			
			String newFilename = fileManager.doFileUpload(is, filename, path);
			
			int width = fileManager.getImageWidth(path+File.separator+newFilename);
			
		    if(width > 600) {
		       width = 600;
		    }
		    
			String ctxPath = request.getContextPath(); //  /board
			
			String strURL = "";
			strURL += "&bNewLine=true&sFileName="+newFilename; 
			strURL += "&sWidth="+width;
			strURL += "&sFileURL="+ctxPath+"/resources/photo_upload/"+newFilename;
			
			// === 웹브라우저 상에 사진 이미지를 쓰기 === //
			PrintWriter out = response.getWriter();
			out.print(strURL);
			
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		}

   
	
}
