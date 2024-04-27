<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   


<script type="text/javascript">

	$(document).ready(function() {
		
		$("span.error").hide();
		$("span.available").hide();
		
		
		
		
		/* mobile, birthday 입력시 자동 하이픈 */
		$("#mobile").on('keydown keyup',function() {
	         this.value = this.value.replace(/[^0-9]/g, '');

	         var str = this.value;
	         var tmp = '';
	         var bullet = '-';

	         if (str.length > 3 && str.length < 8) {
	             tmp += str.substr(0, 3);
	             tmp += bullet;
	             tmp += str.substr(3);
	             this.value = tmp;
	          } else if (str.length >= 8) {
	             tmp += str.substr(0, 3);
	             tmp += bullet;
	             tmp += str.substr(3, 4);
	             tmp += bullet;
	             tmp += str.substr(7, 4);
	             this.value = tmp;
	         } else {
	             this.value = str;
	         }
	     });


		$("#datepicker").on('keydown keyup',function() {
	         this.value = this.value.replace(/[^0-9]/g, '');

	         var str = this.value;
	         var tmp = '';
	         var bullet = '-';

	         if (str.length > 4 && str.length < 7) {
	             tmp += str.substr(0, 4);
	             tmp += bullet;
	             tmp += str.substr(4);
	             this.value = tmp;
	         } else if (str.length >= 7) {
	             tmp += str.substr(0, 4);
	             tmp += bullet;
	             tmp += str.substr(4, 2);
	             tmp += bullet;
	             tmp += str.substr(6, 2);
	             this.value = tmp;
	         } else {
	             this.value = str;
	         }
	     });
		
		/* 자동 하이픈 끝 */
		
		
	});
	 
	 
	function go_register() {

		const frm = document.sign_frm;
		frm.method="post";
		frm.submit();
		
	} //end of go_register() --------------------------
	
</script>

<!-- 회원가입 form 시작 -->
<form class="sign_frm" name="sign_frm">
	<div style="background-color: #f7ffee; width: 1080px; margin: 0 auto;">
	    <div id="content_area" style="height: 850px;">
				<div id="do_join">                                                
			       <h2 style="padding-top: 31px; font-size: 1.17em;">JOIN</h2>
			       <div class="textForm">
			         <input name="id" type="text" class="id join_frm" placeholder="ID" style="display:inline-block; width:252px; float:left; margin-left:19px; "/>
			         <button class="e_bnt" style="width: 78px;">중복 확인</button>
			       	 <span class="error">이미 존재하는 ID입니다.</span>
			       	 <span class="available">사용 가능한 ID입니다.</span>
			       </div>
			       <div class="textForm">
			         <input name="pwd" type="password" class="pw join_frm" placeholder="PASSWORD"/>
			       	 <span class="pw_info">비밀번호는 8자~15자의 영문, 숫자, 특수문자 2가지 이상을 조합하여 설정해주세요.</span>
			       </div>
			        <div class="textForm">
			         <input name="login_pw_confirm" type="password" class="pw join_frm" placeholder="CONFIRM PASSWORD"/>
			       	 <span class="error">비밀번호를 다시 입력해주세요.</span>
			       </div>
			       <div class="textForm">
			         <input name="name" type="text" class="name join_frm" placeholder="NAME"/>
			       </div>
			        <div class="textForm">
			         <input name="email" type="email" class="email join_frm" placeholder="EMAIL" style="display:inline-block; width:249px; float:left; margin-left:19px; "/>
			       	 <button class="e_bnt">인증번호 받기</button>
			         <span class="error">이메일 형식이 올바르지 않습니다.</span>

			       </div>
			       <div class="textForm">
			         <input name="nickname" type="text" class="nickname join_frm" placeholder="NICKNAME"/>
			       	 <span class="error">이미 사용 중인 닉네임입니다.</span>
			       </div>
			       <div class="textForm">
			         <input name="mobile" id="mobile" type="text" maxlength="13" class="mobile join_frm" placeholder="MOBILE"/>
			       </div>
			       <div class="textForm">
			           <input name="birthday" id="datepicker" type="text" maxlength="10" class="birthday join_frm" placeholder="BIRTHDAY" />
			    	   <span class="pw_info">ex)YYYY-MM-DD</span>
			       </div>
			       <input type="submit" class="btn" value="J O I N" onclick="go_register();"/>
			     </div>
	     </div>
	</div>        
</form>
<!-- 회원가입 form 끝 -->
