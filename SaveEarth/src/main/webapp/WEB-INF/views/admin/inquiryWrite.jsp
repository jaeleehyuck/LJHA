<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../layout/adminheader.jsp"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 상품등록</title>

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
}

form {
	font-weight: bold;
}

#freeHead {
	border: 1px solid #ccc;
}

</style>

<div class="container"></div>

<h1 style= "text-align: center;">문의 답변</h1>

<div class="col-8 mx-auto">

<form action="./inquiryWrite" method="post">


<div class="form-group" style= "margin-top: 50px">
	<label class="form-label" for="inqAnswerContent">답변 내용</label>
	<input type="text" id="inqAnswerContent" name="inqAnswerContent" class="form-control">
	<input type="hidden" id="inqNo" name="inqNo" value="${inqNo }">
</div>


<button class="btn btn-success" id="btnWrite">작성</button>
</form>


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
