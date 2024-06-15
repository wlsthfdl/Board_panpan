package com.spring.board_fubao.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.dsig.keyinfo.RetrievalMethod;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board_fubao.common.MyUtil;
import com.spring.board_fubao.model.CommentVO;
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
	public ModelAndView login(ModelAndView mav, HttpServletRequest request) {
		String referer = request.getHeader("Referer");
				
		if(referer != null && !referer.isEmpty()) {
	        request.getSession().setAttribute("redirectUrl", referer);
		}

		mav.setViewName("member/login.tiles1");
		
		return mav;
	}
	
	
	//로그인 처리
	@RequestMapping(value="/login_end.fu", method= {RequestMethod.POST})
	public ModelAndView login_end(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
	    String pwd = request.getParameter("pwd");

	    Map<String, String> paraMap = new HashMap<String, String>();
	    paraMap.put("id", id);
	    paraMap.put("pwd", Sha256.encrypt(pwd));

	    mav = service.login_end(mav, request, paraMap, response);		    		 
    
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
	public ModelAndView requiredLogin_board_write(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		HttpSession session = request.getSession();
		
		MemberVO login_user = (MemberVO) session.getAttribute("login_user");
		
		if(login_user != null) {
			int role = login_user.getRole();
	
			System.out.println(role);
		   //카테고리 조회해오기
		   List<CategoryVO> cate_list_all = service.get_all_category(role);
		   
		   System.out.println(cate_list_all);
		   mav.addObject("cate_list_all", cate_list_all);
		}
		   mav.setViewName("board/write.tiles2");
		   
	   return mav;
	}

	// 게시글쓰기 처리
	@RequestMapping(value="/write_end.fu", method={RequestMethod.POST})
	public ModelAndView write_end(ModelAndView mav, BoardVO boardvo, HttpServletRequest request, HttpServletResponse response) {
		String category_idx = request.getParameter("category_idx_fk");

		int n = service.write_end(boardvo); 
		
		if(n==1) {  
			mav.addObject("category_idx", category_idx);
			mav.setViewName("redirect:/board_list.fu");
		}
		else { 
			mav.setViewName("board/home.tiles2");
		}

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

			System.out.println(">>>> 확인용 width ==> " + width);
			 // >>>> 확인용 width ==> 600
			 // >>>> 확인용 width ==> 121
				
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


	//게시판 목록 별 불러오기
	@RequestMapping(value="/board_list.fu")
	public ModelAndView board_list(ModelAndView mav, HttpServletRequest request) {
		String category_param = request.getParameter("category_idx");
		List<BoardVO> board_list = null;
		
        try {
            int category_idx = Integer.parseInt(category_param);

			//조회수 증가를 위한 것. F5를 눌렀을 때는 조회수 증가를 막아야함
	        HttpSession session = request.getSession();
	        session.setAttribute("readCountPermission", "yes");
			
			//카테고리 가져오기
			List<CategoryVO> cate_list = service.get_category(category_idx);

			/* list pagination (카테고리 별) */
			String str_currentShowPageNo = request.getParameter("currentShowPageNo");
			
			int totalCnt = 0;			//총 게시물 건수
			int currentShowPageNo = 0;		//현재 페이지 번호
			int startRno = 0;		//시작 행번호	 ex)11
			int endRno = 0;			//끝 행번호		 ex)20
			int totalPage = 0;		//총 페이지 수
			int sizePerPage = 20;	//페이지 당 보여줄 게시물 건수
			
			totalCnt = service.getTotalCnt(category_idx);
			
			totalPage = (int)Math.ceil((double)totalCnt/sizePerPage);

            if(str_currentShowPageNo == null) {
               currentShowPageNo = 1;
            }else {
               try {
                  currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
                  if(currentShowPageNo < 1 || currentShowPageNo > totalPage ) {
                     currentShowPageNo = 1;
                  }
                  
               } catch(NumberFormatException e){
                  currentShowPageNo = 1;
               }
            }
            
            startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
            endRno = startRno + sizePerPage - 1;
            
            
	        HashMap<String, Object> paraMap = new HashMap<>();

            paraMap.put("startRno", String.valueOf(startRno));
            paraMap.put("endRno", String.valueOf(endRno));
			//게시날짜가 오늘이면 시간으로 보여주고, 지난 날짜면 날짜를 보여준다.
            Date sysdate = new Date();
			paraMap.put("sysdate", sysdate);
			paraMap.put("category_idx", category_idx);

			board_list = service.boardListPagination(paraMap);
			//board_list = service.get_boardList(paraMap);

			// == 페이지바 만들기 == //
			int blockSize = 5;
			int loop = 1;
			int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
			
			String pageBar = "<ul style='list-style: none;'>";
			String url = "board_list.fu";
			
            //[이전]
			if(pageNo != 1) {
	               pageBar += "<li><a class='arrow prev' href='"+url+"?category_idx="+category_idx+"&currentShowPageNo="+(pageNo-1)+"'></a></li>";
	        }

            while( !(loop > blockSize || pageNo > totalPage) ) {
               
               if(pageNo == currentShowPageNo) {
                  pageBar += "<li><a class='active'>"+pageNo+"</a></li>";  
               }
               else {
                  pageBar += "<li><a href='"+url+"?category_idx="+category_idx+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
               }
               
               loop++;
               pageNo++;
               
            }
           
            //[다음]
            if( pageNo <= totalPage ) {
               pageBar += "<li><a class='arrow next' href='"+url+"?category_idx="+category_idx+"&currentShowPageNo="+pageNo+"'></a></li>";
            }
            pageBar += "</ul>";
			mav.addObject("pageBar", pageBar);
			/* list pagination (카테고리 별) 끝 */
			
            String goBackURL = MyUtil.getCurrentURL(request); 
            mav.addObject("goBackURL",goBackURL.replaceAll("&", " "));			
			
            mav.addObject("cate_list",cate_list);
			mav.addObject("board_list",board_list);
			mav.setViewName("board/list.tiles2");
        } catch (NumberFormatException e) {
            
        }
		return mav;
		
	}
	
	

   // 게시글 한 개 보기 페이지 요청
   @RequestMapping(value="/board_view.fu")
   public ModelAndView board_view(ModelAndView mav, HttpServletRequest request, HttpServletResponse response, CategoryVO catevo) {
	   String b_idx = request.getParameter("b_idx");
	   String goBackURL = request.getParameter("goBackURL");
	   String category_idx = request.getParameter("category_idx_fk");
	   
	   //카테고리 번호
	   List<CategoryVO> cate_list = service.get_category(Integer.parseInt(category_idx));
	   
	   if(goBackURL != null && goBackURL.contains(" ")) {
		   goBackURL = goBackURL.replaceAll(" ", "&");
	   }
	   
	   mav.addObject("goBackURL",goBackURL);
	   
	   try {
		   Integer.parseInt(b_idx);
		   mav.addObject("b_idx",b_idx);	//이전글 다음글 보기

		   HttpSession session = request.getSession();

		   
		   MemberVO login_user = (MemberVO) session.getAttribute("login_user");
		   //로그인시 세션에 저장되어있는 유저
		   
		   String login_userId = null;	//로그아웃 상태에서도 글 조회를 할 수 있다. 조회수 증가.
		   if(login_user != null) {
			   login_userId = login_user.getId();
		   }
		   
		   Map<String, String> paraMap = new HashMap<>();
		   paraMap.put("b_idx", b_idx);
		   paraMap.put("login_userId",login_userId);
		   paraMap.put("category_idx", category_idx);
		   
		   BoardVO boardvo = null;

		   if("yes".equals(session.getAttribute("readCountPermission")) ) {
			//글 조회수 증가와 함께 조회해오기
			   boardvo = service.getView(paraMap);
			   
			   session.removeAttribute("readCountPermission");
		   }else {
			 // F5로 새로고침 한 경우
			   
			   boardvo = service.getViewNoCnt(paraMap);
			   
		   }
		   
		   mav.addObject("boardvo", boardvo);
		   
	   } catch (NumberFormatException e) {
		   //무응답
	   }
	   mav.addObject("cate_list", cate_list);
	   mav.setViewName("board/view.tiles2");
		
		return mav;
   }
   
   

   // '다음글' '이전글'을 클릭하면 조회수를 올려주기 위해 이름만 view_2로 해준담에 다시 view로 넘겨준다.
   @RequestMapping(value="/board_view_2.fu")
   public ModelAndView board_view_2(ModelAndView mav, HttpServletRequest request) {
	   String b_idx = request.getParameter("b_idx");
	   String goBackURL = request.getParameter("goBackURL");
	   String category_idx = request.getParameter("category_idx_fk");


	   HttpSession session = request.getSession();
	   session.setAttribute("readCountPermission", "yes");
	   
	   //  redirect:/ 를 할때 한글데이터는 한글이 ? 처럼 깨지므로 아래와 같이 한글깨짐을 방지해주어야 한다.
	   try {
		   goBackURL = URLEncoder.encode(goBackURL, "UTF-8");
		  
	   } catch (UnsupportedEncodingException e) {
			e.printStackTrace();
	   }
	   
	   mav.setViewName("redirect:/board_view.fu?b_idx="+ b_idx + "&category_idx_fk=" + category_idx + "&goBackURL=" + goBackURL);
	   
	   return mav;
   
   }

	
	
   
   //본인 글 수정하기
   @RequestMapping(value="/board_edit.fu")
   public ModelAndView board_edit(ModelAndView mav, HttpServletRequest request, CategoryVO catevo) {
	   String b_idx = request.getParameter("b_idx");
	   String category_idx = request.getParameter("category_idx");
	   
	   Map<String, String> paraMap = new HashMap<>();
	   paraMap.put("b_idx", b_idx);
	   paraMap.put("category_idx", category_idx);
	   
	   BoardVO boardvo = service.getViewNoCnt(paraMap);
	   
	   //전체 카테고리 조회해오기
	   HttpSession session = request.getSession();
	   MemberVO login_user = (MemberVO) session.getAttribute("login_user");
	   int role = login_user.getRole();
	   List<CategoryVO> cate_list_all = service.get_all_category(role);
	   
	   //카테고리 이름 조회해오기 위한 것
	   List<CategoryVO> cate_list = service.get_category(Integer.parseInt(category_idx));

	   mav.addObject("cate_list", cate_list);		//board category_idx_fk에 맞는 category_name을 찾아오기 위함
	   mav.addObject("cate_list_all",cate_list_all);		//모든 카테고리 내용을 보여주기 위함
	   mav.addObject("boardvo", boardvo);
	   mav.setViewName("board/edit.tiles2");
	   
	   return mav;
   }
   
   //게시글 수정
   @RequestMapping(value="/edit_end.fu", method = {RequestMethod.POST} )
   public ModelAndView edit_end(ModelAndView mav, BoardVO boardvo, HttpServletRequest request) {
	
	   int n = service.edit(boardvo);

	   if(n==0) {
		   mav.addObject("message","글 수정 실패.");	
		   mav.addObject("loc","javascipt:history.back()");	
	   }else {
		   mav.addObject("message","수정 되었습니다.");	
		   mav.addObject("loc", request.getContextPath()+"/board_view.fu?b_idx=" + boardvo.getB_idx() + "&category_idx_fk=" + boardvo.getCategory_idx_fk());	
	   }
	   mav.setViewName("msg");

	   return mav;
   }

   //게시글 삭제 
   @RequestMapping(value="/board_delete.fu", method = {RequestMethod.POST} )
   public ModelAndView board_delete(ModelAndView mav, HttpServletRequest request) {
	   
	   String b_idx = request.getParameter("b_idx");
	   System.out.println(b_idx);
	   int n = service.del(b_idx);
	   
	   String category_idx = request.getParameter("category_idx");
	   
	   if(n==0) {
		   mav.addObject("message","글 삭제 실패");	
		   mav.addObject("loc","javascipt:history.back()");	
	   }else {
		   mav.addObject("message","삭제 되었습니다.");	
		   mav.addObject("loc", request.getContextPath()+"/board_list.fu?category_idx=" + category_idx);	
	   }
	   mav.setViewName("msg");

	   return mav;
   }
   
   @RequestMapping(value="/requiredLogin_comment.fu")
	public ModelAndView requiredLogin_comment(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
	   String b_idx = request.getParameter("b_idx");
	   String goBackURL = request.getParameter("goBackURL");
	   String category_idx = request.getParameter("category_idx_fk");
	   
	   System.out.println("goBackURL" + goBackURL);
	   
	   mav.addObject("b_idx", b_idx);
	   mav.addObject("goBackURL", goBackURL);
	   mav.addObject("category_idx", category_idx);
	   
	   mav.setViewName("board/view.tiles2");
	   return mav;
	}
   
   
   
   // 댓글쓰기 ajax (첨부파일 없음)
   @ResponseBody
   @RequestMapping(value="/add_comment.fu", method = {RequestMethod.POST}, produces="text/plain;charset=UTF-8" )
   public String add_comment(CommentVO commentvo, HttpServletRequest request) {
	   //댓글쓰기에 첨부파일이 없는 경우
	   int n = 0;
	   try {
		   n = service.add_comment(commentvo);

		   // 댓글쓰기(insert) 및 원게시물(tbl_board 테이블)에 댓글의 개수 증가(update 1씩 증가)하기 
		   
	   } catch (Throwable e) {
		   e.printStackTrace();
	   }
	   
	   String b_idx_fk = request.getParameter("b_idx_fk");
	   int c_cnt = service.getC_cnt(b_idx_fk);
	   
	   
	   JSONObject jsonObj = new JSONObject();
	   jsonObj.put("n", n);
	   jsonObj.put("nickname", commentvo.getNickname());
	   jsonObj.put("c_cnt", c_cnt);
	   
	   return jsonObj.toString();
	   
   }
   
  
   
   // 게시글에 달린 댓글 조회해오기
   @ResponseBody		//바로 웹브라우저에 찍어준다.
   @RequestMapping(value="/read_comment.fu", method = {RequestMethod.GET}, produces="text/plain;charset=UTF-8" )
   public String read_comment(HttpServletRequest request) {
	   String b_idx_fk = request.getParameter("b_idx_fk");
	   List<CommentVO> c_list = service.get_commentList(b_idx_fk);
	   
	   JSONArray jsonArr = new JSONArray();
	   
	   if(c_list != null) {
		   for(CommentVO cmtvo : c_list) {
			   JSONObject jsonObj = new JSONObject();
			   jsonObj.put("nickname", cmtvo.getNickname());
			   jsonObj.put("c_content", cmtvo.getC_content());
			   jsonObj.put("c_date", cmtvo.getC_date());
			   
			   jsonArr.put(jsonObj);
		   }
	   }
	   
	   return jsonArr.toString();
   }
   
   
   // 댓글쓰기 첨부파일 있음
   @ResponseBody
   @RequestMapping(value="/add_comment_withAttach.fu", method = {RequestMethod.POST}, produces="application/json;charset=UTF-8")
   public String addComment_withAttach(CommentVO commentvo, MultipartHttpServletRequest mrequest, HttpServletRequest request) {
	  
	      MultipartFile attach = commentvo.getAttach();
	      
	      if( !attach.isEmpty() ) {
	    	  
	         HttpSession session = mrequest.getSession();

	         //String root = session.getServletContext().getRealPath("/").substring(0, 3);
	         String root = session.getServletContext().getRealPath("/");

	         String path_whole = root+"resources"+File.separator+"files";

	  	     /*String path_whole = root + "Users"+File.separator+"user"+File.separator+"git"+File.separator+"Board_fubao"+File.separator+"Board_fubao"
	  	    		 			+File.separator+"src"+File.separator+"main"+File.separator+"webapp"+File.separator+"resources"+File.separator+"image"+File.separator+"comment_upload";
	  	      */
	         //System.out.println("~~~~ 확인용  path_whole => " + path_whole);	      
	       
	         String new_fileName = "";
	         // WAS(톰캣)의 디스크에 저장될 파일명 
	         
	         byte[] bytes = null;
	         long fileSize = 0;
	         
	         try {
	            bytes = attach.getBytes();
	            // 첨부파일의 내용물을 읽어오는 것
	            
	            String originalFilename = attach.getOriginalFilename();
	            //System.out.println("~~~~ 확인용 originalFilename => " + originalFilename);
	            
	            new_fileName = fileManager.doFileUpload(bytes, originalFilename, path_whole);
	            //System.out.println(">>> 확인용 newFileName => " + new_fileName);
	     
	            commentvo.setFile_name(new_fileName);
	            
	            commentvo.setOrg_file_name(originalFilename);
	            
	            fileSize = attach.getSize(); 
	            commentvo.setFile_size(String.valueOf(fileSize));
	            
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	         
	      }
	   
	   int n = 0;
	   try {
		   n = service.add_commentWithFile(commentvo);
	   } catch (Throwable e) {
		   e.printStackTrace();
	   }

	   String b_idx_fk = request.getParameter("b_idx_fk");
	   int c_cnt = service.getC_cnt(b_idx_fk);
	   
	   JSONObject jsonObj = new JSONObject();
	   jsonObj.put("n", n);
	   jsonObj.put("nickname", commentvo.getNickname());
	   jsonObj.put("c_cnt", c_cnt);
	   

	   
	   return jsonObj.toString();
   }
   
   
   
   // === #128. 원게시글에 딸린 댓글들을 페이징 처리해서 조회해오기 (Ajax) ===
   @ResponseBody
   @RequestMapping(value="/comment_pagination.fu", method = {RequestMethod.GET}, produces="application/json;charset=UTF-8")
   public String commentList(HttpServletRequest request) {
	   
	   String b_idx_fk = request.getParameter("b_idx_fk");
	   String currentShowPageNo = request.getParameter("currentShowPageNo");
	   
	   
	   if(currentShowPageNo == null) {
		   currentShowPageNo = "1";
	   }
	   
	   int sizePerPage = 30;			//페이지당 30개 댓글만
	   int startRno = ((Integer.parseInt(currentShowPageNo) - 1) * sizePerPage) + 1;
	   int endRno = startRno + sizePerPage - 1;
	   
	   Map<String, String> paraMap = new HashMap<>();
	   paraMap.put("b_idx_fk",b_idx_fk);
	   paraMap.put("startRno",String.valueOf(startRno));
	   paraMap.put("endRno",String.valueOf(endRno));
	   
	   List<CommentVO> commentList = service.get_commentListPaging(paraMap);
	   
	   JSONArray jsonArr = new JSONArray();
	   
	   if(commentList != null) {
		   for( CommentVO cmtvo : commentList) {
			   JSONObject jsonObj = new JSONObject();
			   jsonObj.put("nickname", cmtvo.getNickname());
			   jsonObj.put("c_content", cmtvo.getC_content());
			   jsonObj.put("c_date", cmtvo.getC_date());
			   jsonObj.put("c_idx", cmtvo.getC_idx());

			   // === 댓글읽어오기에 첨부파일 기능을 넣은 경우 시작 ===
			   jsonObj.put("file_name", cmtvo.getFile_name());
			   jsonObj.put("org_file_name", cmtvo.getOrg_file_name());
			   jsonObj.put("file_size", cmtvo.getFile_size());

			   // === 댓글읽어오기에 첨부파일 기능을 넣은 경우 끝 ===
			   jsonArr.put(jsonObj);
		   } //end of for ----------------------------
	   }
	   
	   return jsonArr.toString();
   }
   

   	//댓글 페이징 위한 원글의 댓글 총 개수 알아오기
	@ResponseBody
	@RequestMapping(value="/getCommentTotalPage.fu", method= {RequestMethod.GET})   
	public String getCommentTotalPage(HttpServletRequest request) {
		
		String b_idx_fk = request.getParameter("b_idx_fk");
		String sizePerPage = request.getParameter("sizePerPage");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("b_idx_fk", b_idx_fk);
		paraMap.put("sizePerPage", sizePerPage);
		
		// 원글 글번호에 해당하는 댓글의 totalPage 알아오기
		String totalPage = service.getCommentTotalPage(paraMap);
		return totalPage;
	}
	
   
	
   
}
