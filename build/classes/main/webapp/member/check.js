function check() {

<<<<<<< HEAD
    var member_code = document.getElementById("member_code");
    var member_name = document.getElementById("member_name");
    var mobile_no = document.getElementById("mobile_no");
    var address = document.getElementById("address");
    var age = document.getElementById("age");
    var sex = document.getElementById("sex");
    var password = document.getElementById("password");
    var password2 = document.getElementById("password2");
    var availableId = document.getElementsByTagName('div')[3];

    if (member_code.value == "")  {
=======
    var member_code = document.getElementById("member_code").value;
    var member_name = document.getElementById("member_name").value;
    var mobile_no = document.getElementById("mobile_no").value;
    var address = document.getElementById("address").value;
    var age = document.getElementById("age").value;
    var sex = document.getElementById("sex").value;
    var password = document.getElementById("password").value;
    var password2 = document.getElementById("password2").value;
    var duplicateId = document.getElementsByTagName('div')[3].value;

    if (member_code == "")  {
>>>>>>> minji
        alert("아이디를 입력해주세요");
        member_code.focus();
        return false;
    }

<<<<<<< HEAD
    if (member_name.value == "") {
=======
    if (member_name == "") {
>>>>>>> minji
        alert("이름을 입력해주세요");
        member_name.focus();
        return false;
    }

<<<<<<< HEAD
    if (mobile_no.value == "") {
=======
    if (mobile_no == "") {
>>>>>>> minji
        alert("휴대폰 번호를 입력해주세요");
        mobile_no.focus();
        return false;
    }

<<<<<<< HEAD
    if (address.value == "") {
=======
    if (address == "") {
>>>>>>> minji
        alert("주소를 입력해주세요");
        address.focus();
        return false;
    }

<<<<<<< HEAD
    if (age.value == "") {
=======
    if (age == "") {
>>>>>>> minji
        alert("나이를 입력해주세요");
        age.focus();
        return false;
    }

<<<<<<< HEAD
    if (sex.value == "") {
=======
    if (sex == "") {
>>>>>>> minji
        alert("성별을 입력해주세요");
        sex.focus();
        return false;
    }

<<<<<<< HEAD
    if (password.value == "") {
=======
    if (password == "") {
>>>>>>> minji
        alert("비밀번호를 입력해주세요");
        password.focus();
        return false;
    }

<<<<<<< HEAD
    if (password2.value == "") {
=======
    if (password2 == "") {
>>>>>>> minji
        alert("비밀번호 확인을 입력해주세요");
        password.focus();
        return false;
    }

<<<<<<< HEAD
    if (password.value != password2.value) {
        alert("비밀번호가 일치하지 않습니다");
        password.value = "";
        password2.value = "";
=======
    if (password != password2) {
        alert("비밀번호가 일치하지 않습니다");
        password = "";
        password2 = "";
>>>>>>> minji
        password.focus();
        return false;
    }

<<<<<<< HEAD
    if (availableId == null) {
        alert("ID 중복 검사를 진행해주세요");
        member_code.focus();
        return false;
    }
=======
	if (sex != "남" || sex != "여") {
		alert("'남' 또는  '여' 의 값으로 입력해 주세요");
		sex = "";
		sex.focus();
		return false;
	}

>>>>>>> minji

}