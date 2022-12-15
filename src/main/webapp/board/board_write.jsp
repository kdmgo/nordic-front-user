<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/footer.css">

    <title>노르딕워킹</title>
</head>
<body>

<header>
    <h1>NORDIC WALKING</h1>
</header>

<script defer>
    let id = 'SYSTEM'

    function writeBoard() {
        console.log('write')

        let formData = new FormData();
        let board = {
            "board_object": $('#board_object').val(),
            "board_desc": $('#board_desc').val(),
            "board_group": '게시판',
            "reply_yn": $('input[name=reply_yn]:checked').val(),
            "create_member": id
        }
        console.log(board)

        formData.append("board", new Blob([JSON.stringify(board)], {type: "application/json"}))
        for (let i = 0; i < $('#files')[0].files.length; i++) {
            formData.append('files', $('#files')[0].files[i])

        }

        $.ajax({
            type: 'POST',
            url: 'http://localhost:80/api/board',
            contentType: false,
            processData: false,
            enctype: 'multipart/formdata',
            data: formData,
            success: (result) => {
                console.log(result);

                localStorage.setItem('result', JSON.stringify(result));
                location.href = 'board_detail.jsp';
            }
        })
    }

</script>

<div class="container-fluid mt-3">
<div class="container-fluid">
<div class="row">

    <div id="side-bar" class="col-2" style="font-size: 10pt;">
        <div class="list-group">
            <a class="list-group-item list-group-item-action" href="../../intro/user/introduce.jsp">소개</a></li>
            <a class="list-group-item list-group-item-action" href="../../origin/user/origin.jsp">기원</a></li>
            <a class="list-group-item" style="font-weight: bolder">게시판</a></li>
        </div>
    </div>

<div id="main-content" class="col-sm-9">
    <h2>게시글 작성</h2>
    <hr>

    <div class="col-sm-7">
        <form enctype="multipart/form-data">
            <input class="form-control" id="board_object" type="text" placeholder="제목을 입력하세요."><br>
            <textarea class="form-control" id="board_desc" placeholder="내용을 입력하세요." style="min-height: 500px; resize: none"></textarea><br>
            <input type="file" id="files" accept="image/*" class="form-control" multiple><br><br>
                <img id="image-container"><br>
            <strong>댓글허용<br></strong>
            <input type="radio" name="reply_yn" value="Y" checked> 허용
            <input type="radio" name="reply_yn" value="N"> 불가<br><br><br>
                <button type="button" onclick="writeBoard()" class="btn btn-dark">작성하기</button>
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
