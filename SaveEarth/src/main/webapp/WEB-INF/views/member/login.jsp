<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<c:import url="../layout/header.jsp"></c:import>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	
<script>
    // 실패 시 알림 창
	$(function(){
		if("${msg}"=="실패") alert("아이디/비밀번호 다시")
	})	
    
	$(function(){
		if("${msg}"=="카카오실패") alert("이미 존재하는 이메일입니다")
	})	
	
		$(function(){
		if("${msg}"=="네이버실패") alert("이미 존재하는 이메일입니다")
	})	
</script>	


	
	
	
<style type="text/css">



/* base - 브라우저 별로 다를 수도 있는 것을 초기화 */
*{ padding: 0; margin: 0; } /* 태그 여백 없앰 */
li{ list-style: none; } /* 기호나 번호를 제거 */
a{ text-decoration: none; } /* 링크텍스트에 밑줄없앰 */
button{ cursor: pointer; } /* 모든 버튼에 마우스손모양 처리 */

/* body설정 */
/* body{ background-color: #ededed; } */

.loginbox{
    width: 780px; height: 550px;
    margin: 0 auto; /* 블록요소를 부모영역에서 가운데 처리 */
}
.loginbox h2{
    width: 100%; /* 부모영역을 상속 */

    /* 한줄텍스트인 경우만 height와 line-height가 같으면 세로 가운데 처리 */
    height: 100px; line-height: 100px;
    text-align: center; font-size: 20px;
    font-weight: normal;
}
.loginbox form{
    width: 100%; height: 450px;
    background-color: #fff;
    /* 패딩수치를 인사이드 처리 */
    padding: 60px; box-sizing: border-box;
}
.loginbox fieldset{
    border: none; /* 테두리 제거 */ 
}
.loginbox legend{
    /* 요소를 화면 밖으로 처리 */
    position: absolute; left: -999em;

    /* 웹접근성으로 스크린리더기가 읽어줘야 하므로 display: none;을 사용하지 말것 */
}
.loginbox label{
    display: block;
    font-size: 12px; color: #333;
    margin-bottom: 10px; /* 동위선택자와의 간격 조정 */
}
.loginbox input{
    display: block;
    width: 100%; height: 50px;
    margin-bottom: 25px; /* 동위선택자와의 간격 조정 */
    border: none; background-color: #ededed;
    padding: 0 20px; /* 앞상하 뒷좌우 */
    box-sizing: border-box; /* 패딩수치를 인사이드 처리 */
}

.loginbox ul{
    width: 100%;
    text-align: right; /* 글자를 오른쪽으로 처리 */
    margin-bottom: 60px;
}
.loginbox li{
    display: inline-block;
    height: 12px; line-height: 12px;
}
.loginbox li:last-child{
    
    padding-left: 10px; /* 테두리 안쪽 여백 */
    margin-left: 4px; /* 테두리 바깥쪽 여백 */
}
.loginbox a{
    /* 글자관련은 보통 최종태그에 줘야 적용 */
    color: #333; font-size: 12px;

    /* 현재 위치에서 상대적 이동 */
    position: relative; top: -2px;
}
.loginbox button{
    display: block;
    width: 220px; height: 50px;
    margin: 0 auto; /* 블록요소가 부모 영역에서 가운데 오기 */
    border: none;
    background-color: #1673ea;
    color: #fff; font-size: 14px; font-weight: bold;
}
</style>

</head>
<body>
	<div class="loginbox">
  <h2>로그인</h2>
  <form action="./login" method="post">
    <!--작성하지 않아도 문제는 없음-->
    <fieldset>
      <legend>로그인 구역</legend>
      <label for="userId">아이디</label>
      <input type="text" id="userId" name="userId" placeholder="아이디를 입력해 주세요">
      <label for="userPw">비밀번호</label>
      <input type="password" id="userPw" name="userPw" placeholder="비밀번호를 입력해 주세요">
      <ul>
        <li><a href="/member/findid">아이디찾기</a></li>
        <li><a href="/member/findpw">비밀번호찾기</a></li>
        <li><a href="/member/join">회원가입</a></li>
      </ul>
      <!--데이터를 서버로 전송-->
       <button type="submit" >로그인</button> 

      
      <br>
      <ul>
      <!--  카카오 로그인 버튼 -->
    <li><a href="https://kauth.kakao.com/oauth/authorize?client_id=afd568c5b46891ae3dde245d70d25e21&redirect_uri=http://localhost:8888/member/kakao
&response_type=code"><img src="/resources/img/kakaoLogin.png" style="height:30px"/></a></li>
 
 	   <!-- 네이버 로그인 버튼 -->	
	  
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>

<%
    String clientId = "GHbqes62pzw1QpLMxiNo";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8888/member/naver", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
         + "&client_id=" + clientId
         + "&redirect_uri=" + redirectURI
         + "&state=" + state;
    session.setAttribute("state", state);
 %>
 <li><a href="<%=apiURL%>"><img width="120px" height="30px" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a></li>
	
    </ul>
     
    </fieldset>
  </form>
</div>
<br>
<br>
<c:import url="../layout/footer.jsp"></c:import>