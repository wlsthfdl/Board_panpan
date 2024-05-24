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
		  
	//	    const goBackURL = "${requestScope.goBackURL}";
		    
	});
	    
  
	
</script>

        <!-- main area -->
        <div id="main_area">
           <div class="board_viewbox" style="height: auto; padding-bottom: 29px;">
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
                                <button class="ed_bnt" style="margin-right: 9px;" type="button" onclick="javascript:location.href='<%= ctxPath %>/board_edit.fu?b_idx=${requestScope.boardvo.b_idx}&category_idx=${catevo.category_idx}'">수정</button>
                                <button class="ed_bnt" type="button">삭제</button>
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
                        
                        <div class="comment_area">
                        	<div style="margin-left: 4px;">
	                            <div class="comment_nick">왕밤코</div>
	                            <div class="comment_text">반갑습니다 임모!</div>
	                            <div class="comment_info_date">2024.05.04 15:50</div>
                            </div>
                        </div>
                        
                        <div class="comment_writer">
                            <c:if test="${sessionScope.login_user != null}">
	                            <div class="comment_inbox">
	                                <em class="comment_inbox_nick">${sessionScope.login_user.nickname}</em>
	                                <textarea class="comment_inbox_text" placeholder="댓글을 남겨보세요."></textarea>
	                                <div class="comment_attach">
	                                    <button type="button" class="comment_bnt">등록</button>
	                                </div>
	                            </div>
                            </c:if>
                            <c:if test="${sessionScope.login_user == null}">
                            	<div class="comment_inbox" style="height: 58px;">
	                                <a href="<%= ctxPath %>/login.fu">지금 가입하고 댓글에 참여해보세요! > </a>
	                            </div>
                            </c:if>
                        </div>
                        
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