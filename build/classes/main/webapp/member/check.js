function check() {

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
        alert("아이디를 입력해주세요");
        member_code.focus();
        return false;
    }

    if (member_name == "") {
        alert("이름을 입력해주세요");
        member_name.focus();
        return false;
    }

    if (mobile_no == "") {
        alert("휴대폰 번호를 입력해주세요");
        mobile_no.focus();
        return false;
    }

    if (address == "") {
        alert("주소를 입력해주세요");
        address.focus();
        return false;
    }

    if (age == "") {
        alert("나이를 입력해주세요");
        age.focus();
        return false;
    }

    if (sex == "") {
        alert("성별을 입력해주세요");
        sex.focus();
        return false;
    }

    if (password == "") {
        alert("비밀번호를 입력해주세요");
        password.focus();
        return false;
    }

    if (password2 == "") {
        alert("비밀번호 확인을 입력해주세요");
        password.focus();
        return false;
    }

    if (password != password2) {
        alert("비밀번호가 일치하지 않습니다");
        password = "";
        password2 = "";
        password.focus();
        return false;
    }


}