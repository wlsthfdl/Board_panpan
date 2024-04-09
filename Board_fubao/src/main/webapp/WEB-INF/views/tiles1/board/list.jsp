<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
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
                    <li style="padding-bottom: 19px;"><img src="<%= ctxPath %>/resources/image/list.png" width="16" height="16" class="ico-list">팬아트</li>
            </div>

        </div>
        <!-- end of left side -->

        <!-- main area -->
        <div id="main_area">
            <div class="list_box">
                <div class="list_tit">
                    <h3>인기글</h3>
                </div>
                <div class="list_content">
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 9%;"></th>
                                <th style="width: 56%;">제목</th>
                                <th style="width: 17%;">작성자</th>
                                <th style="width: 11%;">작성일</th>
                                <th style="width: 7%;">조회</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1234567</td>
                                <td>신흥강자 루이 이게길어지면어떻게될까이게길어지면어떻게될까이게길어지면어떻게될까이게길어지면어떻게될까이게길어지면어떻게될까</td>
                                <td>푸이모 페이윈 이게길어지면어떻게될까</td>
                                <td>12:35</td>
                                <td>913</td>
                            </tr>
                            <tr>
                                <td>1234567</td>
                                <td>할부지 깨물려다 실패</td>
                                <td>낑바오</td>
                                <td>24.03.31</td>
                                <td>325</td>
                            </tr>
                            <tr>
                                <td>1234567</td>
                                <td>할부지 깨물려다 실패</td>
                                <td>낑바오</td>
                                <td>24.03.31</td>
                                <td>325</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="list_paginate">
                    <div class="article_paginate">
                        <ul>
                            <li><a class="arrow prev" href="#"></a></li>
                            <li><a href="" class="active">1</a></li>
                            <li><a href="">2</a></li>
                            <li><a href="">3</a></li>
                            <li><a href="">4</a></li>
                            <li><a href="">5</a></li>
                            <li><a href="">6</a></li>
                            <li><a href="">7</a></li>
                            <li><a href="">8</a></li>
                            <li><a href="">9</a></li>
                            <li><a href="">10</a></li>
                            <li><a class="arrow next" href="#"></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--list_box 끝-->
        </div>
        <!--main_area 끝-->

    </div>
    
    <!-- content area 끝 -->