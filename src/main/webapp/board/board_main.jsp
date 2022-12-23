<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script defer src="../js/board/board_main.js"></script>
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/board/main.css">
    <link rel="stylesheet" href="../css/footer.css">
    <script src="../js/board/board_main.js"></script>
    <title>노르딕워킹</title>
</head>
<body>

<header class="header">
    <h1>NORDIC WALKING</h1>
</header>

<div class="container">
<div class="container">
<div class="row">

        <jsp:include page="../sidebar.jsp"/>

<div id="main-content" class="col-9" style="min-height: 800px;">
    <div id="img"></div>
    <div id="board-content"></div>
    <br><br><br>
    <div id="reply_count"></div>
</div>

<div id="write-button" class="col-9" align="right">
    <a href="board_write.jsp" class="btn btn-dark btn-sm">글쓰기</a>
    <br><br>
</div>

<div id="page-button" align="center">
    <ul class="pagination pagination-sm justify-content-center" style="margin:20px 0" id="pagination"></ul>
</div><br><br><br>


<div id="search-bar">
<div class="row justify-content-center">
    <select id="search-type" class="form-select form-select-sm" style="width: 100px;">
        <option class="searchType" value="title">제목</option>
        <option class="searchType" value="content">내용</option>
        <option class="searchType" value="titleAndContent">제목+내용</option>
        <option class="searchType" value="writer">작성자</option>
    </select>&nbsp&nbsp

        <input type="text" name="search-content" class="form-control"
               placeholder="검색어를 입력하세요." style="width: 200px; font-size: 10pt"/>&nbsp
        <button type="button" class="btn btn-dark btn-sm" onclick="search()" style="width: 60px;">검색</button>
</div>
</div>

</div>
</div>
</div>


<footer align="center">
    서비스 이용약관 | 개인정보 보호정책 | 청소년 보호정책<br>
    Copyright <strong>©노르딕워킹</strong> All rights reserved.
</footer>
</body>
</html>
