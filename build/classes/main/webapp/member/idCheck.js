function idCheck(){

    var member_code = document.getElementById("member_code").value;

	if (member_code.length < 3 ) {
        alert("아이디를 3자 이상 입력해주세요");
		document.getElementById("member_code").value = "";
		$("#duplicateId").empty();
        return false;
    }

	if (member_code.length > 10) {
		alert("아이디를 10자 이하로 입력해주세요");
		return false;
	}

    fetch ("http://localhost:80/api/member/registerForm/idCheck/"+member_code, {
        method: "GET"
    })
    .then (response => response.json())
    .then((response) => {
        if (response.data == 1) {   // 중복 데이터 있음
            $("#duplicateId").empty();
            document.getElementById("duplicateId").style.color = "red"
            $("#duplicateId").append("이미 존재하는 아이디입니다.");
            // console.log(duplicateId);
            document.getElementById("member_code").value = "";

        } else if ( response.data == 2 ) {  // 데이터를 찾지 못함
            $("#duplicateId").empty();
            document.getElementById("duplicateId").style.color = "blue"
            $("#duplicateId").append("사용 가능한 아이디입니다.");
            //console.log(duplicateId);
        } else if (response.data == null) {
            alert("아이디를 입력해주세요");
        }

    })
    .catch (error => {
        console.log(error);
        alert("에러가 발생했습니다.");
    });

}