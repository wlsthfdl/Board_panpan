<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   


<script type="text/javascript">

	let flag_input_id = false;
	let flag_input_pwd = false;
	let flag_input_pwd_check = false;
	let flag_input_name = false;
	let flag_input_nickname = false;
	let flag_input_mobile = false;
	let flag_input_birthday = false;
	
	let flag_id_check = false;
	let flag_nickname_check = false;
	
	
	$(document).ready(function() {
		
		$("span.error").hide();
		$("span.available").hide();
		$("span.error_2").hide();
		$("span.error_3").hide();
		$("span.duplicate").hide();

		// ID 유효성검사
		$("input#id").blur(function(){
     	 	 $("input#id").parent().find("span.available").hide();

			//const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	     	  
			const regExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
	     	const bool = regExp.test($("input#id").val());

	    	if ($("input#id").val().trim() == "" ) {	//공백일때
				$("input#id").parent().find("span.duplicate").hide();
                $("input#id").parent().find("span.error_3").hide();
                $("input#id").parent().find("span.error_2").show();
	    		flag_input_id = false;
			}
	    	else if(!bool) {
				$("input#id").parent().find("span.duplicate").hide();
                $("input#id").parent().find("span.error_2").hide();
                $("input#id").parent().find("span.error_3").show();
                $("input#id").val("");
	    		flag_input_id = false;

			}
			else {				                
				$("input#id").parent().find("span.duplicate").hide();
				$("input#id").parent().find("span.error_2").hide();
				$("input#id").parent().find("span.error_3").hide();
	    		flag_input_id = true;
			}
		});
		
		$("input#id").change(function () {
			flag_id_check = false;
		});
		
		
		// ID 중복 여부 (Ajax)
		$("#id_check").click(function() {
			$("input#id").parent().find("span.duplicate").hide();
      	 	$("input#id").parent().find("span.available").hide();

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
	                  }else if(!json.n && $("#id").val().trim() != ""){   //사용가능, ""이 아닐 경우
	                	  flag_id_check = true;
	                	  $("input#id").parent().find("span.error").hide();
	                	  $("input#id").parent().find("span.available").show();
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
	    	
	    	if ($("input#pwd").val().trim() == "" ) {	//공백일때
                $("input#pwd").parent().find("span.error").hide();
                $("input#pwd").parent().find("span.error_2").show();

	    		flag_input_pwd = false;
			}
	    	else if(!bool) {
                $("input#pwd").parent().find("span.error_2").hide();
                $("input#pwd").parent().find("span.error").show();
                $("input#pwd").val("");
			}
			else {		                 
                $("input#pwd").parent().find("span.error_2").hide();
				$("input#pwd").parent().find("span.error").hide();
	    		flag_input_pwd = true;
			}
		});
		
		
		// 비밀번호 확인
		$("input#pwd_confirm").blur(function() {
			if ($("input#pwd_confirm").val().trim() == "" ) {	//공백일때
                $("input#pwd_confirm").parent().find("span.error").hide();
                $("input#pwd_confirm").parent().find("span.error_2").show();

				flag_input_pwd_check = false;
			}
			else if($("input#pwd").val() != $("input#pwd_confirm").val() ) {	//맞지않을때
                $("input#pwd_confirm").parent().find("span.error_2").hide();
                $("input#pwd_confirm").parent().find("span.error").show();
                $("input#pwd_confirm").val("");
			}
			else {		                 	//성공
                $("input#pwd_confirm").parent().find("span.error_2").hide();
				$("input#pwd_confirm").parent().find("span.error").hide();
				flag_input_pwd_check = true;
			}
		});
		

		// 이름 공백인지 아닌지
		$("input#name").blur(function() {
			if( $("input#name").val().trim() == "" ) {	//공백일때
                $("input#name").parent().find("span.error_2").show();
				flag_input_name = false;
			}
			else {
                $("input#name").parent().find("span.error_2").hide();
				flag_input_name = true;
			}
		});
		

		// 닉네임 유효성 검사
		$("input#nickname").blur(function() {
    	 	$("input#nickname").parent().find("span.available").hide();

			const regExp = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,12}$/;
	    	const bool = regExp.test($("#nickname").val());
	    	
	    	if ($("input#nickname").val().trim() == "" ) {	//공백일때				
	    		$("input#nickname").parent().find("span.duplicate").hide();
                $("input#nickname").parent().find("span.error_3").hide();
                $("input#nickname").parent().find("span.error_2").show();
	    		flag_input_nickname = false;
			}
	    	else if(!bool) {
	    		$("input#nickname").parent().find("span.duplicate").hide();
                $("input#nickname").parent().find("span.error_2").hide();
                $("input#nickname").parent().find("span.error_3").show();
                $("input#nickname").val("");
			}
			else {		                         
	    		$("input#nickname").parent().find("span.duplicate").hide();
				$("input#nickname").parent().find("span.error_2").hide();
				$("input#nickname").parent().find("span.error_3").hide();
                flag_input_nickname = true;
			}
		});

		$("input#nickname").change(function () {
			flag_nickname_check = false;
		});
		
		// 닉네임 중복 여부 (Ajax)
		$("#nickname_check").click(function() {
			$("input#nickname").parent().find("span.duplicate").hide();
      	 	$("input#nickname").parent().find("span.available").hide();
      	 	
	         $.ajax({
	               url:"<%= ctxPath%>/nickname_check.fu",
	               data:{"nickname": $("input#nickname").val()},
	               type:"post",
	               success:function(text){
	                  const json = JSON.parse(text);
	                  console.log("확인용 json: " + json);
	                
	                  if(json.n){   //사용 불가 
		                 $("input#nickname").parent().find("span.available").hide();
	                     $("input#nickname").parent().find("span.error").show();
	                     $("input#nickname").val("");
	                  }else if(!json.n && $("#nickname").val().trim() != ""){   //사용가능, ""이 아닐 경우
	                	  $("input#nickname").parent().find("span.error").hide();
	                	  $("input#nickname").parent().find("span.available").show();

	                	  flag_nickname_check = true;
	                  }
	               },
	               error: function(request, status, error){
	                     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                 }
	            });
		});
		
		// 휴대폰 유효성 검사
		$("input#mobile").blur(function() {
			const regExp = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
	    	const bool = regExp.test($("#mobile").val());
	    	
	    	if ($("input#mobile").val().trim() == "" ) {	//공백일때
                $("input#mobile").parent().find("span.error").hide();
                $("input#mobile").parent().find("span.error_2").show();

	    		flag_input_mobile = false;
			}
	    	else if(!bool) {                
	    		$("input#mobile").parent().find("span.error_2").hide();
                $("input#mobile").parent().find("span.error").show();
                $("input#mobile").val("");
			}
			else {		                                 
				$("input#mobile").parent().find("span.error_2").hide();
				$("input#mobile").parent().find("span.error").hide();
				flag_input_mobile = true;
			}
		});

		 
		// 생년월일 유효성 검사
		$("input#birthday").blur(function() {
			const regExp = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
	    	const bool = regExp.test($("#birthday").val());
	    	
	    	if ($("input#birthday").val().trim() == "" ) {	//공백일때
                $("input#birthday").parent().find("span.error").hide();
                $("input#birthday").parent().find("span.error_2").show();

	    		flag_input_birthday = false;
			}
	    	else if(!bool) {
                $("input#birthday").parent().find("span.error_2").hide();
                $("input#birthday").parent().find("span.error").show();
                $("input#birthday").val("");
			}
			else {		                 
				$("input#birthday").parent().find("span.error").hide();                
				$("input#birthday").parent().find("span.error_2").hide();

				flag_input_birthday = true;
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


		$("#birthday").on('keydown keyup',function() {
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
		
		// mobile, birthday 입력시 자동  하이픈 끝
		
		
	});	//end of $(document).ready(function(){})--------------------

	
	function go_register() {
		
		if(flag_input_id == false){
			$("input#id").focus();
			return false;
		}

		if(flag_id_check == false){                
			$("input#id").parent().find("span.duplicate").show();
			$("input#id_check").focus();
			return false;
		}
		if(flag_input_pwd == false){
			$("input#pwd").focus();
			return false;
		}

		if(flag_input_pwd_check == false){
			$("input#pwd_confirm").focus();
			return false;
		}

		if(flag_input_name == false){
			$("input#name").focus();
			return false;
		}

		if(flag_input_nickname == false){
			$("input#nickname").focus();
			return false;
		}

		if(flag_nickname_check == false){                
			$("input#nickname").parent().find("span.duplicate").show();
			$("input#nickname_check").focus();
			return false;
		}
		
		if(flag_input_mobile == false){
			$("input#mobile").focus();
			return false;
		}

		if(flag_input_birthday == false){
			$("input#birthday").focus();
			return false;
		}

		
		
		const frm = document.sign_frm;
	    frm.action = "<%= ctxPath%>/join_complete.fu";
		frm.method="post";
		frm.submit();
	} //end of go_register() --------------------------
	
	
</script>

<!-- 회원가입 form 시작 -->
<form class="sign_frm" name="sign_frm">
	<div style="width: 1080px; margin: 0 auto;">
	    <div style=" background-color: f7ffee; height: 935px;">
				<div id="do_join">                                                
			       <h2 style="padding-top: 31px; font-size: 1.17em;">JOIN</h2>
			       <div class="textForm">
			         <input name="id" id="id" type="text" class="id join_frm" placeholder="ID" style="display:inline-block; width:265px; float:left; margin-left:19px; "/>
			         <button type="button" class="e_bnt" id="id_check" >중복 확인</button>
			       	 <span class="pw_info">이메일 형식으로 입력해주세요.</span>
			       	 <span class="error_3">이메일 형식이 올바르지 않습니다.</span>
			       	 <span class="error">이미 사용중인 ID입니다.</span>
			       	 <span class="available">사용 가능한 ID입니다.</span>
			     	 <span class="duplicate">ID 중복 확인을 해주세요.</span>
			       </div>
			       <div class="textForm">
			         <input name="pwd" id="pwd" type="password" class="pw join_frm" placeholder="PASSWORD"/>
			       	 <span class="pw_info">비밀번호는 8자~15자의 영문, 숫자, 특수문자 2가지 이상을 조합하여 설정해주세요.</span>
			       	 <span class="error">비밀번호 형식이 올바르지 않습니다.</span>
			     	 <span class="error_2">비밀번호는 필수 입력 항목입니다.</span>
			       </div>
			        <div class="textForm">
			         <input name="login_pw_confirm" id="pwd_confirm" type="password" class="pw join_frm" placeholder="CONFIRM PASSWORD"/>
			       	 <span class="error">비밀번호가 일치하지 않습니다.</span>
			       	 <span class="error_2">비밀번호를 확인해주세요.</span>
			       </div>
			       <div class="textForm">
			         <input name="name" id="name" type="text" class="name join_frm" placeholder="NAME"/>
			       	 <span class="error_2">이름은 필수 입력 항목입니다.</span>
			       </div>
			       <div class="textForm">
			         <input name="nickname" id="nickname" type="text" class="nickname join_frm" placeholder="NICKNAME" style="display:inline-block; width:265px; float:left; margin-left:19px; "/>
			       	 <button type="button" class="e_bnt" id="nickname_check">중복 확인</button>
			       	 <span class="error_3">2자 이상 12자 이하,초성 및 모음을 제외하고 입력하세요.</span>
			       	 <span class="error">이미 사용 중인 닉네임입니다.</span>			       
			       	 <span class="available">사용 가능한 닉네임입니다.</span>
			       	 <span class="error_2">닉네임은 필수 입력 항목입니다.</span>
			       	 <span class="duplicate">닉네임 중복 확인을 해주세요.</span>
			       </div>
			       <div class="textForm">
			         <input name="mobile" id="mobile" type="text" maxlength="13" class="mobile join_frm" placeholder="MOBILE"/>
			       	 <span class="error">휴대폰 번호를 확인해주세요.</span>
			       	 <span class="error_2">휴대폰 번호는 필수 입력 항목입니다.</span>
			       </div>
			       <div class="textForm">
			           <input name="birthday" id="birthday" type="text" maxlength="10" class="birthday join_frm" placeholder="BIRTHDAY" />
			    	   <span class="pw_info">ex)YYYY-MM-DD</span>
			    	   <span class="error">생년월일 8자리를 입력해주세요.</span>
			    	   <span class="error_2">생년월일은 필수 입력 항목입니다.</span>
			       </div>
			       <input type="button" class="btn" value="J O I N" onclick="go_register();"/>
			     </div>
	     </div>
	</div>        
</form>
<!-- 회원가입 form 끝 -->
