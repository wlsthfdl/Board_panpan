<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   
<div style="background-color: #f7ffee; width: 1080px; margin: 0 auto;">
    <div id="content_area" style="height: 850px;">
    	<!-- 회원가입 form 시작 -->
		<div id="do_join">                                                
	       <h2 style="padding-top: 31px; font-size: 1.17em;">JOIN</h2>
	       <div class="textForm">
	         <input name="login_id" type="text" class="id join_frm" placeholder="ID"/>
	       </div>
	       <div class="textForm">
	         <input name="login_pw" type="password" class="pw join_frm" placeholder="PASSWORD"/>
	       </div>
	        <div class="textForm">
	         <input name="login_pw_confirm" type="password" class="pw join_frm" placeholder="CONFIRM PASSWORD"/>
	       </div>
	       <div class="textForm">
	         <input name="name" type="password" class="name join_frm" placeholder="NAME"/>
	       </div>
	        <div class="textForm">
	         <input name="email" type="text" class="email join_frm" placeholder="EMAIL"/>
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
	     <!-- 회원가입 form 끝 -->
     </div>
</div>        