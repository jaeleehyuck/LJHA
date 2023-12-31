<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../layout/adminheader.jsp"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 정보게시판 글쓰기</title>

<!-- 스마트 에디터 2 로드 -->
<script type="text/javascript" src="/resources/se2/js/service/HuskyEZCreator.js"></script>

<script type="text/javascript">

$(function() {

	//작성버튼 동작
	$("#btnWrite").click(function() {
		console.log("btnWrite click")
		
		//iframe내용을 textarea에 넣어주어야 보여짐
		//작성된 내용을 <textarea>에 적용하기
		updateContents()
		//-> 이 함수 밖에 있으면 content등록 전에 작동하게 됨
		
		//폼 제출
		$("form").submit()
		
	})
	
	
	
})

function updateContents() {
	//스마트 에디터에 작성된 내용을 textarea#content에 반영한다
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", [])
}


/* '취소' 버튼 동작 */
$(document).ready(function() {
	$("#cancel").click(function() {
		history.go(-1)
	})

/* 썸네일 버튼 동작 */
	if( ${not empty infoThumb} ) {
// 		console.log(${freeFile})
		$("#originFile1").show()
	} else {
		$("#newFile1").show()
	}
	
/* 썸네일 삭제 버튼 동작 */	
	$(".deleteThumb").click(function() {
		console.log('삭제 버튼 동작');
		
		$("#originFile1").toggleClass("through");
		$("#newFile1").toggle();

		console.log( $('.thumbNo').val() )
		console.log( ${param.infoNo} )
		
		$.ajax({
			type: "get",
			dataType : "html",
			url: "http://localhost:8888/info/deleteThumb",
			data:{
				thumbNo: $('.thumbNo').val(),
				infoNo: ${param.infoNo}
				},
			success: function(data){
				console.log(data)
				alert('썸네일이 삭제되었습니다!')
				$("#originFile1").html(data)
				location.reload();
							
			}
		})
		
	})/* 썸네일 삭제 버튼 end */


	/* 첨부파일 버튼 동작 */
	if( ${not empty infoFile} ) {
// 		console.log(${freeFile})
		$("#originFile2").show()
	} else {
		$("#newFile2").show()
	}
	
/* 파일 삭제 버튼 동작 */	
	$(".deleteFile").click(function() {
		console.log('삭제 버튼 동작');
		
		var idx = $(".deleteFile").index(this)
	    var infoFileNo = $(".deleteFile").eq(idx).attr('data-no')
		
		$(".originFile2").toggleClass("through");
		$("#newFile2").toggle();

		console.log( infoFileNo )
		console.log( ${param.infoNo} )
		
		$.ajax({
			type: "get",
			dataType : "html",
			url: "/info/deleteFile",
			data:{
				infoFileNo: infoFileNo,
				infoNo: ${param.infoNo}
				},
			success: function(data){
				console.log(data)
				alert('선택한 파일이 삭제되었습니다!')
				$(".originFile2").html(data)
				location.reload();
							
			}
		})
		
	})/* 썸네일 삭제 버튼 end */
	
	
})/* 취소버튼 동작 end */

</script>

<style type="text/css">


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
	margin-bottom: 30px;
}

form {
	font-weight: bold;
}

#notice {
	border: 1px solid #ccc;
}

</style>

<div class="container">

<h1 style= "text-align: center;">정보게시판 글 수정하기</h1>

<div class="col-8 mx-auto">

<form action="./infoUpdate" method="post" enctype="multipart/form-data">

<div>
	작성자 아이디 : ${memberInfo.adminId }
</div>

<div>
	닉네임 : ${memberInfo.adminName }
</div>


<div>
말머리글 :<input type="text" id="infoState" name="infoState" class="form-control" style="width: 90px;" value="정보">
</div>


<!-- 글쓰기 폼 (웹 에디터) -->
<div class="form-group" style= "margin-top: 50px">
	<label class="form-label" for="title">제목</label>
	<input type="text" id="title" name="infoTitle" class="form-control" value="${infoContent.infoTitle}">
	<input type="hidden" id="infoNo" name="infoNo" class="form-control" value="${infoContent.infoNo}">
</div>

<div class="form-group" style= "margin-top: 50px">
	<label class="form-label" for="infoUrl">출처</label>
	<input type="text" id="infoUrl" name="infoUrl" class="form-control" value="${infoContent.infoUrl}">
</div>

<br>
파일 수정 : 
<br>		
		<c:if test="${infoThumb != null }">
		썸네일
		</c:if>
		
		<div id="originFile1">
		<c:if test="${ not empty infoThumb }">
			<a href="../upload/${infoThumb.thumbStoredName }" download="${infoThumb.thumbOriginName}">
				${infoThumb.thumbOriginName }
			</a><button class="deleteThumb btn btn-outline-warning" type="button">삭제</button><br>
			<input type="hidden" value="${infoThumb.thumbNo}" class="thumbNo" name="thumbNo">
		</c:if>
		</div>

		<div id="newFile1">
			<label class="form-label" for="files">새로운 썸네일</label>
			<input type="file" id="thumb" name="thumb" class="form-control">
		</div>
		
		<br>
	
		<c:if test="${infoFile != null }">
		첨부파일
		</c:if>
		
		<c:forEach items="${infoFile}" var="file">
		<div id="originFile2">
		<c:if test="${not empty file }">
			<a href="../upload/${file.infoStoredName }" download="${file.infoOriginName}">
				${file.infoOriginName }
			</a><button class="deleteFile btn btn-outline-warning" type="button" data-no="${file.infoFileNo}">삭제</button><br>
		</c:if>
		</div>
		</c:forEach>

		<div id="newFile2">
			<label class="form-label" for="files">새로운 첨부파일</label>
			<input type="file" id="file" name="files" class="form-control" multiple="multiple">
		</div>
	
<br>

<!-- 글쓰기 작성, 취소 버튼 -->
<div style="text-align: center; margin-bottom: 30px;">
	<button class="btn btn-success" id="btnWrite">수정 완료</button>
	<input type="reset" id="cancel" class="btn btn-danger" value="취소">
</div>

</form>

</div>

</div><!-- container end -->

<!-- 웹에디터 연결 -->
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors
	, elPlaceHolder: "content"
	, sSkinURI: "/resources/se2/SmartEditor2Skin.html"
	, fCreator: "createSEditor2"
})
</script>



<c:import url="../layout/footer.jsp"></c:import>
