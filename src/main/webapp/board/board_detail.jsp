<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script defer src="../js/board/board_detail.js"></script>
    <link rel="stylesheet" href="../css/board/detail.css">
    <link rel="stylesheet" href="../css/header.css">
    <link rel="stylesheet" href="../css/footer.css">

    <style>
        #reply-desc {
            font-size: 10pt;
        }
    </style>

<title>노르딕워킹</title>
</head>
<body>

<header align="center">
  <h1>NORDIC WALKING</h1>
</header>

<div class="container-fluid mt-3">
<div class="container-fluid">
<div class="row">

    <div id="side-bar" class="col-2" style="font-size: 10pt;">
        <jsp:include page="../sidebar.jsp"/>
    </div>

      <div id="main-content" class="col-sm-8" style="margin-left: 50px; margin-top: -10px">
        <a id="object"></a>
        <div id="writer"></div>
        <div id="date"></div>
        <hr>
        <div id="img"></div>
        <div id="desc" style="min-height: 300px; font-size: 12pt;"></div>
        <div id="service" align="right"></div>
        <br><br><br>

        <div id="reply-write"></div>
        <div id="reply-wrap" style="font-size: 10pt;">
            <div id="reply-writer"></div>
            <div id="reply-content"></div>
        </div>
      </div>

      <div id="page-button" align="center">
      </div>

      <div id="search-bar">
        <div id="search-type"></div>
        <div id="search-keyword"></div>
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
