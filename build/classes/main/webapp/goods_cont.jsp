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
              
              const firstImage = new Image();
              const secondImage = new Image();
              const thirdImage = new Image();
              const fourthImage = new Image();
              const fifthImage = new Image();


              if(dt.image1 != null)
              firstImage.src = "http://localhost/api/goods/image/" + dt.image1;
              else
              firstImage.src = "default_pic_jy.jpg";
              if(dt.image2 != null)
              secondImage.src = "http://localhost/api/goods/image/" + dt.image2;
              else
              secondImage.src = "default_pic_jy.jpg";
              if(dt.image3 != null)
              thirdImage.src = "http://localhost/api/goods/image/" + dt.image3;
              else
              thirdImage.src = "default_pic_jy.jpg";
              if(dt.image3 != null)
              fourthImage.src = "http://localhost/api/goods/image/" + dt.image4;
              else
              fourthImage.src = "default_pic_jy.jpg";
              if(dt.image3 != null)
              fifthImage.src = "http://localhost/api/goods/image/" + dt.image5;
              else
              fifthImage.src = "default_pic_jy.jpg";


              firstImage.width = 100; secondImage.width=100; thirdImage.width=100; fourthImage.width=100; fifthImage.width=100;
              firstImage.height = 100; secondImage.height = 100; thirdImage.height = 100; fourthImage.height = 100; fifthImage.height = 100;
              image1.append(firstImage); image2.append(secondImage); image3.append(thirdImage); image4.append(fourthImage); image5.append(fifthImage);

            },
            error: function (error) {
              console.log(error);
            },
          });


          $("#request_button").click(function () {
          // fetch
          var url = "http://localhost/api/requests/" + goodsNo;
          fetch(url, {
            method: "POST",
            headers: {
            'Content-Type' : 'application/json',
            }
          }).then(response => response.json())
            .then(response => {
              console.log("굿즈 신청 완료");
              console.log(response.data.request_no);
              url="http://localhost/api/points/" + response.data.request_no + "/minus";
              return fetch(url,{
                method: "POST",
                headers: {
                'Content-Type' : 'application/json',
                }
              })
            })
            .then(response => response.json())
            .then(response => {
              console.log("포인트 차감 완료");
            })
            .catch(error => {
                console.log(error);
                alert(error);
            });

          });
      });
    </script>
    <title>Document</title>
  </head>
  <body>
    <input type="button" id="request_button" name="request_button" value="신청"/>

    <table border="1" width="1000">
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
          <th>사진1</th>
          <td id="image1"></td>
        </tr>
        <tr>
          <th>사진2</th>
          <td id="image2"></td>
        </tr>
        <tr>
          <th>사진3</th>
          <td id="image3"></td>
        </tr>
        <tr>
          <th>사진4</th>
          <td id="image4"></td>
        </tr>
        <tr>
          <th>사진5</th>
          <td id="image5"></td>
        </tr>
      </tbody>
  </table>
  </body>
</html>


