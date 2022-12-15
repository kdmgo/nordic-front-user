<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>(이용자) 굿즈 상세정보</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>
const contentType = 'image/png';

      $(document).ready(function () {
        const goodsNo = location.href.split('?')[1];
        console.log(goodsNo); // data
        $.ajax({
            url: "http://localhost/api/goods/" + goodsNo,
            method: "get",
            contentType : "application/json",
            data: { },
            success: function (success) {
              console.log(success.data);
              console.log(success.data.goods_name);
              var dt = success.data;

              var goods_name = $("#goods_name");
              var point = $("#point");
              var goods_desc = $("#goods_desc");
              var create_date = $("#create_date");
              var image1 = $("#image1");
              var image2 = $("#image2");
              var image3 = $("#image3");
              var image4 = $("#image4");
              var image5 = $("#image5");

              goods_name.text(dt.goods_name);
              point.text(dt.point);
              goods_desc.text(dt.goods_desc);
              create_date.text(dt.create_date);
              
              getImages(dt);

            },
            error: function (error) {
              if(error.responseJSON.message.substring(0,4) == '0002'){
                alert("없는 상품입니다");
                location.href='goods_avail.html';
              }
            },
          });

          function getImages(dt){
              var img1 = document.getElementById("image1");
              var img2 = document.getElementById("image2");
              var img3 = document.getElementById("image3");
              var img4 = document.getElementById("image4");
              var img5 = document.getElementById("image5");

              var source;
              if(dt.image1 != null){
              var im1 = `<img id="image1" src="http://localhost/api/goods/image/\${dt.image1}" onError="this.src='noimage.png'" width="300" height="300"></img><br>`;
              $("#pic").append(im1);
              }
              // else{
              // var im1 = `<img id="image1" src="default_pic_jy.jpg" onError="this.src='noimage.png'" width="100" height="100"></img><br>`;
              // $("#pic").append(im1);
              // }
              if(dt.image2 != null){
                var im2 = `<img id="image2" src="http://localhost/api/goods/image/\${dt.image2}" onError="this.src='noimage.png'" width="300" height="300"></img><br>`;
              $("#pic").append(im2);            
              }
              // else{
              // var im2 = `<img id="image2" src="default_pic_jy.jpg" onError="this.src='noimage.png'" width="100" height="100"></img><br>`;
              // $("#pic").append(im2);
              // }
              if(dt.image3 != null){
                var im3 = `<img id="image2" src="http://localhost/api/goods/image/\${dt.image3}" onError="this.src='noimage.png'" width="300" height="300"></img><br>`;
              $("#pic").append(im3);    
              }
              // else{
              // var im3 = `<img id="image3" src="default_pic_jy.jpg" onError="this.src='noimage.png'" width="100" height="100"></img><br>`;
              // $("#pic").append(im3);
              // }
              if(dt.image4 != null){
                var im4 = `<img id="image4" src="http://localhost/api/goods/image/\${dt.image4}" onError="this.src='noimage.png'" width="300" height="300"></img><br>`;
              $("#pic").append(im4);            
              }
              // else{
              // var im4 = `<img id="image4" src="default_pic_jy.jpg" onError="this.src='noimage.png'" width="100" height="100"></img><br>`;
              // $("#pic").append(im4);
              // }
              if(dt.image5 != null){
                var im5 = `<img id="image5" src="http://localhost/api/goods/image/\${dt.image5}" onError="this.src='noimage.png'" width="300" height="300"></img><br>`;
              $("#pic").append(im5);            
              }
              // else{
              // var im5 = `<img id="image5" src="default_pic_jy.jpg" onError="this.src='noimage.png'" width="100" height="100"></img><br>`;
              // $("#pic").append(im5);
              // }
          }
          
          $("#request_button").click(function () {
          // fetch
          if(!confirm("신청하시겠습니까?")){

          } else{
            var url="http://localhost/api/requests/check/" + goodsNo;
          fetch(url,{
            method: "GET",
          }).then(response => response.json())
            .then(response => {
            console.log(response);
            if(response.message.substring(0,4) == '0003'){
              throw "이미 대기중인 요청이 있습니다"
            } else{
              url = "http://localhost/api/requests/" + goodsNo;
              return fetch(url,{
                method: "POST",
                headers: {
                  'Content-Type' : 'application/json',
                }
              })
            }
          }).then(response => response.json())
            .then(response => {
              console.log("굿즈 신청 완료");
              //console.log(response.data.request_no);
              if(response.message.substring(0,4) == '0001'){
                throw "잔액이 부족합니다"
              } 
              else{
                url="http://localhost/api/points/" + response.data.request_no + "/minus";
                return fetch(url,{
                  method: "POST",
                  headers: {
                  'Content-Type' : 'application/json',
                  }
                })
              }
            })
            .then(response => response.json())
            .then(response => {
              console.log("포인트 차감 완료");
              alert("굿즈 신청이 완료되었습니다.")
            })
            .catch(error => {
                console.log(error);
                alert(error);
            });
          }


          });
      });
    </script>
    <title>Document</title>
  </head>
  <body style="width:100%">
    <div style="width:800px;" class="mx-auto">
    <button type="button" id="request_button" name="request_button" class="btn btn-dark">신청</button>
    <br><br>
    <table border="1" width="800" id="ttable">
      <caption>굿즈 상세정보(사용자)</caption>
      <tbody>
        <tr>
          <th>상품명</th>
          <td id="goods_name"></td>
        </tr>
        <tr>
          <th>포인트</th>
          <td id="point"></td>
        </tr>
        <tr>
          <th>상품설명</th>
          <td id="goods_desc"></td>
        </tr>
        <tr>
          <th>등록일</th>
          <td id="create_date"></td>
        </tr>
        <tr>
          <th>사진</th>
          <td id="pic">
            
          </td>
        </tr>
        
      </tbody>
  </table>
</div>
  </body>
</html>


