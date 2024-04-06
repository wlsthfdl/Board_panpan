<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();

%>


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
                    <li style="padding-bottom: 19px;"><img src="/photo/list.png" width="16" height="16" class="ico-list">팬아트</li>
            </div>

        </div>
        <!-- end of left side -->
    
</html>