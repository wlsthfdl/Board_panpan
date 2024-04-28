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
            <!-- 회원가입/로그인 버튼-->
            <div id="gnb-menu">
                    <ul class="header_member">
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
                    </ul>
            </div>

            <!-- 헤더 메인 이미지 -->
            <div id="front_img">
                <a href="#"><img src="<%= ctxPath %>/resources/image/main.png"/></a>
            </div>

            <!-- 스페셜 메뉴-->
            <div id="special_menu">
                <ul>
                    <li>
                        <a href="">인기글</a>
                    </li>
                    <li>
                        <a href="">BAO FAMILY 소식</a>
                    </li>
                    <li>
                        <a href="">사육사와의 소통</a>
                    </li>
                    <li>
                        <a href="">자유게시판</a>
                    </li>
                    <li>
                        <a href="">꿀팁게시판</a>
                    </li>
                </ul>
            </div>
        </div>
        <!-- end of header-->
    </div>



     <!-- header 끝 -->
	