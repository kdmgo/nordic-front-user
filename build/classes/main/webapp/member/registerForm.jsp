<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>회원가입</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>

</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="check.js"></script>
<script src="idCheck.js"></script>
<script>

    function doRegister() {
    	
     	check();
    	
        var member_code = document.getElementById("member_code").value;
        var member_name = document.getElementById("member_name").value;
        var mobile_no = document.getElementById("mobile_no").value;
        var address = document.getElementById("address").value;
        var age = document.getElementById("age").value;
        var sex = document.getElementById("sex").value;
        var password = document.getElementById("password").value;
        var duplicateId = document.getElementsByTagName('div')[3];
        
        var url = "http://localhost/api/member/register";
    
        let formData = new FormData();
        
        formData.append("member_code", member_code);
        formData.append("member_name", member_name);
        formData.append("mobile_no", mobile_no);
        formData.append("address", address);
        formData.append("age", age);
        formData.append("sex", sex);
        formData.append("password", password);
        
        var register2 = 
        `	<center>
            <h1>회원가입이 완료 되었습니다!</h1><br>
            <button type="button" class="btn btn-dark" onClick="location.href='login.jsp' ">로그인</button>
            </center>
        `;

        $.ajax ({
            type : "post",
            url : url,
            data : formData,
            processData : false,
            contentType: false,
            success : function(result) {
                console.log(result);
                alert("회원가입 완료!");
                $("#registerTitle").empty();
                $("#register").empty();
                document.getElementById("registerResult").innerHTML = register2;
            },
            error : function(request, status, error) {
                // alert(request.responseJSON.error);
                console.log(request);
                console.log(request.responseJSON.error);
            }
        }); // ajax end

    }

</script>
<style>

    table {
        margin:auto;
    }
    div {
        margin:auto;
    }

    #register {
        width:auto;
        float:none;
        margin-left: 20px;
    }

    #registerTitle {
        font-size:xx-large;
        text-align: right;
        margin-top: 30px;
        margin-bottom: 80px;
    }

    #inputArea, #duplicateId {
        width: 600px;
    }
    
    #indexArea {
        text-align: right;
        font-size: large;
        font-weight:550;
    }
    
    #wrapper {
    	width:1200px;
    }
    
    #member_code {width:500px;}
    #password {width:500px;}
    #password2 {width:500px;}
    #member_name {width:500px;}
    #address {width:500px;}
    #mobile_no {width:500px;}
    #sex {width:500px;}
    #age {width:500px;}

</style>
<body>
<div class="container mt-5 mb-5">
<div class="row">
<jsp:include page="../sidebar.jsp"></jsp:include>
<div class="col-sm-10 ps-5">
<div id="wrapper" style="width:90%;">
    <div class="container text-center">
        <div class="row">
          <div class="col" id="registerTitle">
            회원가입
          </div>
          <div class="col">
          </div>
          <div class="col">
          </div>
        </div>
      </div>

    <div id="register">
		<!-- <form method="post" id="frmData" onSubmit="return check()"> -->
        
        <!-- 아이디 영역 -->
        <div id="idgroup" class="row">

            <!-- 중복검사 메시지 영역 -->
            <div class="col" id="indexArea"></div>
            <div class="col" id="duplicateId" style="text-align:center;"></div>
            <div class="col"></div>
            <div class="w-100"></div>
            
            <div class="col" id="indexArea">
              <font color="red">*</font>  아이디
            </div>
            <div class="col" id="inputArea">
                <input class="form-control" type="text" id="member_code" name="member_code" placeholder="3 ~ 10 자로 입력해주세요" minlength="3" maxlength="10">
            </div>
            <div class="col">
                <button type="button" class="btn btn-dark" id="btnIdchk" onClick="idCheck()" style="text-align: left;">중복</button>
            </div>
        </div>
<br>
        <!-- 비밀번호 영역 -->
        <div id="pwgroup" class="row">
            
            <div class="col" id="indexArea">
           <font color="red">*</font>     비밀번호
            </div>
            <div class="col" id="inputArea">
                <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요" maxlength="16">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 비밀번호 확인 영역 -->
        <div id="pwgroup" class="row">
            
            <div class="col" id="indexArea">
             <font color="red">*</font>   비밀번호 확인
            </div>
            <div class="col" id="inputArea">
                <input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호가 일치해야 합니다" maxlength="16">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 이름 영역 -->
        <div id="namegroup" class="row">
            
            <div class="col" id="indexArea">
             <font color="red">*</font>   이름
            </div>
            <div class="col" id="inputArea">
                <input type="text" class="form-control" id="member_name" name="member_name" placeholder="이름을 입력해주세요" maxlength="10">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 휴대폰 영역 -->
        <div id="mobilegroup" class="row">
            
            <div class="col" id="indexArea">
             <font color="red">*</font>   휴대폰
            </div>
            <div class="col" id="inputArea">
                <input type="text" class="form-control" id="mobile_no" name="mobile_no" placeholder="휴대폰 번호를 숫자만 입력해주세요" minlength="11" maxlength="11">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 주소 영역 -->
        <div id="mobilegroup" class="row">
            
            <div class="col" id="indexArea">
           <font color="red">*</font>     주소
            </div>
            <div class="col" id="inputArea">
                <input type="text" class="form-control" id="address" name="address" placeholder="주소를 입력해주세요" minlength="10">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 성별 영역 -->
        <div id="sexgroup" class="row">
            
            <div class="col" id="indexArea">
          <font color="red">*</font>      성별
            </div>
            <div class="col" id="inputArea">
                <input type="text" class="form-control" id="sex" name="sex" placeholder="성별을 입력해주세요" minlength="1">
            </div>
            <div class="col"></div>
        </div>
<br>
        <!-- 나이 영역 -->
        <div id="mobilegroup" class="row">
            
            <div class="col" id="indexArea">
         <font color="red">*</font>       나이
            </div>
            <div class="col" id="inputArea">
                <input type="number" class="form-control" id="age" name="age" placeholder="나이를 입력해주세요" maxlength="2" oninput="maxLengthChk(this)">
            </div>
            <div class="col"></div>
        </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script>
        	function maxLengthChk(object) {
        		if (object.value.length > object.maxLength) {
        			object.value = object.value.slice(0, object.maxLength);
        		}
        	}
        </script>

        <table class="table table-borderless w-auto">
            <tr><td><br><br>
                <button id="rgstBtn" class="btn btn-dark" onClick="doRegister()" >회원가입</button>
            </td></tr>
        </table>
        <!-- </form> -->
    </div>
    <div id="registerResult"></div>
</div>
</div>
</div>
</div>
</body>
</html>