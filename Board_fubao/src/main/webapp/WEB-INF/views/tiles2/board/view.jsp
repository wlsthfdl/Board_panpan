<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   

<script type="text/javascript">

  $(document).ready(function(){

	    
	    
  });
	    
</script>

        <!-- main area -->
        <div id="main_area">
           <div class="board_viewbox" style="height: auto; padding-bottom: 29px;">
                <div class="view_button">
                    <div class="right_area">
                        <button type="button" class="base_bnt">목록</button>
                    </div>
                </div>
                
                <c:if test="${not empty requestScope.boardvo}">
                <div class="viewbox">
                
                    <div class="article_view">
                        <div class="article_title">
                            <a class="link_board">가입인사</a>
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
                            <div class="comment_inbox">
                                <em class="comment_inbox_nick">두눈을감자</em>
                                <textarea class="comment_inbox_text" placeholder="댓글을 남겨보세요."></textarea>
                                <div class="comment_attach">
                                    <button type="button" class="comment_bnt">등록</button>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    <!-- article_comment 끝 -->
                    
                </div>
                <!-- viewbox 끝 -->
                </c:if>
           </div>
     		<!-- board_viewbox 끝 -->
        </div>
        <!--main_area 끝-->

    </div>
    
    <!-- content area 끝 -->