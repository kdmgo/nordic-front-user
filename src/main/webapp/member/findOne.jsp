<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>내 정보 수정</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
/********************* 회원정보수정 폼 *********************/
function doModifyForm(member_code) {

    // var member_code = document.getElementById("memberCode").value;
    var url = "http://localhost/api/member/modifyForm/";
    
    let token = localStorage.getItem('wtw-token') || '';

    fetch( url+member_code , {
        method: "GET",
        mode:'cors',
        headers: {
            'Content-Type' : 'application/json',
            'Authorization' : `Bearer \${token}`
        }
    })

    .then(response => response.json())
    .then(response => {

        var memKeys = Object.keys(response.data);
        var memValues = Object.values(response.data);
        
        if(memValues[12] == 'Y') { memValues[12] = '관리자' } 
        else if (memValues[12] == 'N') { memValues[12] = '일반 회원'}
        
        var data2 =
        ` 
        <div id="modifyFormWrapper">
        <form method="put" id="frmData">
            <br>
            
            <div id="idgroup" class="row">
                <div class="col" id="indexArea" style="width:300px;">
                    아이디
                </div>
                <div class="col" id="inputArea">
                    <input type="text" class="form-control" id="member_code" name="member_code" value="\${memValues[0]}" readOnly>
                </div>
                <div class="col"></div>
            </div><br>
            
            <div id="pwgroup" class="row">
                <div class="col" id="indexArea">
                    비밀번호
                </div>
                <div class="col" id="inputArea">
                    <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요" maxlength="16">
                </div>
                <div class="col"></div>
            </div><br>
            
            <div id="namegroup" class="row">
                <div class="col" id="indexArea">
                    이름
                </div>
                <div class="col" id="inputArea">
                    <input type="text" class="form-control" id="member_name" name="member_name" value="\${memValues[1]}">
                </div>
                <div class="col"></div>
            </div><br>
            
            <div id="mobilegroup" class="row">
                <div class="col" id="indexArea">
                    휴대폰
                </div>
                <div class="col" id="inputArea">
                    <input type="text" class="form-control" id="mobile_no" name="mobile_no" value="\${memValues[2]}">
                </div>
                <div class="col"></div>
            </div><br>
            
            <div id="mobilegroup" class="row">
                <div class="col" id="indexArea">
                    주소
                </div>
                <div class="col" id="inputArea">
                    <input type="text" class="form-control" id="address" name="address" value="\${memValues[3]}">
                </div>
                <div class="col"></div>
            </div><br>
            
            <div id="sexgroup" class="row">
                <div class="col" id="indexArea">
                    성별
                </div>
                <div class="col" id="inputArea">
                    <input type="text" class="form-control" id="sex" name="sex" value="\${memValues[5]}">
                </div>
                <div class="col"></div>
            </div><br>
            
            <div id="agegroup" class="row">
                <div class="col" id="indexArea">
                    나이
                </div>
                <div class="col" id="inputArea">
                    <input type="text" class="form-control" id="age" name="age" value="\${memValues[4]}">
                </div>
                <div class="col"></div>
            </div><br>
            
            <div id="createdategroup" class="row">
            <div class="col" id="indexArea">
                가입일자
            </div>
            <div class="col" id="inputArea">
                <input type="text" class="form-control-plaintext" id="create_date" name="create_date" value="\${memValues[19]}" disabled>
            </div>
            <div class="col"></div>
        </div><br>

        <div id="admin_yngroup" class="row">
            <div class="col" id="indexArea">
                등급
            </div>
            <div class="col" id="inputArea">
                <input type="text" class="form-control-plaintext" id="admin_yn" name="admin_yn" value="\${memValues[12]}" disabled>
            </div>
            <div class="col"></div>
        </div>
            <br>
            <table class="table table-borderless w-auto"><tr><td>
                <button type="button" class="btn btn-dark btn-sm" onClick="doModify()"> 수정 </button></td>
                <td><button class="btn btn-outline-danger btn-sm" onClick="doDelete(${member_code})">탈퇴</button></td>
            </td></table>
        </table>
        </form>
        </div>
        `;
        
        document.getElementById("modifyFormArea").innerHTML = data2;

    })
    .catch (error => {
        console.log(error);
        alert("에러입니다");
    })

} // doModifyForm end

/********************* 회원정보삭제 *********************/
 function doDelete(member_code) {

     var url = "http://localhost/api/member/del/user/";

     if (confirm("정말 탈퇴 하시겠습니까?")) {

         if (confirm("탈퇴 후 동일 아이디로 재가입 할 수 없습니다.")) {
             $(function (){
                $.ajax ({
                    type : "post",
                    url : url + member_code,
                    data : member_code,
                    success : function(result) {
                        alert("탈퇴가 완료되었습니다.")
                    }
                }); // 
            }); // ajax end
        }

    } // if end
} // doDelete end

/********************* 회원정보수정 실행 *********************/
function doModify() {
    
    var member_code = document.getElementById("member_code").value;
    var member_name = document.getElementById("member_name").value;
    var mobile_no = document.getElementById("mobile_no").value;
    var address = document.getElementById("address").value;
    var age = document.getElementById("age").value;
    var sex = document.getElementById("sex").value;
    var password = document.getElementById("password").value;

    if (password == "") {

        alert("비밀번호를 변경해주세요");
        return false;

    } else if (password != "" ) {
    
        var url1 = "http://localhost/api/member/modify/";
        var data1 = $("#frmData").serialize();

        $(function() {
        
            $.ajax({
                type : "post",
                url : url1 + member_code,
                data : data1,
                success : function(result) {
                    alert("회원정보수정 완료!");
                    location.reload();
                }
            }); // ajax end
            
        }); // jQuery function end
    } // if end

} // doModify end

</script>
<style>

	#wrapper { 
    	width: 1200px;
    	margin: auto;
    }
    
    #indexArea {
        text-align: right;
        font-size: large;
        font-weight:550;
        width:300px;
    }
    
    #findOneTitle {
        font-size:xx-large;
        text-align: right;
        margin-top: 30px;
        margin-bottom: 80px;
    }
    
/*     #modifyFormArea {
    	width:auto;
        float:none;
        margin-left: 20px;
    } */
    
    #inputArea {
        width: 600px;
    }
    
    #member_code {
        background-color: rgb(248, 248, 248);
        border-color: rgb(208, 208, 208);
        color:darkgray;
        width:500px;
    }
    
    #password {width:500px;}
    #member_name {width:500px;}
    #address {width:500px;}
    #mobile_no {width:500px;}
    #sex {width:500px;}
    #age {width:500px;}
    #create_date {width:500px;}
    #admin_yn {width:500px;}
    
    table { margin:auto; margin-top:10px;}
    
</style>
<body>
<div class="container mt-5 mb-5">
<div class="row">
<jsp:include page="../sidebar.jsp"></jsp:include>
<div class="col-sm-10 ps-5">

<script>doModifyForm(10001)</script>

<div id="wrapper" style="width:90%;">

	<div class="container text-center h-auto">
        <div class="row">
          <div class="col" id="findOneTitle">
            내 정보 수정
          </div>
          <div class="col">
          </div>
          <div class="col">
          </div>
        </div>
      </div>
      
</div>

<div id="modifyFormArea"></div>

</div></div></div>
</body>
</html>