<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
	<div id="side-bar" class="col-sm-2" style="font-size: 10pt;">
		<div class="list-group">
			<a class="list-group-item list-group-item-action"
				href="<%=request.getContextPath()%>/member/registerForm.jsp">회원가입</a> <a
				class="list-group-item list-group-item-action" href="<%=request.getContextPath()%>/login.jsp">로그인</a>
			<a class="list-group-item"><b>메인</b></a> <a
				class="list-group-item list-group-item-action"
				href="<%=request.getContextPath()%>/intro/introduce.jsp">노르딕워킹 소개</a> <a
				class="list-group-item list-group-item-action"
				href="<%=request.getContextPath()%>/origin/origin.jsp">노르딕워킹 기원</a> <a class="list-group-item"><b>커뮤니티
			</b></a> <a class="list-group-item list-group-item-action"
				href="<%=request.getContextPath()%>/board/board_main.jsp">사진 커뮤니티</a> <a class="list-group-item"><b>미션
					관리</b></a> <a class="list-group-item list-group-item-action"
				href="<%=request.getContextPath()%>/mission/list.jsp">미션 목록 </a> <a class="list-group-item"><b>굿즈
					관리</b></a> <a class="list-group-item list-group-item-action"
				href="<%=request.getContextPath()%>/goods/goods_avail.jsp">구매가능한 굿즈</a> <a
				class="list-group-item list-group-item-action"
				href="<%=request.getContextPath()%>/goods/requests_myrequests.jsp">내 굿즈 요청</a> <a
				class="list-group-item"><b>회원 관리</b></a> <a
				class="list-group-item list-group-item-action"
				href="<%=request.getContextPath()%>/member/fineOne.jsp">내 정보 수정</a>

		</div>
	</div>
</body>
</html>