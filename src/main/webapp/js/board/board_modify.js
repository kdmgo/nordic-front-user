let sel_files = [];
let board_no;
let update_member;
let create_member;
let pre_Img;
let image_no;

window.onload = function () {
    let board = JSON.parse(localStorage.getItem('board'));
    console.log(board);
    let dataList = board.data;
    console.log(dataList)
    let data = board.data[0];
    console.log(data)

    board_no = data.board_no;
    create_member = data.create_member;
    update_member = create_member;

    let title = data.board_object;
    let desc = data.board_desc;
    let reply_yn = data.reply_yn;

    $("#board_object").val(title)
    $("#content").val(desc)
    $("input[name=reply_yn]:radio[value='" + reply_yn +"']").attr('checked', 'checked');

    let index = 1;
    for (let i = 0; i < dataList.length; i++) {
        if(dataList[i].image_use_yn == 'Y') {
            let imgData = dataList[i]
            pre_Img = imgData.orignal_name;
            image_no = imgData.board_image_no;

            let html = "<div id=\'uploadImg"+ index + "\'>" +
                "<button type='button' onclick=\"deleteImg("+ image_no +","+index+")\" " +
                "class=\"btn btn-danger btn-sm\" style=\"font-size: 5pt;\">X</button>" +
                "<span>&nbsp" + pre_Img + "</span></div>"
            $("#imgList").append(html)

            index++;

        }
    }
}

function deleteImg(no, index) {
    console.log('deleteImg, image_no - ' + no)
    console.log('deleteImg, id index - ' + index)

    $.ajax({
        method: 'DELETE',
        url: 'http://localhost:80/api/img/' + update_member + '/' + no,
        beforeSend: (xhr) => {
            let answer = confirm('정말 삭제하시겠습니까?');
            if(!answer) xhr.abort();
        }
        ,
        success: (data) => {
            console.log(data)
            alert('삭제완료!')

            $('#uploadImg' + index).empty();
        }
    });
}

function submitAction() {

    let formData = new FormData();
    let data = {
        "board_no"     : board_no,
        "board_object" : $("#board_object").val(),
        "board_desc"   : $("#content").val(),
        "reply_yn"     : $("input[name=reply_yn]:checked").val(),
        "create_member": create_member,
        "update_member": update_member
    }
    console.log(data)

    formData.append("board", new Blob([JSON.stringify(data)] , {type : "application/json"}));
    for(let i = 0; i < $("#input_imgs")[0].files.length; i++) {
        formData.append("files", $("#input_imgs")[0].files[i]);
    }

    $.ajax({
        type: "PUT",
        url: "http://localhost:80/api/board/" + board_no,
        contentType: false,
        processData: false,
        enctype: "multipart/form-data",
        data: formData,
        dataType: "json",
        success: (result) => {
            console.log(result)

            alert("수정완료!");
            history.back();
        }
    });
}