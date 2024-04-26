<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   


<script type="text/javascript">

	$(document).ready(function() {
		/*
		$("span.error").hide();
		$("span.available").hide();
		*/
	});
	
</script>

<!-- 회원가입 form 시작 -->
<form class="sign_frm" name="sign_frm">
	<div style="background-color: #f7ffee; width: 1080px; margin: 0 auto;">
	    <div id="content_area" style="height: 850px;">
				<div id="do_join">                                                
			       <h2 style="padding-top: 31px; font-size: 1.17em;">JOIN</h2>
			       <div class="textForm">
			         <input name="login_id" type="text" class="id join_frm" placeholder="ID"/>
			       	 <span class="error">이미 존재하는 ID입니다.</span>
			       	 <span class="available">사용 가능한 ID입니다.</span>
			       </div>
			       <div class="textForm">
			         <input name="login_pw" type="password" class="pw join_frm" placeholder="PASSWORD"/>
			       	 <span class="pw_info">비밀번호는 8자~15자의 영문, 숫자, 특수문자 2가지 이상을 조합하여 설정해주세요.</span>
			       </div>
			        <div class="textForm">
			         <input name="login_pw_confirm" type="password" class="pw join_frm" placeholder="CONFIRM PASSWORD"/>
			       	 <span class="error">비밀번호를 다시 입력해주세요.</span>
			       </div>
			       <div class="textForm">
			         <input name="name" type="password" class="name join_frm" placeholder="NAME"/>
			       </div>
			        <div class="textForm">
			         <input name="email" type="text" class="email join_frm" placeholder="EMAIL" style="display:inline-block;"/>
			       	 <button class="e_bnt">인증번호 받기</button>
			       </div>
			       <div class="textForm">
			         <input name="nickname" type="text" class="nickname join_frm" placeholder="NICKNAME"/>
			       </div>
			       <div class="textForm">
			         <input name="mobile" type="number" class="mobile join_frm" placeholder="MOBILE"/>
			       </div>
			       <div class="textForm">
			           <input name="birthday" id="datepicker" type="text" class="birthday join_frm" placeholder="BIRTHDAY" />
			       </div>
			       <input type="submit" class="btn" value="J O I N"/>
			     </div>
	     </div>
	</div>        
</form>
<!-- 회원가입 form 끝 -->
