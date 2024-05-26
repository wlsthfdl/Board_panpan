<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
 
<%
    String ctxPath = request.getContextPath();

%>   

<script type="text/javascript">

	$(document).ready(function(){
		
		read_comment();
		
	    //이미지 파일 선택시 이미지 띄워주기
		$(document).on("change", "input#c_attach", function(e){
  			
			$(".comment_inbox").css({"height":"140px"});
			
			$("#previewImg").css({"width":"60px", "height":"45px"});
			
			const input_file = $(e.target).get(0);
			
	        const fileReader = new FileReader();
	         
	        fileReader.readAsDataURL(input_file.files[0]); // FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다.
	      
	        fileReader.onload = function() { // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임. 
	             console.log(fileReader.result);
	             document.getElementById("previewImg").src = fileReader.result;
	         };
	             
	     }); 
	    
	});
	
	function add_comment() {

		  const c_content = $(".comment_inbox_text").val().trim(); 
		  
		  if($("input#c_attach").val() == "" && c_content == "") {
			  alert("내용을 입력하세요.");
			  return false;
		  }
		  
		  if($("input#c_attach").val() == "") {
			  // 첨부파일이 없는 댓글쓰기인 경우 
			  add_comment_noAttach();
		  }
		  else {
			  // 첨부파일이 있는 댓글쓰기인 경우 
			  add_comment_withAttach(); 
		  }
	};
	    
	//파일 첨부 없는 댓글 쓰기
	function add_comment_noAttach() {
		const queryString = $("form[name='c_frm']").serialize();

		$.ajax({
			url: "<%= request.getContextPath()%>/add_comment.fu",
			data: queryString, 
			type: "post",
			dateType: "json",
			success:function(json){
	  			 //console.log("~~ 확인용 : " + JSON.stringify(json));
	  			 
	  			 read_comment();
	  			 
	  			 $("#c_content").val("");
	  		 },
	  		 error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		     }
		});
	}; //end of function add_comment_noAttach()-------------------
	
	// 댓글 내용 읽어오기 
	function read_comment() {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/read_comment.fu",
			data:{"b_idx_fk":"${requestScope.boardvo.b_idx}"},
			dataType:"json",
			  success:function(json){
				  //console.log("~~ 확인용 : " + JSON.stringify(json));
				  
				  let html = "";
				  if(json.length > 0) {
					 $.each(json, function(index, item){
						 html += "<div class='comment_area'>" +
									 "<div style='margin-left: 4px;'>" +
							           "<div class='comment_nick'><img src='<%= ctxPath%>/resources/image/comment_nick (5).png' width=20/> "+ item.nickname +"</div>" +
							           "<div class='comment_text'>" + item.c_content + "</div>" +
				                       "<div class='comment_info_date'>" + item.c_date + "</div>" +
			                       	 "</div>" +
			                       "</div>";
	 				 }); 
				  }   				  
				  $("#view_comment").html(html);
				  
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		});
		
	};
	
	
	
	// 본인글일 때 게시글 삭제
  	function go_del() {
  		var result = confirm("정말 삭제하시겠습니까?");
		if(!result) return false;
		else{
			const frm = document.del_frm;
		    frm.action = "<%= ctxPath%>/board_delete.fu";
			frm.method="post";
			frm.submit();
		}
	};
	
</script>

        <!-- main area -->
        <div id="main_area">
           <div class="board_viewbox" style="height: auto; padding-bottom: 29px;">
              <form name="del_frm" enctype="multipart/form-data">
              <input type="hidden" name="b_idx" value="${requestScope.boardvo.b_idx}" />
              <input type="hidden" name="category_idx" value="${requestScope.boardvo.category_idx_fk}" />
              </form>
              
              <c:forEach var="catevo" items="${requestScope.cate_list}">
                <div class="view_button">
               		 <c:set var="v_goBackURL" value='${ fn:replace(requestScope.goBackURL, "&", " ") }' />
                    <div class="right_area">
    					<button type="button" class="base_bnt_2" ${empty requestScope.boardvo.previousseq ? 'hidden' : ''} 
    							onclick="javascript:location.href='<%= ctxPath %>/board_view_2.fu?b_idx=${requestScope.boardvo.previousseq}&category_idx_fk=${catevo.category_idx}&goBackURL=${v_goBackURL}'" >이전글</button>	    	
				    	<button type="button" class="base_bnt_2" ${empty requestScope.boardvo.nextseq ? 'hidden' : ''} 
				    			onclick="javascript:location.href='<%= ctxPath %>/board_view_2.fu?b_idx=${requestScope.boardvo.nextseq}&category_idx_fk=${catevo.category_idx}&goBackURL=${v_goBackURL}'">다음글</button>
						<button type="button" class="base_bnt" onclick= "javascript:location.href='<%= ctxPath %>/board_list.fu?category_idx=${catevo.category_idx}'">목록</button>
                    </div>
                    
                    
                </div>
                
                <c:if test="${not empty requestScope.boardvo}">
                <div class="viewbox">
                	
                    <div class="article_view">
                        <div class="article_title">
                            <a class="link_board" href="<%= ctxPath %>/board_list.fu?category_idx=${catevo.category_idx}">${catevo.category_name}</a>        
                            
                            <c:if test="${sessionScope.login_user.id eq requestScope.boardvo.id_fk}">
                            <div class="edit_delete">
                                <button class="ed_bnt" style="margin-right: 9px;" type="button" 
                                		onclick="javascript:location.href='<%= ctxPath %>/board_edit.fu?b_idx=${requestScope.boardvo.b_idx}&category_idx=${catevo.category_idx}'">수정</button>
                                <button class="ed_bnt" type="button" id="del_btn" onclick="go_del()">삭제</button>
                            </div>
                            </c:if>
                            
                            <h3>${requestScope.boardvo.b_title}</h3>
                            
                        </div>
                        <div class="writer_info">
                            <div class="profile_area">
                                <button type="button">${requestScope.boardvo.nickname}</button>
                                <span>${requestScope.boardvo.b_date}</span>
                                <span>조회 ${requestScope.boardvo.b_hit}</span>
                            </div>
                        </div>
                        <div class="article_content">
                            	${requestScope.boardvo.b_content}
                        </div>
                    </div>
                    
                    <div class="article_comment">
                         <div class="comment_info">
                            <div class="comment_count">
                                <img src="<%= ctxPath %>/resources/image/comment.png"  width="22">
                              		  댓글
                                <span>${requestScope.boardvo.c_cnt}</span>
                            </div>
                            <div class="article_like">
                                <img src="<%= ctxPath %>/resources/image/heart_after.png" width="22">
                                	좋아요
                                <span>${requestScope.boardvo.b_like}</span>
                            </div>
                        </div>
                        <!-- 댓글쓰기 폼 -->
                        <form name="c_frm" id="c_frm">
                        <input type="hidden" name="b_idx_fk" id="b_idx_fk" value="${requestScope.boardvo.b_idx}" />
                        <input type="hidden" name="id_fk" id="id_fk" value="${sessionScope.login_user.id}" />
                        <input type="hidden" name="nickname" id="nickname" value="${sessionScope.login_user.nickname}" />
                        
                        
                        <!-- 댓글 보여주기 -->
                        <div id="view_comment">
                        <!-- 
                        	<div style="margin-left: 4px;">
	                            <div class="comment_nick">왕밤코</div>
	                            <div class="comment_text">반갑습니다 임모!</div>
	                            <div class="comment_info_date">2024.05.04 15:50</div>
                            </div> 
                             -->
                        </div>
                        
                        <div class="comment_writer">
                            <c:if test="${sessionScope.login_user != null}">
	                            <div class="comment_inbox">
	                                <em class="comment_inbox_nick">${sessionScope.login_user.nickname}</em>
	                                <textarea class="comment_inbox_text" name="c_content" id="c_content" placeholder="댓글을 남겨보세요."></textarea>
	                                <div class="comment_attach">
	                                	<!-- 이미지 파일 첨부 input -->
		                                <label for="c_attach" id="c_lable">
		                                	<img src="<%= ctxPath %>/resources/image/camera.png" width="20"/>
		                                	<input type="file" id="c_attach" accept="image/*"/>
		                                </label>
		                                <!-- 이미지 첨부파일 미리보기 -->
	                                	<span class="prodInputName" style=" margin-left: 10px; ">
		                                    <img id="previewImg" />
		                                </span>
		               					<!-- 등록버튼 -->
	                                    <button type="button" class="comment_bnt" onclick="add_comment()">등록</button>
	                                </div>
	                            </div>
                            </c:if>
                            <c:if test="${sessionScope.login_user == null}">
                            	<div class="comment_inbox" style="height: 58px;">
	                                <a href="<%= ctxPath %>/login.fu">지금 가입하고 댓글에 참여해보세요! > </a>
	                            </div>
                            </c:if>
                        </div>
                        </form>
                        
                    </div>
                    <!-- article_comment 끝 -->
                    
                </div>
                <!-- viewbox 끝 -->
                </c:if>
                
				<c:if test="${empty requestScope.boardvo}">
			    	<div style="padding: 50px 0; font-size: 16pt;">존재하지 않습니다</div>
			    </c:if>
			  </c:forEach>
           </div>
     		<!-- board_viewbox 끝 -->
        </div>
        <!--main_area 끝-->

    </div>
    
    <!-- content area 끝 -->