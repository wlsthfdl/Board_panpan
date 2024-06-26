<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>




<div id="content_area">
<!-- left side -->
   <div id="left_container">
       <!-- 내 정보 -->
       <div id="user_info">
           <div class="my_info">나의 활동</div>
           <div class="my_profile">
               <ul>
               <li><img src="<%= ctxPath %>/resources/image/panda (1).png" width="45" height="45" class="ico-list" style="margin-top:15px;"></li>
               <c:if test="${empty sessionScope.login_user}">
	               	<li class="nickname">로그인 해주세요.</li>
	               	<li><span class="date">&nbsp;</span></li>
               </c:if>
               <c:if test="${not empty sessionScope.login_user}">
	               	<li class="nickname"><span>${(sessionScope.login_user).nickname}</span>님</li>
	               	<li>
	                	<span class="date"> 가입일자:
	                	<fmt:parseDate value="${(sessionScope.login_user).registerday}" var="registered" pattern="yyyy-MM-dd HH:mm" />
						<fmt:formatDate value="${registered}" pattern="yyyy/MM/dd" />
						</span>
					</li>
				</c:if>
               </ul>
           </div>
           <c:if test="${not empty sessionScope.login_user}">              
           		<!-- <div class="info_box">
	               <li class="b_write"><a href="<%= ctxPath %>/" style="text-decoration: none; color: black;">내가 쓴 게시글</a></li>
	               <li class="b_comment"><a href="<%= ctxPath %>" style="text-decoration: none; color: black;">내가 쓴 댓글</a></li>
	           </div> -->
	           <div class="side_write_btn">
	               <div><a href="<%= ctxPath%>/board_write.fu" style="text-decoration: none; color: white;">게시글쓰기</a></div>
	           </div>
	       </c:if>
	       <c:if test="${empty sessionScope.login_user}">
             <!-- <div class="info_box">
	               <li class="b_write"><a href="<%= ctxPath %>/login.fu" style="text-decoration: none; color: black;">내가 쓴 게시글</a></li>
	               <li class="b_comment"><a href="<%= ctxPath %>/login.fu" style="text-decoration: none; color: black;">내가 쓴 댓글</a></li>
	           	  </div>  --> 
      	       <div class="side_write_btn">
             		<div><a href="<%= ctxPath%>/board_write.fu" style="text-decoration: none; color: white;">게시글쓰기</a></div>
          	   </div>
	       </c:if>
       </div>

      <!-- 카테고리 -->
      <div id="category">
          <h3><span>GATE</span></h3>
              <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list"><a href="<%=ctxPath%>/board_list.fu?category_idx=1">가입인사</a></li>
              <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list"><a href="<%=ctxPath%>/board_list.fu?category_idx=2">공지사항</a></li>
          <h3><span>BAO News</span></h3>
              <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list"><a href="<%=ctxPath%>/board_list.fu?category_idx=3">BAO Family 소식</a></li>
              <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list"><a href="<%=ctxPath%>/board_list.fu?category_idx=4">사육사와의 소통</a></li>
          <h3><span>Hey! Panda World</span></h3>
              <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list"><a href="<%=ctxPath%>/board_list.fu?category_idx=5">판다월드 관람/체험후기</a></li>
          <h3><span>BAO Talk</span></h3>
              <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list"><a href="<%=ctxPath%>/board_list.fu?category_idx=6">자유게시판</a></li>
              <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list"><a href="<%=ctxPath%>/board_list.fu?category_idx=7">꿀팁게시판</a></li>
              <li><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list"><a href="<%=ctxPath%>/board_list.fu?category_idx=8">질문게시판</a></li>
          <h3><span>동물자랑단</span></h3>
              <li style="padding-bottom: 19px;"><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list"><a href="<%=ctxPath%>/board_list.fu?category_idx=9">팬아트</a></li>
      </div>
   </div>
   <!-- end of left side -->
