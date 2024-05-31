<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();

%>

    <!-- footer -->
    <div id="footer" style="margin-top: 10px;">
        <div class="footer_wrap">
            <div class="footer_img" style="height: 200px;">
                <img src="<%= ctxPath %>/resources/image/footer.png"/>
            </div>
            <div class="footer_text">
                <div class="f_email">
                    <p>Email : test@naver.com</p>
                </div>
                <div class="f_company">
                    <p>COPYRIGHT © BAO FAMILY Gallery All rights reserved.</p>
                </div>
            </div>
            
        </div>
    </div>
    <!--footer 끝-->

</body>
</html>