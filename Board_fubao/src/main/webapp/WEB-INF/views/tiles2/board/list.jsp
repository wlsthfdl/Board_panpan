<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   


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
                                <th style="width: 54%;">제목</th>
                                <th style="width: 17%;">작성자</th>
                                <th style="width: 11%;">작성일</th>
                                <th style="width: 9%;">조회</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>글번호</td>
                                <td>글제목
                                	<span class="num">[13]</span>
                                </td>
                                <td>작성자</td>
                                <td>작성일자</td>
                                <td>조회수</td>
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