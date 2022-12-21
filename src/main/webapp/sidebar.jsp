<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	let token = localStorage.getItem('wtw-token') || '';
	$(document).ready(function(){
		if(token=='') {
			$("#join").css("display","block");
			$("#login").css("display","block");
			$("#logout").css("display","none");
			$("#user").css("display","none");
			$("#edit").css("display","none");
			$("#goods").css("display","none");
		} else {
			$("#join").css("display","none");
			$("#login").css("display","none");
			$("#logout").css("display","block");
			$("#user").css("display","block");
			$("#edit").css("display","block");
			$("#goods").css("display","block");
		}
	});
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<div id="side-bar" class="col-sm-2" style="font-size: 10pt;">
		<div class="list-group">
			<a id="join" class="list-group-item list-group-item-action" href="member/registerForm.jsp">회원가입</a>
			<a id="login" class="list-group-item list-group-item-action" href="login.jsp">로그인</a>
			<a id="logout" class="list-group-item list-group-item-action" href="">로그아웃</a>
			<a class="list-group-item"><b>노르딕워킹 소개</b></a> 
			<a class="list-group-item list-group-item-action" href="intro/introduce.jsp">&nbsp소개</a> 
			<a class="list-group-item list-group-item-action" href="origin/origin.jsp">&nbsp기원</a> 
			<a class="list-group-item list-group-item-action" href="board/board_main.jsp">&nbsp커뮤니티</a> 
			<a class="list-group-item list-group-item-action" href="mission/list.jsp">미션</a> 
			<a class="list-group-item list-group-item-action" href="goods/goods_avail.jsp">포인트상품</a> 
			<a id="user" class="list-group-item"><b>회원 관리</b></a> 
			<a id="edit" class="list-group-item list-group-item-action" href="member/fineOne.jsp">내 정보 수정</a>
			<a id="goods" class="list-group-item list-group-item-action" href="goods/requests_myrequests.jsp">포인트 상품 요청</a> 
		</div>
	</div>
</body>
</html>