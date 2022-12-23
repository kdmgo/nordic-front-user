<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script defer src="../js/board/board_modify.js"></script>
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/footer.css">
    <link rel="stylesheet" href="../css/board/modify.css">


    <title>노르딕워킹</title>
</head>
<body>

<header>
    <h1>NORDIC WALKING</h1>
</header>

<div class="container">
<div class="container">
<div class="row">

        <jsp:include page="../sidebar.jsp"/>

<div id="main-content" class="col-9" style="margin-left: 50px;">
    <h1>게시글 수정</h1>
    <hr style="width: 900px;">

    <div id="modify-content" style="width: 900px; min-height: 1200px; display: flex;">

        <form id="files" enctype="multipart/form-data">
            <label class="form-label">제목</label>
            <input id="board_object" class="form-control" name="board_object" type="text"
                   style="width: 700px; font-size: 10pt">
            <br>
            <label class="form-label">내용</label>
            <textarea id="content" class="form-control" rows="25" cols="70"
                      name="board_desc" style="resize: none; font-size: 10pt"></textarea>
            <br>
            댓글허용
            <input type="radio" name="reply_yn" value="Y" checked="checked"> 허용
            <input type="radio" name="reply_yn" value="N"> 불가
            <br><br><br>

            <div id="input_wrap">
                <label class="form-label">이미지</label>
                <input type="file" class="form-control form-control-sm" id="input_imgs" accept="image/*" multiple/>
            </div>
            <br>
            <div class="img-wrap">
                <img id="img"/>
            </div>
            <br><br>

            <label class="form-label">이전 업로드 목록</label>
            <div id="imgList">
            </div>
            <br><br>

            <button type="button" class="btn btn-dark btn-sm" onclick="submitAction()">수정하기</button>
        </form>

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
