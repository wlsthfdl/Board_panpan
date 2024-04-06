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
                                <th style="width: 56%;">제목</th>
                                <th style="width: 17%;">작성자</th>
                                <th style="width: 11%;">작성일</th>
                                <th style="width: 7%;">조회</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1234567</td>
                                <td>신흥강자 루이 이게존나길어지면어떻게될까이게존나길어지면어떻게될까이게존나길어지면어떻게될까</td>
                                <td>푸이모 페이윈 이게존나길어지면어떻게될까</td>
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
        </div>
        <!---->





        <!-- main box 끝-->

    </div>
    
    <!-- content area 끝 -->