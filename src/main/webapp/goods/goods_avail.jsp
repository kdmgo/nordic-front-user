<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>(이용자) 사용가능 굿즈</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>

    <script>
      function getAll(pageNum, keyword=""){
        console.log(pageNum);
        $.ajax({
            url: "http://localhost/api/goods/avail?keyword=" + keyword + "&pageNum=" + pageNum,
            method: "get",
            contentType : "application/json",
            data: { },
            success: function (success) {
              console.log(success.data.list);
              console.log(success.data.list.length);
              $("#list").empty();
              //$("#list").append(JSON.stringify(success.data));
              for (var i = 0; i< success.data.list.length; i++){
                var rowData = success.data.list[i];
                var goods_name = rowData.goods_name;
                var point = rowData.point;
                var image1 = rowData.image1;
                var image2 = rowData.image2;
                var image3 = rowData.image3;
                var image4 = rowData.image4;
                var image5 = rowData.image5;
                var goods_no = rowData.goods_no;

                var source;
                
                if(image1 != null){
                  source = "http://localhost/api/goods/image/" + image1;
                } else if(image2 != null){
                  source = "http://localhost/api/goods/image/" + image2;
                } else if(image3 != null){
                  source = "http://localhost/api/goods/image/" + image3;
                } else if(image4 != null){
                  source = "http://localhost/api/goods/image/" + image4;
                } else if(image5 != null){
                  source = "http://localhost/api/goods/image/" + image5;
                }
                else{
                  source = "default_pic_jy.jpg";
                }

                var sdfd = "asdfafd";
                var part1 = `  <div class="col">
    <div class="card h-100">
      <img src="\${source}" class="card-img-top" alt="..." onError="this.src='noimage.png'" width="300px;" height="200px;" onClick="location.href='goods_cont.jsp?\${goods_no}'">
      <div class="card-body">
        <h5 class="card-title"><a href="goods_cont.jsp?\${goods_no}">\${goods_name}</a></h5>
        <p class="card-text">필요 포인트 : \${point}</p>
        </div>
        </div>
      </div>`;
$("#list").append(part1);

              }
              paging(pageNum, success.data.pages, keyword);
            },
            error: function (error) {
              console.log(error);
            },
          });
      }
      function paging(pageNum, pages, keyword){
        				/* 페이징 */
				var total = pages
				var pagenation = ``;
				
				var startPage = Math.floor((pageNum-1)/10)*10 + 1;
				var endPage = startPage+9;
				
				var prev;
				if(pageNum>10) {
          var temp = startPage-1;
          console.log(temp);

          if(keyword == ""){
            prev = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onClick=getAll(\${temp},"")>Previous</a></li>`
          } else{
            prev = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${temp},"\${keyword}")>Previous</a></li>`
          }
				} else {
					prev = `<li class="page-item"><a class="page-link" href="javascript:void(0);">Previous</a></li>`
				}
				
				var pageList=``;
				var page;
				
				for(var j=0; j<=9; j++) {
					var p = startPage+j;
          if(p > total){
            break;
          }
					if (p!=pageNum) {
						
          if(keyword == ""){
            page = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${p},"")>\${p}</a></li>`;
          } else{
            page = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${p},"\${keyword}")>\${p}</a></li>`;
          }

					} else {
						page = `<li class="page-item"><a class="page-link active" href="javascript:void(0);">\${p}</a></li>`;
					}
					
					if(j==pages) {
						break;
					}
					
					pageList = pageList + page;
				}
				
				var later;
				if(endPage>total) {
          later = `<li class="page-item"><a class="page-link" href="javascript:void(0);">Next</a></li>`
				} else {
					var temp = endPage + 1;
                    console.log(temp);
					

          if(keyword == ""){
            later = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${temp},"")>Next</a></li>`
          } else{
            later = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${temp},"\${keyword}")>Next</a></li>`
          }

				}
				
				pagenation = prev+pageList+later;
				

				//$("#page").html(pagenation);
        $("#paget").html(pagenation)
      }
      function getMyPoint(){
    	  
    	  let token = localStorage.getItem('wtw-token') || '';
    	  
        $.ajax({
          url: "http://localhost/api/points/mypoint",
          method: "get",
          headers: {
		        'Authorization': `Bearer \${token}`,
		  },
          success: function(success){
            $("#mypoint").html(success.data);
          },
          error: function(error){
            console.log(error);
          }
        })
      }
      $(document).ready(function () {
        let imgTag = document.getElementById("images");
        getAll(1);
        getMyPoint();

        $("#search_button").click(function(){
              getAll(1,$("#keyword").val())
        })

      });
    </script>
    <title>Document</title>
  </head>
  <body style="width:100%">
  	<div class="container mt-5 mb-5">
		<div class="row">
			<jsp:include page="../sidebar.jsp"/>
			<div class="col-sm-10 ps-5">
				<h1>포인트 상품</h1>
				<br>	
				
	<div style="width:1200px;">

      <span>
      <input type="text" id="keyword" placeholder="검색" style="width:700px;border-radius: 20px;">
      <button type="button" id="search_button" class="btn btn-dark">검색</button>
      </span>
      <br><br>
      <div style="display: inline-block;font-weight: bold;">내포인트 : <span id="mypoint"></span></div>
      <br><br>
    <div id="list" class="row row-cols-1 row-cols-md-3 g-4" style="width:1000px;">
    </div>
    <br><br>
	<div style="width:100%">
    <nav aria-label="Page navigation example" style="margin-left:250px;">
      <ul class="pagination" id="paget">
      </ul>
    </nav>
	</div>
  </div></div></div></div>
  </body>
</html>


