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

	
   <!-- <div id="content_area"> --> 
        <!-- main area -->
        <div id="main_area">
            <div class="main_box">
                <div class="main_img"><img src="<%= ctxPath %>/resources/image/bao.png"/></div>

                <div class="main_news">
                    <div class="list_tit">
                        <a href=""><img src="<%= ctxPath %>/resources/image/carrot.png" width="30" height="30"/>&nbsp; 인기글</a> 
                    </div>
                    <ul class="news_photo_box">
                    <c:forEach var="boardhits" items="${requestScope.boardList}">
                        <li>
                            <div class="dd_tit">
                            	<img src="<%= ctxPath %>/resources/image/leaf.png" width="13" height="13"/>
                                <a href="<%= ctxPath %>/board_view.fu?b_idx=${boardhits.b_idx}&category_idx_fk=${boardhits.category_idx_fk}"><span class="main_box_sub">${boardhits.b_title}</span></a>
                                <span class="num"><span>[</span>${boardhits.c_cnt}<span>]</span></span>
                           		 <div class="box_nick_area" >
                               		<p>${boardhits.nickname}</p>
                            	</div>
                            </div>
                           
                            <!-- 
                            <dd class="dd_date">
                                <span class="d_date">24.03.30</span>
                                <span class="d_num">조회 1,500</span>
                            </dd> -->
                            
                        </li>
                     </c:forEach>
                    </ul>
                    
                </div>
            </div>

        </div>
        <!-- main box 끝-->
 </div> 
    <!-- content_area 끝-->