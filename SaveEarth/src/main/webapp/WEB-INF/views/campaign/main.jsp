<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../layout/header.jsp"/>

<!-- 풀캘린더 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>


<style type="text/css">

.campimage {
	position: relative;
}

.camp {
	position: absolute;
	top: 38%; 
	left: 45%; 
/* 	transform: translate(-50%, -50%);  */
	color: #fff; 
	font-weight: bold;
	font-size: 50px;
    font-family: 'KBO-Dia-Gothic_bold';
}


@font-face {
    font-family: 'KBO-Dia-Gothic_bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/KBO-Dia-Gothic_bold.woff') format('woff');
    font-weight: 700;
    font-style: normal;
}

@font-face {
    font-family: 'omyu_pretty';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/omyu_pretty.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

#wrapCalendar {
	width: 1000px;
	margin: 0 auto;
}

#calName {
	text-align: center;
	font-weight: bold;
	font-size: 2em;
	padding: 40px;
}

#line {
	width: 1700px;
	margin: 0 auto;
}

#navButton  {  
  	margin-left: 30px;  
	margin-top: 20px;  
 	width: 100px;  
}  

.nav { 
 	margin-left: 100px; 
 	margin-bottom: 50px; 
} 


.search { 
 	text-align: center; 
 	margin-left: 925px;
 	display: flex;
    align-items: flex-end;
 } 

/* 검색창 스타일 */
.search_input {
   width: 300px;
   height: 30px;
   font-size: 18px;
   border-radius: 8px;
   border: 1px solid #bbb;
}

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
  	margin-left: 5px;
 } 

 .search_icon { 
 	width: 20px; 
 	height: 20px; 
 	margin-bottom: 3px; 
 } 

#camp {
  width: 225px;
  text-align: center;
  display: block;
  margin-left:10px;
  margin-right: 10px;
  margin-bottom: 80px;
  
}

#campTitle {
	font-size: 1.5em;
	font-weight: bold;
}

#campTag {
	text-decoration: none;
	color: inherit;
}

.btnModal {
	width: 0;
	height: 0;
	display: none;
}

label {
	font-weight: bold;
}

#previewWrap {
	text-align: center;
    margin: 10px 0px;
}

.all {
	background-color: #198754;
	color: white;
}

.warnMsg {
	font-size: 0.8em;
	color: #3788D8;
}


#calendarImport {
	font-family: 'omyu_pretty';
}

#campList {
	font-family: 'omyu_pretty';
}

#staticBackdrop {
	font-family: 'omyu_pretty';
}

#viewModal {
	font-family: 'omyu_pretty';
}

</style>


<script type="text/javascript">

//페이징 변수 선언
var curPage = ${paging.curPage};
var totalCount = ${paging.totalCount};
var totalPage = ${paging.totalPage};
var listCount =${paging.listCount};
var pageCount = ${paging.pageCount};
var startPage = ${paging.startPage};
var endPage = ${paging.endPage};
var startno = ${paging.startNo};
var endno = ${paging.endNo};
var state = "전체";

//인증날짜 변수 선언
var today = new Date();
var year = today.getFullYear();
var month = ('0' + (today.getMonth() + 1)).slice(-2);
var day = ('0' + today.getDate()).slice(-2);
var dateString = year + '-' + month  + '-' + day;

$(function(){
	
	//캠페인 상태 버튼 ajax
	$(".preface").click(function() {
		console.log("test")
		console.log($(this).html())
		
		$(".preface").css({
			"background-color" : "white",
			"color" : "#198754"
		})
		
		$(this).css({
			"background-color" : "#198754",
			"color" : "white"
		})
		
		state = $(this).html()
		
		$.ajax({
			type: "post"
			, url : "./preface"
			, data : {state : state}
			, dataType : "html"
			, success : function(res) {
				console.log('성공')
				$("#campListJsp").html(res)
			}
			, error : function() {
				console.log('실패')
				
			}
		})

	})
	
	
	
	//페이징 숫자
	$(document).on("click", ".number", function() {
      
		curPage = $(this).html();
			console.log("페이징 넘버", curPage)
			
			$.ajax({
			   type: "post"
			   , url: "./preface"
			   , data:  {state : state, curPage : curPage}
			   , dataType: "html" 
			   , success: function( res ) {
			      console.log("AJAX 성공 , 페이징 숫자버튼")
			      $("#campListJsp").html(res)
			   }
			   , error: function() {
			      console.log("AJAX 실패")
			   }
			})
		})

		
	//페이징 첫 페이지
	$(document).on("click", ".first", function() {
		curPage = 1
	     
		console.log(" 페이징 첫페이지 및 curpage", curPage)
	     
	     
		$.ajax({
	        type: "post"
	        , url: "./preface"
	        , data:  {state : state, curPage : curPage}
	        , dataType: "html" 
	        , success: function( res ) {
	           console.log("AJAX 성공, 페이징 첫페이지")
	           $("#campListJsp").html(res)
	        }
	        , error: function() {
	           console.log("AJAX 실패")
	        }
		})
	     
	})
	   
	
	//페이징 마지막 페이지
	$(document).on("click", ".end", function() {
		curPage = totalPage;
	   
		console.log("엔드페이지", curPage);
	   
		$.ajax({
			type: "post"
		   , url: "./preface"
		   , data:  {state : state, curPage : curPage}
		   , dataType: "html" 
		   , success: function( res ) {
		      console.log("AJAX 성공, 페이징 첫페이지")
		      $("#campListJsp").html(res)
		   }
		   , error: function() {
		      console.log("AJAX 실패")
		   }
		})
	   
	})
   
   
})


//인증글 작성 중 검사
$(function() {
	
	$("#partTitle").blur(function() {
		
		if($(this).val() == "") {
			$("#titleMsg").html("필수 입력요소입니다.")
		} else {
			$("#titleMsg").html("")
		}
		
	})
	
	$("#partContent").blur(function() {
		
		if($(this).val() == "") {
			$("#contentMsg").html("필수 입력요소입니다.")
		} else {
			$("#contentMsg").html("")
		}
		
	})
	
	$("#partFile").blur(function() {
		
		if($(this).val() == "") {
			$("#fileMsg").html("필수 입력요소입니다.")
		} else {
			$("#fileMsg").html("")
		}
		
	})
	
	$("#partDate").blur(function() {
		
		if($(this).val() == "") {
			$("#dateMsg").html("필수 입력요소입니다.")
		} else {
			$("#dateMsg").html("")
		}
		
	})
	
})


//인증글 제출 전 검사
function validate() {
	
	if($("#partTitle").val() == "") {
		$("#titleMsg").html("제목을 입력해주세요.")
		return false;
	} else {
		$("#titleMsg").html("")
	}
	
	if($("#partContent").val() == "") {
		$("#contentMsg").html("내용을 입력해주세요.")
		return false;
	} else {
		$("#contentMsg").html("")
	}

	if($("#partDate").val() == "") {
		$("#dateMsg").html("날짜를 선택해주세요.")
		return false;
	} else if($("#partDate").val() > dateString) {
			$("#dateMsg").html("미래는 선택할 수 없습니다.")
		return false;
	} else {
		$("#dateMsg").html("")
	}
	
	if($("#partFile").val() == "") {
		$("#fileMsg").html("첨부파일이 없습니다.")
		return false;
	} else {
		("#fileMsg").html("")
	}
	

	
}


//작성하기 버튼 클릭시 유효성 검사
$(function() {
	
	$("#btnWrite").click(function() {
		
		if(!validate()) {
			return false
		}
		
	})
	
})


//인증글 첨부파일 미리보기
function readURL(input){
	
	 $("#fileMsg").html('')
	
	
	if (input.files && input.files[0]) {
		
		var reader = new FileReader();
	    reader.onload = function(e) {
			document.getElementById('preview').src = e.target.result;
	    };
		reader.readAsDataURL(input.files[0]);
		
	} else {
	    document.getElementById('preview').src = "";
	}
}







</script>

<script type="text/javascript">

//인증글 버튼 클릭 모달
const myModal = document.getElementById('insertModal')
const myInput = document.getElementById('myInput')

myModal.addEventListener('shown.bs.modal', () => {
  myInput.focus()
})


</script>



<div>
	<img class="campimage" src="../resources/img/camp.png" style="width: 100%; height: 500px;">
	<h1 class="camp">캠페인게시판</h1>
</div>	
	
	
<div id="wrapCalendar" >

<!-- 	<div id="calName">나의 달력</div> -->
	
	<div id="calendarImport" style="margin-top: 80px; margin-bottom: 40px;">
	
		<c:import url="./calendar.jsp"></c:import>
	
	</div>
	
</div>


<!-- 인증글 작성 모달 -->
<div id="writeModal" style="height: 0; width: 0;">

<!-- Button trigger modal -->
<button id="btnWriteModal" type="button" class="btn btn-primary btnModal" data-bs-toggle="modal" data-bs-target="#staticBackdrop"></button>


<!-- Modal -->
<div class="modal fade insertModal" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
    	<div class="modal-content">
    
    		<form id="partForm" action="./main" method="post" enctype="multipart/form-data">
    		
		    <!-- Modal Header -->
			<div class="modal-header">
		        <h5 class="modal-title" id="staticBackdropLabel">인증글 작성하기</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>	<!-- close 클릭시 modal 한번 더 띄위기 -->
			</div>
		      
		      
		    <!-- Modal Body -->  
		    
			<div class="modal-body">
				<div class="form-group">
					<label for="partNo">참여할 캠페인</label>
					<select id="partNo" class="form-control" name="campNo">
						<c:forEach var="campaign" items="${ingList }">
						<option value="${campaign.campNo }">${campaign.campTitle }</option>
						</c:forEach>
					</select>
				</div>
				<br>
				<div class="form-group">
					<label for="partTitle">제목</label>
					<input type="text" class="form-control" id="partTitle" name="partTitle" placeholder="제목을 입력하세요">
					<span id="titleMsg" class="warnMsg"></span>
				</div>
				<br>
				<div class="form-group">
					<label for="partContent">내용</label>
					<input type="text" class="form-control" id="partContent" name="partContent" placeholder="내용을 입력하세요">				
					<span id="contentMsg" class="warnMsg"></span>
				</div>
				<br>
				<div class="form-group">
					<label for="partDate">인증일</label>
					<input type="date" class="form-control" id="partDate" name="partDate">	
					<span id="dateMsg" class="warnMsg"></span>			
				</div>
				<br>
				<div class="form-group">
					<label for="partFile">첨부파일</label>
					<input type="file" class="form-control" id="partFile" name="partFile" onchange="readURL(this);" accept="image/gif, image/jpeg, image/png">
					<span id="fileMsg" class="warnMsg" ></span>
					<div id="previewWrap"><img id="preview" style="height: 200px;"/></div>
				</div>
				<div>
					<input type="hidden" name="userNo" value="${loginNo }">	<!-- 회원번호 -->
				</div>
			</div>
			
			
			<!-- Modal Footer -->
			<div class="modal-footer" id="btnWrap">
		        <button type="button" class="btn btn-secondary" id="btnCancel" data-bs-dismiss="modal" >취소하기</button>
		        <button type="submit" class="btn btn-primary" id="btnWrite">작성하기</button>
			</div>
			</form>
		</div>
	</div>
</div>


</div>


<!-- 인증글 목록 모달 -->
<div  id="viewModal" style="height: 0; width: 0;">

<!-- Button trigger modal -->
<button id="btnViewModal" type="button" class="btn btn-primary btnModal" data-bs-toggle="modal" data-bs-target="#exampleModal"></button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
    
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">나의 인증글</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="viewModalBody">
        작성된 인증글이 없습니다.
      </div>
    </div>
  </div>
</div>



</div>


<div id="line"><hr></div>

<div id="campList">
	<div class="nav">
		<button id="navButton" type="button" class="btn btn-outline-success preface all">전체</button>
		<button id="navButton" type="button" class="btn btn-outline-success preface">진행중</button>
		<button id="navButton" type="button" class="btn btn-outline-success preface">마감</button>

	</div>
	
<div id="campListJsp">
	<c:import url="./campList.jsp"/>
</div>

</div>

<c:import url="../layout/footer.jsp"/>
