<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<%
    String ctxPath = request.getContextPath();

%>   
<div style="background-color: #f7ffee; width: 1080px; margin: 0 auto;">
	<!-- login form -->
        <section class="login">
            <div class="login_box">
            <div class="login_left">
                <div class="contact">
                <form action="">
                    <h3>SIGN IN</h3>
                    <input type="text" placeholder="ID">
                    <input type="text" placeholder="PASSWORD">
                    <button class="login_submit">LET'S GO</button>
                </form>
                </div>
            </div>
            <div class="login_right">
                <div class="right-text">
                <h2>WELCOME</h2>
                <h5>BAO FAMILY GALLERY</h5>
                </div>
                <div class="right-inductor"><img src="" alt=""></div>
            </div>
            </div>
        </section>
        <!-- login form -->
</div>        