<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();

%>
    <!-- headr 시작 -->


<body>
    <div id="gallery-body">
        <!-- Header -->
        <div id="gallery-gnb">
            <div id="gnb-menu">
                    <ul class="header_member">
            			<!-- 회원가입/로그인 버튼-->
                        <c:if test="${empty sessionScope.login_user}">
	                        <li>
	                       		<a onclick="location.href='<%= ctxPath%>/join.fu'"  title="Button fade orange" class="button btnFade btnOrange" style="cursor:pointer;">
		                          	  Join
		                        </a>
	                        </li>
	                        <span class="txt_bar"></span>
	                         <li>
	                        	<a onclick="location.href='<%= ctxPath%>/login.fu'"  title="Button fade orange" class="button btnFade btnOrange" style="cursor:pointer;">
		                          	  Login
		                        </a>
	                        </li>
                        </c:if>
                        <!-- 로그인 유저 id/로그아웃 버튼-->
                        <c:if test="${not empty sessionScope.login_user}">
		            
	                         <li>
	                        	<a onclick="location.href='<%= ctxPath%>/logout.fu'"  title="Button fade orange" class="button btnFade btnOrange" style="cursor:pointer; width:64px;">
		                          	  Logout
		                        </a>
		                     </li>
                        </c:if>
                    </ul>
            </div>

            <!-- 헤더 메인 이미지 -->
            <div id="front_img">
                <a onclick="location.href='<%= ctxPath%>/index.fu'"><img src="<%= ctxPath %>/resources/image/main.png"/></a>
            </div>

            <!-- 스페셜 메뉴-->
            <div id="special_menu">
                <ul>
                    <li>
                        <a href="<%=ctxPath%>/board_list.fu?category_idx=10">인기글</a>
                    </li>
                    <li>
                        <a href="<%=ctxPath%>/board_list.fu?category_idx=3">BAO FAMILY 소식</a>
                    </li>
                    <li>
                        <a href="<%=ctxPath%>/board_list.fu?category_idx=4">사육사와의 소통</a>
                    </li>
                    <li>
                        <a href="<%=ctxPath%>/board_list.fu?category_idx=6">자유게시판</a>
                    </li>
                    <li>
                        <a href="<%=ctxPath%>/board_list.fu?category_idx=7">꿀팁게시판</a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- end of header-->
    </div>



     <!-- header 끝 -->
	