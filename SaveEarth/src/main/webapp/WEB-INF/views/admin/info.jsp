<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:import url="../layout/adminheader.jsp"/>
<style type="text/css">
/* 여백 없애기 */
body {
   margin:0;
   padding: 0;
}

/* 게시판 메인 이미지 스타일 */
.freeimage {
   /* 이미지랑 네비게이션바 띄우기 */
   position: relative;
   width: 100%;
   height: 500px;
}

/* 이미지 안에 자유게시판 문구 스타일 */
.free {
   position: absolute;
   top: 38%;
   left: 45%;
   color: #fff;
   font-weight: bold;
   font-size: 50px;
   font-family: 'KBO-Dia-Gothic_bold';
}


/* 검색창 스타일 */
input {
   width: 100%;
   border: 1px solid #bbb;
   border-radius: 8px;
   font-size: 14px;
}

/* '자유게시판'문구 폰트 스타일 */
@font-face {
   font-family: 'KBO-Dia-Gothic_bold';
   src:
      url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/KBO-Dia-Gothic_bold.woff')
      format('woff');
      
   font-weight: 700;
   font-style: normal;
}

h1 {
   margin-top:50px;
   color: black;
   font-weight: bold;
   font-size: 50px;
   font-family: 'KBO-Dia-Gothic_bold';
}

/* 말머리글 (드롭다운) 크기 늘리기 */
select {
   width:100px;
}

.head {
   padding-left: 1200px;
   padding-top: 50px;
   
}

/* 검색 전체 div태그 스타일 */
.search {
   text-align: center;
   width: 100%;
   height: 100px;
}

/* 검색창 스타일 */
.search_input {
   width: 300px;
   height: 30px;
   font-size: 18px;
   border: 1px solid #ccc;
}

/* 검색창 버튼 스타일 */
.search_btn {
   font-size: 18px;
   border: none;
   background-color: green;
   width: 50px;
   height: 30px;
   border-radius: 15px;
   color: #fff;
   cursor: pointer;
   vertical-align: middle;
}

/* 검색아이콘 이미지 */
.search_icon {
   margin-top:3px;
   margin-bottom:3px;
   width: 20px;
   height: 20px;
}

/* 게시판 목록 */
#board {
   width:1300px;
   
   margin-top: 100px;
   
   margin-left:auto;
   margin-right:auto;
   
   text-align: center;
}
/* 게시글 분류 전체(div) 스타일 */
.nav { 
    margin: 0 auto; 
    width: fit-content;
    
 } 
 
.nav2{
    margin: 0 auto;
    margin-left: 1400px;
}
 
  /* 게시판 분류 버튼 스타일 */
.nav button {  
  	margin-left: 40px;  
	margin-top: 60px;  
 	width: 300px;  
  }  

/* 글쓰기 버튼 스타일 */
#write {
	text-align: right;
	margin-right: 100px;
	margin-bottom: 20px;
}

/* 정보게시판 버튼 스타일 */
#infobtn {
	margin-left: 10px;
}

/* 캠페인 게시판 버튼 스타일 */
#campbtn {
	margin-left: 10px;
}

/* '정보게시판' 문구 스타일 */
h1 {
	text-align: center;
	margin-bottom: 30px;
}

/* 썸네일 스타일 */
#info {
	margin-left: 10px;
    width: 225px;
    text-align: center;
    display: block;
    margin-left: 10px;
    margin-right: 10px;
    margin-bottom: 65px;
}

a{ text-decoration: none; } /* 링크텍스트에 밑줄없앰 */
button{ cursor: pointer; } /* 모든 버튼에 마우스손모양 처리 */

</style>


<script type="text/javascript">
$(document).ready(function() {
   $("#btnList").click(function() {
      location.href = "/admin/campagign"
   })
   
   $("#btnDelete").click(function() {
      location.href = "./campaignDelete?campNo=${view.CAMP_NO}"
   })
})
</script>

<div class="nav">
<h1>게시판 관리</h1>
</div>


<br>
<div class="nav">
<a href="./free"><button type="button" class="btn btn-outline-success" id ="freebtn">자유 게시판</button></a>
<a href="./info"><button type="button" class="btn btn-success" id ="infobtn">정보 게시판</button></a>
<a href="./campaign"><button type="button" class="btn btn-outline-success" id ="campbtn">캠페인 게시판</button></a>
</div> 

<br> <br>

<!-- <h1>정보게시판</h1> -->

  	<div id="infoList" class="row">
		<div class="col-1"></div>
		
		<div id="infos" class="row col-10">
		
			<c:forEach var="infoList" items="${infoList }" begin="0" end="2">
			<div id="info" class="col">
			<a href="./infoView?infoNo=${infoList.INFO_NO }" id="infoNo">
				<c:if test="${infoList.THUMB_STORED_NAME ne null }">
					<div><img alt="" src="/upload/${infoList.THUMB_STORED_NAME }" style="width: 400px; height: 300px;"></div>
				</c:if>
				<c:if test="${infoList.THUMB_STORED_NAME eq null }">
					<div><img alt="" src="" style="width: 400px; height: 300px;"></div>
				</c:if>
				<div id="infoTitle">
					<span id="title">[${infoList.INFO_TITLE }]</span>
				</div>
			</a>
			</div>
			</c:forEach>
			
		</div>
		<div class="col-1"></div>
</div>

  	<div id="infoList" class="row">
		<div class="col-1"></div>
		
		<div id="infos" class="row col-10">
		
			<c:forEach var="infoList" items="${infoList }" begin="3" end="5">
			<div id="info" class="col">
			<a href="./infoView?infoNo=${infoList.INFO_NO }" id="infoNo">
				<c:if test="${infoList.THUMB_STORED_NAME ne null }">
					<div><img alt="" src="/upload/${infoList.THUMB_STORED_NAME }" style="width: 400px; height: 300px;"></div>
				</c:if>
				<c:if test="${infoList.THUMB_STORED_NAME eq null }">
					<div><img alt="" src="" style="width: 400px; height: 300px;"></div>
				</c:if>
				<div id="infoTitle">
					<span id="title">${infoList.INFO_TITLE }</span>
				</div>
			</a>
			</div>
			</c:forEach>
			
		</div>
		<div class="col-1"></div>
</div>

<div class="nav2">
<!-- 글쓰기 버튼 -->
   <a href = "/admin/infoWrite"><button type="button" class="btn btn-outline-success">글쓰기</button></a>
</div>

<%-- <span class="float-end mb-3">${paging.totalCount }</span> --%>
<div class="clearfix"></div>

<div>
   <ul class="pagination pagination-sm justify-content-center">

   <%-- 첫 페이지로 이동 --%>
   <c:if test="${paging.curPage ne 1 }">
      <li class="page-item"><a href="./info" class="page-link">&larr; 처음</a></li>   
   </c:if>
   
   <%-- 이전 페이징 리스트로 이동 --%>
   <c:choose>
   <c:when test="${paging.startPage ne 1 }">
      <li class="page-item"><a href="./info?curPage=${paging.startPage - paging.pageCount }" class="page-link">&laquo;</a></li>
   </c:when>
   <c:when test="${paging.startPage eq 1 }">
      <li class="page-item disabled"><a class="page-link">&laquo;</a></li>
   </c:when>
   </c:choose>
   
   
   <%-- 이전 페이지로 가기 --%>
   <c:if test="${paging.curPage > 1 }">
      <li class="page-item"><a href="./info?curPage=${paging.curPage - 1 }" class="page-link">&lt;</a></li>
   </c:if>
   
   
   
   
   <%-- 페이징 리스트 --%>
   <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="i">
   <c:if test="${paging.curPage eq i }">
      <li class="page-item active"><a href="./info?curPage=${i }" class="page-link">${i }</a></li>
   </c:if>
   <c:if test="${paging.curPage ne i }">
      <li class="page-item"><a href="./info?curPage=${i }" class="page-link">${i }</a></li>
   </c:if>
   </c:forEach>
   

   
   
   <%-- 다음 페이지로 가기 --%>
   <c:if test="${paging.curPage < paging.totalPage }">
      <li class="page-item"><a href="./info?curPage=${paging.curPage + 1 }" class="page-link">&gt;</a></li>
   </c:if>
   
   <%-- 다음 페이징 리스트로 이동 --%>
   <c:choose>
   <c:when test="${paging.endPage ne paging.totalPage }">
      <li class="page-item"><a href="./info?curPage=${paging.startPage + paging.pageCount }" class="page-link">&raquo;</a></li>
   </c:when>
   <c:when test="${paging.endPage eq paging.totalPage }">
      <li class="page-item disabled"><a class="page-link" href="./info?curPage=${paging.totalPage }">&raquo;</a></li>
   </c:when>
   </c:choose>

   <%-- 끝 페이지로 이동 --%>
   <c:if test="${paging.curPage ne paging.totalPage }">
      <li class="page-item"><a href="./info?curPage=${paging.totalPage }" class="page-link">끝 &rarr;</a></li>   
   </c:if>
   
   </ul>
</div>

<c:import url="../layout/footer.jsp"/>