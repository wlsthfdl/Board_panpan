<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   
<script type="text/javascript">
	
	$(document).ready(function() {
		
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
							<fmt:formatDate value="${registered}" pattern="yyyy-MM-dd" />
							</span>
						</li>
					</c:if>
                    </ul>
                </div>
                <div class="info_box">
                    <li class="b_write"><a href="" style="text-decoration: none; color: black;">내가 쓴 게시글</a></li>
                    <li class="b_comment"><a href="" style="text-decoration: none; color: black;">내가 쓴 댓글</a></li>
                </div>
                <div class="side_write_btn">
                    <div><a class="" onclick="location.href='<%= ctxPath%>/board_write.fu'">게시글쓰기</a></div>
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
            <div class="main_box">
                <div class="main_img"><img src="<%= ctxPath %>/resources/image/bao.png"/></div>

                <div class="main_news">
                    <div class="list_tit">
                        <a href=""><img src="<%= ctxPath %>/resources/image/carrot.png" width="30" height="30"/>BAO FAMILY 소식</a> 
                    </div>
                    <ul class="news_photo_box">
                        <li>
                            <dt>
                                <a href=""><img src="<%= ctxPath %>/resources/image/p_box/photo_box (1).jpg" width="132" height="132"/></a>
                            </dt>
                            <dd class="dd_tit">
                                <a href=""><span class="main_box_sub">후이이게길어지면r계속길어지면</span></a>
                                <span class="num">[13]</span>
                            </dd>
                            <div class="box_nick_area">
                                러부지는러브지
                            </div>
                            <dd class="dd_date">
                                <span class="d_date">24.03.30</span>
                                <span class="d_num">조회 1,500</span>
                            </dd>
                        </li>
        
                        <li>
                            <dt>
                                <a href=""><img src="<%= ctxPath %>/resources/image/p_box/photo_box (2).jpg" width="132" height="132"/></a>
                            </dt>
                            <dd class="dd_tit">
                                <a href=""><span class="main_box_sub">후이이게길어지면r계속길어지면</span></a>
                                <span class="num">[13]</span>
                            </dd>
                            <div class="box_nick_area">
                                러부지는러브지
                            </div>
                            <dd class="dd_date">
                                <span class="d_date">24.03.30</span>
                                <span class="d_num">조회 1,500</span>
                            </dd>
                        </li>
        
                        <li>
                            <dt>
                                <a href=""><img src="<%= ctxPath %>/resources/image/p_box/photo_box (3).jpg" width="132" height="132"/></a>
                            </dt>
                            <dd class="dd_tit">
                                <a href=""><span class="main_box_sub">후이이게길어지면r계속길어지면</span></a>
                                <span class="num">[13]</span>
                            </dd>
                            <div class="box_nick_area">
                                러부지는러브지
                            </div>
                            <dd class="dd_date">
                                <span class="d_date">24.03.30</span>
                                <span class="d_num">조회 1,500</span>
                            </dd>
                        </li>
        
                        <li>
                            <dt>
                                <a href=""><img src="<%= ctxPath %>/resources/image/p_box/photo_box (4).jpg" width="132" height="132"/></a>
                            </dt>
                            <dd class="dd_tit">
                                <a href=""><span class="main_box_sub">후이이게길어지면r계속길어지면</span></a>
                                <span class="num">[13]</span>
                            </dd>
                            <div class="box_nick_area">
                                러부지는러브지
                            </div>
                            <dd class="dd_date">
                                <span class="d_date">24.03.30</span>
                                <span class="d_num">조회 1,500</span>
                            </dd>
                        </li>
        
                        <li>
                            <dt>
                                <a href=""><img src="/photo/p_box/photo_box (6).jpg" width="132" height="132"/></a>
                            </dt>
                            <dd class="dd_tit">
                                <a href=""><span class="main_box_sub">후이이게길어지면r계속길어지면</span></a>
                                <span class="num">[13]</span>
                            </dd>
                            <div class="box_nick_area">
                                러부지는러브지
                            </div>
                            <dd class="dd_date">
                                <span class="d_date">24.03.30</span>
                                <span class="d_num">조회 1,500</span>
                            </dd>
                        </li>
        
                        <li>
                            <dt>
                                <a href=""><img src="/photo/p_box/photo_box (9).jpg" width="132" height="132"/></a>
                            </dt>
                            <dd class="dd_tit">
                                <a href=""><span class="main_box_sub">후이이게길어지면r계속길어지면</span></a>
                                <span class="num">[13]</span>
                            </dd>
                            <div class="box_nick_area">
                                러부지는러브지
                            </div>
                            <dd class="dd_date">
                                <span class="d_date">24.03.30</span>
                                <span class="d_num">조회 1,500</span>
                            </dd>
                        </li>
    
                        <li>
                            <dt>
                                <a href=""><img src="/photo/p_box/photo_box (8).jpg" width="132" height="132"/></a>
                            </dt>
                            <dd class="dd_tit">
                                <a href=""><span class="main_box_sub">후이이게길어지면r계속길어지면</span></a>
                                <span class="num">[13]</span>
                            </dd>
                            <div class="box_nick_area">
                                러부지는러브지
                            </div>
                            <dd class="dd_date">
                                <span class="d_date">24.03.30</span>
                                <span class="d_num">조회 1,500</span>
                            </dd>
                        </li>
    
                        <li>
                            <dt>
                                <a href=""><img src="/photo/p_box/photo_box (7).jpg" width="132" height="132"/></a>
                            </dt>
                            <dd class="dd_tit">
                                <a href=""><span class="main_box_sub">후이이게길어지면r계속길어지면</span></a>
                                <span class="num">[13]</span>
                            </dd>
                            <div class="box_nick_area">
                                러부지는러브지
                            </div>
                            <dd class="dd_date">
                                <span class="d_date">24.03.30</span>
                                <span class="d_num">조회 1,500</span>
                            </dd>
                        </li>
    
                    </ul>
    
    
                </div>

            </div>

        </div>
        <!-- main box 끝-->
    </div>
    <!-- content_area 끝-->