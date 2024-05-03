<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   

<script type="text/javascript">

  $(document).ready(function(){
	  
	    //전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        }
	    });

		  // 글쓰기 버튼
		  $("button#btnWrite").click(function(){
			  
			  <%-- 스마트 에디터 구현 시작--%>
				// id 가 content인 textarea에 에디터 대입
				obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			  <%-- 스마트 에디터 구현 끝--%>

			// 글제목 유효성 검사
			const subject = $("input#subject").val().trim();
			if(subject == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
		<%-- 글내용 유효성 검사(스마트 에디터 사용 할 경우) 시작 --%>
			let content = $("textarea#content").val();
			
			//글내용 유효성 검사
			//alert(content);	//content에 내용을 쓰거나, 공백만 여러개 입력했을 경우 알아본 것
			/* <p>글내용입니다.</p>
				<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p> 
			*/
			
			//JS는 replaceAll이 없다. ==> 정규표현식
			content = content.replace(/&nbsp;/gi, "");	//공백을 ""로 바꾸는 것.
			/*    
	     	   대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	 	      ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                      그리고 뒤의 gi는 다음을 의미합니다.

			    g : 전체 모든 문자열을 변경 global
			    i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
			*/ 
			
			//alert(content);
	 	    //<p>     </p>
	 	    content = content.substring(content.indexOf("<p>")+3);
			content = content.substring(0, content.indexOf("</p>"));
				
			if(content.trim().length == 0) {
					alert("글내용을 입력하세요!!");
					return;
			}
	 	    
		<%-- 글내용 유효성 검사(스마트 에디터 사용 할 경우) 끝 --%>

			// 폼(form)을 전송(submit)
			const frm = document.addFrm;
			frm.method = "post";
			frm.action = "<%= ctxPath%>/addEnd.action";
			frm.submit();
		  });
		  
	    
	    
  });
	    
</script>

	
    <div id="content_area">
        <!-- left side -->
        <div id="left_container">
            <!-- 내 정보 -->
            <div id="user_info">
                <div class="my_info">나의 활동</div>
                <div class="my_profile">
                    <ul>
                    <li><img src="<%= ctxPath %>/resources/image/panda (1).png" width="45" height="45" class="ico-list"></li>
                    <li class="nickname">러부지는러브지</li>
                    <li><span class="date">가입일자</span></li>
                    </ul>
                </div>
                <div class="info_box">
                    <li class="b_write"><a href="" style="text-decoration: none; color: black;">내가 쓴 게시글</a></li>
                    <li class="b_comment"><a href="" style="text-decoration: none; color: black;">내가 쓴 댓글</a></li>
                </div>
                <div class="side_write_btn">
                    <div><a href="#" class="" onclick="">카페 글쓰기</a></div>
                </div>
            </div>

            <!-- 카테고리 -->
            <div id="category">
                <h3><span>GATE</span></h3>
                    <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list">가입인사</li>
                    <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list">공지사항</li>
                <h3><span>BAO News</span></h3>
                    <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list">바오패밀리 소식</li>
                    <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list">사육사와의 소통</li>
                <h3><span>Hey! Panda World</span></h3>
                    <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list">판다월드 관람/체험후기</li>
                <h3><span>BAO Talk</span></h3>
                    <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list">자유게시판</li>
                    <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list">꿀팁게시판</li>
                    <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list">질문게시판</li>
                <h3><span>동물자랑단</span></h3>
                    <li style="padding-bottom: 19px;"><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list">팬아트</li>
            </div>

        </div>
        <!-- end of left side -->



        <!-- main area -->
        <div id="main_area">
           <div class="board_viewbox">
           	<form name="write_frm" enctype="multipart/form-data">
                <div class="writing_header">
                    <h2>게시판 글쓰기</h2>
                    <div class="tool_area"><button>등록</button></div>
                </div>
                			 	
                <div class="writing_content">
                    <div class="editer_wrap">
                        <select name="select_cate" class="select_cate">
                            <option value="">게시판을 선택해 주세요</option>
                            <option value="가입인사">가입인사</option>
                            <option value="판다월드 관람/체험후기">판다월드 관람/체험후기</option>
                            <option value="자유게시판">자유게시판</option>
                            <option value="꿀팁게시판">꿀팁게시판</option>
                            <option value="질문게시판">질문게시판</option>
                            <option value="팬아트">팬아트</option>
                        </select>
                        <input placeholder="제목을 입력해 주세요." class="board_title">
                    </div>
                    <div id="smart_editor" class="smart_editor">
						<textarea style="width: 90%; height: 520px;" name="content" id="content"></textarea>						
                    </div>
                </div>
             </form>
           </div>
        </div>
        <!--main_area 끝-->

    </div>
    
    <!-- content area 끝 -->