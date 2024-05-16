<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   

<script type="text/javascript">

  function goView(b_idx) {
	  
    const goBackURL = "${requestScope.goBackURL}";
	
	
	location.href = "<%= ctxPath%>/board_view.fu?b_idx="+b_idx;
	
  }
  
</script>



        <!-- main area -->
       <div id="main_area">
       	<c:forEach var="catevo" items="${requestScope.cate_list}">
           	<div class="list_box">
                <div class="list_tit">
                    <h3>${catevo.category_name}</h3>
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
                        	<c:if test="${empty requestScope.board_list}">
								<td colspan="5" style="text-align: center;">게시글이 없습니다</td>
							</c:if>
						   <c:if test="${not empty requestScope.board_list}">
							   <c:forEach var="boardvo" items="${requestScope.board_list}">
		                           <tr>
		                               <td>${boardvo.b_idx}</td>
		                               <td><span onclick="goView('${boardvo.b_idx}')">${boardvo.b_title}</span>
		                               	<span class="num">[<span>${boardvo.c_cnt}</span>]</span>
		                               </td>
		                               <td>${boardvo.nickname}</td>
		                               <td>${boardvo.b_date}</td>
		                               <td>${boardvo.b_hit}</td>
		                           </tr>
		                       </c:forEach>
                            </c:if>
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
          </c:forEach>
            <!--list_box 끝-->
        </div>
        <!--main_area 끝-->

    </div>
    
    <!-- content area 끝 -->