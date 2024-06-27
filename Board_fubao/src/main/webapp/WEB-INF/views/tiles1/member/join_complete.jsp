<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>    


<script type="text/javascript">

</script>


<div id="content_area" style="height: 850px;">
    <div class="join_complete">
        <h2>BAO Gallery</h2>
        <div>
            <h3>회원가입이 완료되었습니다.</h3>
            <h4>BAO Gallery의 모든 기능을 이용하실 수 있습니다.</h4>
        </div>
        <input type="button" class="complete_btn" value="홈으로" onclick="location.href='<%= ctxPath%>/index.fu'"/>
    </div>
</div>
        
