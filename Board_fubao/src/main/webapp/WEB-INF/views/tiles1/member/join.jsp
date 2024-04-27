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
		
		
		
		// ID 중복 여부 (Ajax)
		$("#id_check").click(function() {
			/*
			const id = $("#id").val();
			console.log("확인용 id : " + id);
			*/
	         $.ajax({
	               url:"<%= ctxPath%>/id_check.fu",
	               data:{"id": $("input#id").val()},
	               type:"post",
	               success:function(text){
	                  const json = JSON.parse(text);
	                  //console.log("확인용 json: " + json);
	                
	                  if(json.n){   //사용 불가 ID일 경우
		                 $("input#id").parent().find("span.available").hide();
	                     $("input#id").parent().find("span.error").show();
	                     $("input#id").val("");
	                     $("input#id").focus();
	                  }else if(!json.n && $("#id").val().trim() != ""){   //사용가능, ""이 아닐 경우
		                 $("input#id").parent().find("span.error").hide();
	                	 $("input#id").parent().find("span.available").show();
	                	 $("input#pwd").focus();
	                  }
	               },
	               error: function(request, status, error){
	                     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                 }
	            });
		});
		
		
		// 비밀번호 유효성 검사
		$("input#pwd").blur(function() {

			const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
	    	  
	    	const bool = regExp.test($("#pwd").val());
			
			if(!bool) {
                $("input#pwd").parent().find("span.error").show();
                $("input#pwd").val("");
                $("input#pwd").focus();
			}
			else {		                 
				$("input#pwd").parent().find("span.error").hide();
                $("input#pwd_confirm").focus();
			}
		});
		
		
		// 비밀번호 확인
		$("input#pwd_confirm").blur(function() {

			if($("input#pwd").val() != $("input#pwd_confirm").val() ) {
                $("input#pwd_confirm").parent().find("span.error").show();
                $("input#pwd_confirm").val("");
                $("input#pwd_confirm").focus();
			}
			else {		                 
				$("input#pwd_confirm").parent().find("span.error").hide();
                $("input#name").focus();
			}
		});
		
		// 이름
		$("input#name").blur(function() {
			if($("input#name").val().trim() == "") {
                $("input#name").parent().find("span.error").show();
			}else{
                $("input#name").parent().find("span.error").hide();

			}
		});
		
		
		// 이메일주소 blur
		$("input#email").blur(function(){
			
			const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	     	  
	     	const bool = regExp.test($("input#email").val());

			if(!bool) {
                $("input#email").parent().find("span.error").show();
                $("input#email").val("");
                $("input#email").focus();
			}
			else {		                 
				$("input#email").parent().find("span.error").hide();
                $("input#nickname").focus();
			}
		});
		
		
		// mobile, birthday 입력시 자동 하이픈 
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
		
		// 자동 하이픈 끝
		
		
		
		
	});	//end of $(document).ready(function(){})--------------------

	
	function go_register() {
		const frm = document.sign_frm;
	    frm.action = "<%= ctxPath%>/join_complete.fu";
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
			         <input name="id" id="id" type="text" class="id join_frm" placeholder="ID" style="display:inline-block; width:252px; float:left; margin-left:19px; "/>
			         <button type="button" class="e_bnt" id="id_check" style="width: 78px;">중복 확인</button>
			       	 <span class="error">이미 존재하는 ID입니다.</span>
			       	 <span class="available">사용 가능한 ID입니다.</span>
			       </div>
			       <div class="textForm">
			         <input name="pwd" id="pwd" type="password" class="pw join_frm" placeholder="PASSWORD"/>
			       	 <span class="pw_info">비밀번호는 8자~15자의 영문, 숫자, 특수문자 2가지 이상을 조합하여 설정해주세요.</span>
			       	 <span class="error">비밀번호 형식이 올바르지 않습니다.</span>
			       </div>
			        <div class="textForm">
			         <input name="login_pw_confirm" id="pwd_confirm" type="password" class="pw join_frm" placeholder="CONFIRM PASSWORD"/>
			       	 <span class="error">비밀번호가 일치하지 않습니다.</span>
			       </div>
			       <div class="textForm">
			         <input name="name" id="name" type="text" class="name join_frm" placeholder="NAME"/>
			       	 <span class="error">이름은 필수입력 항목입니다.</span>
			       </div>
			        <div class="textForm">
			         <input name="email" id="email" type="email" class="email join_frm" placeholder="EMAIL" style="display:inline-block; width:249px; float:left; margin-left:19px; "/>
			       	 <button type="button" class="e_bnt">인증번호 받기</button>
			         <span class="error">이메일 형식이 올바르지 않습니다.</span>

			       </div>
			       <div class="textForm">
			         <input name="nickname" id="nickname" type="text" class="nickname join_frm" placeholder="NICKNAME"/>
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
