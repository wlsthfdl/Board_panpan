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
		  $("button#btn_write").click(function(){
			  
			  <%-- 스마트 에디터 구현 시작--%>
				// id 가 content인 textarea에 에디터 대입
				obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			  <%-- 스마트 에디터 구현 끝--%>

			//카테고리 선택 유효성 검사
			const category = $('.select_cate').val();
			if(!category){
				alert("카테고리를 선택해주세요.");
				$('.select_cate').focus();
				return false;
			}
			  
			  
			// 글제목 유효성 검사
			const subject = $("input#subject").val().trim();
			if(subject == "") {
				alert("글제목을 입력하세요.");
				return;
			}
			
			// 글내용 유효성 검사
			let content = $("textarea#content").val();
			content = content.replace(/&nbsp;/gi, "");	//공백을 ""로 바꾸는 것.
			
	 	    content = content.substring(content.indexOf("<p>")+3);
			content = content.substring(0, content.indexOf("</p>"));
				
			if(content.trim().length == 0) {
					alert("글내용을 입력하세요.");
					return;
			}
			

			// 폼(form)을 전송(submit)
			const frm = document.edit_frm;
			frm.method = "post";
			frm.action = "<%= ctxPath%>/edit_end.fu";
			frm.submit();
		  });	
		  //글쓰기 버튼 끝-----------------------------------
		  
	    
	    
  });
	    
</script>

        <!-- main area -->
        <div id="main_area">
           <div class="board_viewbox" style="margin:0 auto; height: 1190px;">
           	<form name="edit_frm" enctype="multipart/form-data">
           		<input type="hidden" name="id_fk" value="${sessionScope.login_user.id}" />
				<input type="hidden" name="nickname" value="${sessionScope.login_user.nickname}"  />
				<input type="hidden" name="b_idx" value="${requestScope.boardvo.b_idx}"/>
                <div class="writing_header">
                    <h2>게시판 글쓰기</h2>
                    <div class="tool_area"><button type="button" id="btn_write">수정</button></div>
                </div>
                <div class="writing_content">
                    <div class="editer_wrap">
                        <select name="category_idx_fk" class="select_cate">
	                          <c:forEach var="categoryvo" items="${requestScope.cate_list}">
	                       			 <c:forEach var="catevo" items="${requestScope.cate_list_all}">
			                         	<option value="${catevo.category_idx}" <c:if test="${categoryvo.category_idx == catevo.category_idx}">selected="selected"</c:if>>${catevo.category_name}</option>
		                          	 </c:forEach>
                       		</c:forEach>
                        </select>
                        <input id="subject" name="b_title" class="board_title" value="${requestScope.boardvo.b_title}">
                    </div>
                    <div id="smart_editor" class="smart_editor">
						<textarea style="width:98%; height: 650px;" name="b_content" id="content">${requestScope.boardvo.b_content}</textarea>						
                    </div>
                </div>
             </form>
           </div>
        </div>
        <!--main_area 끝-->

    </div>
    
    <!-- content area 끝 -->