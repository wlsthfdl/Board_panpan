<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ======= #27. tile1 중 header 페이지 만들기 (#26.번은 없다 샘이 장난침.) ======= --%>
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
                            <a href="" title="Button fade orange" class="button btnFade btnOrange">Jion</a>
                        </li>
                        <span class="txt_bar"></span>
                        <li>
                            <a href="" title="Button fade orange" class="button btnFade btnOrange">Login</a>
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
	