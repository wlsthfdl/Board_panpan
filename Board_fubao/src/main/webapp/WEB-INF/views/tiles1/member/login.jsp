<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   
<script>
	let flag_input_id = false;
	
	$(document).ready(function(){
		$("span.pw_info").hide();
		
		$("input#pwd").keydown(function(){
			if($("input#pwd").keyCode == 13) { // 엔터를 했을 경우
				go_login();
			}
		});
		
		$("input#id").blur(function(){
			$("input#id").parent().find("span.pw_info").hide();

			const regExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
	     	const bool = regExp.test($("input#id").val());
	
	     	if(!bool) {
				$("input#id").parent().find("span.pw_info").show();
	            $("input#id").val("");
			}
			else {				                				
				$("input#id").parent().find("span.pw_info").hide();
			}
		});

		$("input#id").change(function () {
			$("input#id").parent().find("span.pw_info").hide();
		});
		
		
		
		
	});// end of $(document).ready(function()----------------------
	
			
	function go_login() {
		const id = $("input#id").val(); 
	    const pwd = $("input#pwd").val(); 
	   
	    if(id.trim()=="") {
	    	alert("ID를 입력하세요.");
		   $("input#id").parent().find("span.pw_info").hide();
	       $("input#id").val(""); 
	       $("input#id").focus();
	       return; // 종료 
	    }
	   
	    if(pwd.trim()=="") {
	       alert("비밀번호를 입력하세요.");
	       $("input#pwd").val(""); 
	       $("input#pwd").focus();
	       return; // 종료 
	    }
	    
	   
	    const frm = document.login_frm;
	    frm.action = "<%= ctxPath%>/login_end.fu";
	    frm.method = "post";
	    frm.submit();
		
	};

</script>


<div style="background-color: #f7ffee; width: 1080px; margin: 0 auto;">
	<!-- login form -->
        <section class="login">
            <div class="login_box">
            <div class="login_left">
                <div class="contact">
                <form name="login_frm">
                    <h3>SIGN IN</h3>
                    <input type="text" id="id" name="id" placeholder="ID" style="margin-bottom: 0;">
                    <span class="pw_info" style="padding-left: 10px; color:#43A44A;">ID는 이메일 형식으로 입력해주세요.</span>
                    <input type="password" id="pwd" name="pwd" placeholder="PASSWORD">
                    <button type="button" class="login_submit" onclick="go_login();">LET'S GO</button>
                </form>
                </div>
            </div>
            <div class="login_right">
                <div class="right-text">
                <h2>WELCOME</h2>
                <h5>BAO FAMILY GALLERY</h5>
                </div>
                <div class="right-inductor"></div>
            </div>
            </div>
        </section>
        <!-- login form -->
</div>        