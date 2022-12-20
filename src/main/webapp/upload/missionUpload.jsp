<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="../css/header.css">
<link rel="stylesheet" href="../css/footer.css">
<style>
.image-preview {
	margin-top: 30px;
}

	input[type=file]::file-selector-button {
		width: 150px;
		height: 30px;
		background: #fff;
		border: 1px solid rgb(77, 77, 77);
		border-radius: 10px;
		cursor: pointer; &: hover { background : rgb( 77, 77, 77);
		color: #fff;
	}
}
</style>
<body>
	<header>
		<h1>NORDIC WALKING</h1>
	</header>
	<div class="container mt-5 mb-5 ">
		<div class="row justify-content-center mx-auto col-10">
			<div class="d-flex mt-3 mx-auto justify-content-center border border-dark p-5" style="height: 700px">
				<div class="col-5">
					<div id="info"></div>
					<p>[ 예시 사진  ]</p>
					<div id="img"></div>
					<br>
				</div> 
				<div id="user" class="col-6 text-center">
					<div>
						<form enctype="multipart/form-data" id="frm">
							<input type="file" class="real-upload ms-5" id="real-upload" accept="image/*">
							<input type="button" onclick="" id="btn" class="btn btn-dark">
							<input type="button" onclick="" id="btn2" class="btn btn-dark" value="삭제" style="display: none">
						</form>
					</div>
				
					<div class="image-preview">
						<img src="" id="imgPreview" width="350px">
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	var mission_no = 386;
	<%-- var mission_no = <%=request.getParameter("mission_no")%> --%>
	let token = localStorage.getItem('wtw-token') || '';
	
	$(document).ready(function(){
		init();
	});
	
	function init() {
		$.ajax({
			type : "GET",
			url : "http://localhost:80/api/mission/result/"+mission_no,
			headers: {
 		        'Authorization': `Bearer \${token}`,
 		    },
			success: function(data) {
				console.log(data);
				var master = data.data.master;
				var image = data.data.master_img;
				var history = data.data.history_img;
				
				if(history==null) {
					$("#btn").val('등록')
					$("#btn").attr('onclick',"imgUpload('POST')")
				} else {
					var img = history.confirm_file;
					
					$("#btn").val('수정')
					$("#btn").attr('onclick',"imgUpload('PUT')")
					$("#imgPreview").attr('src',
							'http://localhost:80/api/admin/mission/result/image/'+img+'?path=mission');
					
					$("#btn2").css("display","");
					$("#btn2").attr('onclick',"imgUpload('DELETE')")
				}
				
				$("#frm").append(btn);
				
				var mission_detail = `
					<h3><b>미션명</b> : \${master.mission_name}</h3>
				`
				$("#info").append(mission_detail);
				
				/* 미션 이미지 파일*/
				var mission_image = ``;
				var m_img = ``;
				
				if(image.confirm_file.startsWith('{')) {
					var file_name = JSON.parse(image.confirm_file);
					var name = file_name.picture;
					
					var jsonObjKey = [];
					var jsonObjVal = [];
					
					for(var i=0; i<name.length; i++){
					    jsonObjKey.push(Object.keys(name[i])[0]);
					    jsonObjVal.push(name[i][Object.keys(name[i])[0]]);
					    
					    m_img = `
					    	<img src="http://localhost:80/api/mission/image/\${jsonObjVal[i]}?path=missionmaster" class="me-1 col-5 mb-1"
					    		onerror="this.src='http://localhost:80/api/mission/image/error.png?path=mission';">
					    `
					    mission_image = mission_image + m_img;
					};
				} else {
					m_img = `
						<img src="http://localhost:80/api/mission/image/\${image.confirm_file}path=missionmaster" width="400px"
							onerror="this.src='http://localhost:80/api/mission/image/error.png?path=mission';">
					`
					mission_image = mission_image + m_img;
				}
				
				$("#img").append(mission_image);
			}, error: function(data) {
				location.href = "../login.jsp"
			}
		});
	}
	
	function imgUpload(btn_type) {
		console.log(btn_type);
		
		var img = $("#real-upload")[0].files[0];
		var formData = new FormData();
		formData.append('file',img);
		
		$.ajax({
			type : btn_type,
			url : "http://localhost:80/api/mission/result/"+mission_no,
			data : formData,
			headers: {
 		        'Authorization': `Bearer \${token}`,
 		    },
			contentType: false,
			processData: false,
			enctype: "multipart/form-data",
			success: function(data) {
				console.log(data);

				if(data.message == "미션 사진 등록 성공") {
					alert("사진 등록 성공");
				} else if(data.message == "미션 사진 수정 성공") {
					alert("사진 수정 성공");
				} else if(data.message == "미션 사진 삭제 성공") {
					alert("사진 삭제 성공");
				}

				location.reload();
			},
			error: function(data) {
				if(data.responseJSON.message.includes('마감')) {
					alert("마감기한이 지난 미션은 수정, 삭제 할 수 없습니다.")
				} else {
					alert("사진을 등록하세요");
				}
			}
		});
	}	
	
	function imgUpdate() {
		console.log("업데이트");
	}
	
	function getImageFiles(e) {
		const file = e.target.files[0];
		console.log(file);
		
		const imagePreview = document.querySelector('.image-preview');
		const docFrag = new DocumentFragment();
		
		if (!file.type.match("image/.*")) {
			alert("이미지 파일만 업로드가 가능합니다.");
			document.getElementById("real-upload").value = null;
			
			return;
		}
		
		const reader = new FileReader();
		reader.onload = (e) => {
			const preview = createElement(e, file);
		};
		
		reader.readAsDataURL(file);
	}
		
	function createElement(e,file) {
		const imgPreview = document.getElementById('imgPreview');
		imgPreview.setAttribute('src',e.target.result);
	}
	
	const realUpload = document.querySelector('.real-upload');
	realUpload.addEventListener('change', getImageFiles);
	
</script>

<footer align="center">
	서비스 이용약관 | 개인정보 보호정책 | 청소년 보호정책<br> Copyright <strong>©노르딕워킹</strong>
	All rights reserved.
</footer>

</body>
</html>