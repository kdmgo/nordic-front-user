<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="../../css/header.css">
    <link rel="stylesheet" href="../../css/footer.css">
    <script defer src="../../js/main/introduce.js"></script>

  <title>노르딕워킹</title>
</head>
<body>

<header>
  <h1>NORDIC WALKING</h1>
</header>

<div class="container-fluid">
<div class="container-fluid">
<div class="row">

    <div id="side-bar" class="col-2" style="font-size: 10pt;">
        <jsp:include page="../sidebar.jsp"/>
    </div>

<div id="main-content" class="col-sm-9" style="font-size: 10pt;">

  <div id="introduce-content" style="min-width: 900px; margin-left: 100px;">
      <p id="object" style="font-size: 30pt;">INTRODUCE</p>
      <div id="img-wrap" style="border-radius: 100px"></div>
      <pre style="max-width: 900px; height: auto; min-height: 600px;">
          <p id="desc" style="white-space: pre-line;"></p>
      </pre>
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
