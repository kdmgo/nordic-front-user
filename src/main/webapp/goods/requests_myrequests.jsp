<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>(이용자) 내 요청</title>
        <link href="<%=request.getContextPath()%>/goods/hidden_text.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>


    <script>
      function cancelRequest(request_no){
        if(!confirm("요청을 취소하시겠습니까?")){
        } else{
        	let token = localStorage.getItem('wtw-token') || '';
        $.ajax({
          url: "http://localhost/api/requests/" + request_no,
          method: "delete",
          headers: {
		        'Authorization': `Bearer \${token}`,
		  },
          success: function(success){
            console.log(success);
            if(success.message.substring(0,4) == '0004'){
              alert("이미 취소된 요청입니다")
            } else if(success.message.substring(0,4) == '0005'){
              alert("이미 지급 또는 거절된 요청입니다")
            } else{
              alert("취소되었습니다")
            }
          },
          error : function(error){
            console.log(error);
          }
        })
      }
      }
      function getAll(pageNum){
    	let token = localStorage.getItem('wtw-token') || '';
        var url = "http://localhost/api/requests/my?pageNum=" + pageNum;

        $.ajax({
            url: url,
            method: "get",
            contentType : "application/json",
            headers: {
 		        'Authorization': `Bearer \${token}`,
 		    },
            data: { },
            success: function (success) {
              
              console.log(success.data.pages);
              console.log(success.data.list);
              console.log(success.data.list.length);
              $("#gbody").empty();
              var tbody = document.getElementsByTagName("tbody")[0];
              
              //$("#list").append(JSON.stringify(success.data));
              for (var i = 0; i< success.data.list.length; i++){
                var tbody = document.getElementsByTagName("tbody")[0];
                var rowData = success.data.list[i];

                var request_no = rowData.request_no;
                var goods_name = rowData.goods_name;
                var use_yn = rowData.use_yn;
                var remark = rowData.remark;
                var create_date = rowData.create_date;
                var confirm_yn = rowData.confirm_yn;
                var refuse_yn = rowData.refuse_yn;
                var update_date = rowData.update_date;
                var point = rowData.point;

                var tdRequestNo = document.createTextNode(request_no);
                var tdGoodsName = document.createTextNode(goods_name);
                var tdUseYn = document.createTextNode(use_yn);
                var tdRemark = document.createTextNode(remark);
                var tdCreateDate = document.createTextNode(create_date);
                var tdConfirmYn = document.createTextNode(confirm_yn);
                var tdRefuseYn = document.createTextNode(refuse_yn);
                var tdUdateDate = document.createTextNode(update_date);
                var tdPoint = document.createTextNode(point);
                var request_button = document.createElement("input");
                request_button.setAttribute("type","button");
                request_button.setAttribute("value","취소");
                request_button.setAttribute("onClick","cancelRequest(" + request_no +")");
                request_button.setAttribute("style","width:100px;height:40px;")

                var tr = document.createElement("tr");

                var td1 = document.createElement("td");
                var td2 = document.createElement("td");
                var td3 = document.createElement("td");
                var td4 = document.createElement("td");
                var td5 = document.createElement("td");
                var td6 = document.createElement("td");
                var td7 = document.createElement("td");
                var td8 = document.createElement("td");
                var td9 = document.createElement("td");
                var td10 = document.createElement("td");

                td1.appendChild(tdRequestNo);
                td2.appendChild(tdGoodsName);
                td3.appendChild(tdUseYn);
                td4.appendChild(tdRemark);
                td5.appendChild(tdCreateDate);
                td6.appendChild(tdConfirmYn);
                td7.appendChild(tdRefuseYn);
                td8.appendChild(tdUdateDate);
                td9.appendChild(tdPoint);
                td10.append(request_button);

                tr.appendChild(td1);
                tr.appendChild(td2);
                tr.appendChild(td3);
                tr.appendChild(td4);
                tr.appendChild(td5);
                tr.appendChild(td6);
                tr.appendChild(td7);
                tr.appendChild(td8);
                tr.appendChild(td9);
                tr.appendChild(td10);

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
          prev = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onClick=getAll(\${temp})>Previous</a></li>`
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
            page = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${p})>\${p}</a></li>`;
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
          later = `<li class="page-item"><a class="page-link" href="javascript:void(0);" onclick=getAll(\${temp}")>Next</a></li>`
				}
				
				pagenation = prev+pageList+later;
				

				$("#paget").html(pagenation);
      }
      
      $(document).ready(function () {
        getAll(1);
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
      <table  style="text-align:center; width: 100%"
								class="mt-3 table table-hover">
        <thead style="text-align: center;">
            <th>요청번호</th>
            <th>상품명</th>
            <th>사용여부</th>
            <th>리마크</th>
            <th>요청일시</th>
            <th>확인여부</th>
            <th>거절여부</th>
            <th>확인날짜</th>
            <th>포인트</th>
            <th>요청취소</th>
        </thead>
        <tbody id="gbody" style="text-align: center;">

        </tbody>
    </table>
    <div style="width:100%">
    <nav aria-label="Page navigation example" style="margin-left:300px;">
      <ul class="pagination" id="paget">
      </ul>
    </nav>
    </div>
</div></div></div></div>
  </body>
</html>