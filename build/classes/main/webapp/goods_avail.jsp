<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>
      function getAll(pageNum){
        console.log(pageNum);
        $.ajax({
            url: "http://localhost/api/goods/avail?pageNum=" + pageNum,
            method: "get",
            contentType : "application/json",
            data: { },
            success: function (success) {
              console.log(success.data.list);
              console.log(success.data.list.length);
              $("#gbody").empty();
              //$("#list").append(JSON.stringify(success.data));
              for (var i = 0; i< success.data.list.length; i++){
                var rowData = success.data.list[i];
                var goods_name = rowData.goods_name;
                var point = rowData.point;
                var image1 = rowData.image1;
                var goods_no = rowData.goods_no;

                var tdGoodsName = document.createTextNode(goods_name);
                var tdPoint = document.createTextNode(point);
                var tr = document.createElement("tr");
                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var cont_button = document.createElement("button");

                const image = new Image();
                if(image1 != null){
                  image.src = "http://localhost/api/goods/image/" + image1;
                } else{
                  image.src = "default_pic_jy.jpg";
                }
                
                image.width = 100;
                image.height = 100;
                td1.appendChild(tdGoodsName);
                td2.appendChild(tdPoint);
                td3.appendChild(image);
                cont_button.setAttribute("type","button");
                cont_button.setAttribute("value","상세정보보기");
                cont_button.setAttribute("onClick","location.href='goods_cont.jsp?" + goods_no + "'");
                cont_button.setAttribute("style","width:100px;height:40px;")
                
                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(cont_button);

                var tbody = document.getElementsByTagName("tbody")[0];

                tbody.appendChild(tr);
              }
              paging(pageNum, success.data.pages);
            },
            error: function (error) {
              console.log(error);
            },
          });
      }
      function paging(pageNum, pages){
        				/* 페이징 */
				var total = pages
				var pagenation = ``;
				
				var startPage = Math.floor((pageNum-1)/10)*10 + 1;
				var endPage = startPage+9;
				
				var prev;
				if(pageNum>10) {
          var temp = startPage-1;
          console.log(temp);
					prev = `<a onclick=getAll(` + temp + `)>[이전]</a>`
				} else {
					prev = `<a>[이전]</a>`
				}
				
				var pageList=``;
				var page;
				
				for(var j=0; j<=9; j++) {
					var p = startPage+j;
					
					if (p!=pageNum) {
						page = `<span><a onclick=getAll(` + p + `)> ` + p + ` </a></span>`	
					} else {
						page = `<span><b> ` + p + ` </b></span>`	
					}
					
					if(j==pages) {
						break;
					}
					
					pageList = pageList + page;
				}
				
				var later;
				if(endPage>total) {
					later = `<a>[다음]</a>`
				} else {
					var temp = endPage + 1;
                    console.log(temp);
					later = `<a onclick=getAll(` + temp + `)>[다음]</a>`
				}
				
				pagenation = prev+pageList+later;
				

				$("#page").html(pagenation);
      }
      
      $(document).ready(function () {
        let imgTag = document.getElementById("images");
        getAll(1);
      });
    </script>
    <title>Document</title>
  </head>
  <body>

      <table border="1" width="1000">
        <thead>
            <th>상품명</th>
            <th>포인트</th>
            <th>상품사진</th>
            <th>상세정보</th>
        </thead>
        <tbody id="gbody">

        </tbody>
    </table>
    <div id="page"></div>

  </body>
</html>