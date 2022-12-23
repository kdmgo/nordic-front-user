let result = JSON.parse(localStorage.getItem('result'));
let page;

if(localStorage.getItem('page') != null) {
    page = localStorage.getItem('page');
}

let board = result.data;
console.log(result);
console.log(page);
/*
//let token = localStorage.getItem("wtw-token") || '';*/
let id = localStorage.getItem("member_code");
let board_no = board[0].board_no;
console.log(board_no);
let object = board[0].board_object;
let writer = board[0].create_member;
let date = board[0].create_date;
let desc = board[0].board_desc;
let reply_yn = board[0].reply_yn;


window.onload = function () {
$('#object').append(object);
$('#writer').append(writer);
$('#date').append(date);
$('#desc').append('<pre>' + desc +'</pre>');

if(writer == id) {
    let html =
        "<a href=\'board_modify.jsp\' onclick=\'modifyBoard()\' style=\'text-decoration: none; color: black;\'>수정</a>&nbsp" +
        "<a href=\'javascript:;\' onclick=\'delBoard("+board_no+")\' style=\'text-decoration: none; color: black;\'>삭제</a>"
    $('#service').append(html)
}

for (let i = 0; i < board.length; i++) {
    let img_yn = board[i].image_use_yn;
    if (img_yn == 'Y') {
        let image = board[i].image_file;
        let img = image.substr(image.lastIndexOf('/') + 1);

        let html = '<img style=\"margin-bottom: 30px;\" id=\"board-img\" src=\"http://localhost:80/api/img/' + img + '\">';
        console.log(html);
        $('#img').append(html);
    }
}

if(reply_yn == 'Y') {
    let html = '<textarea id=\"reply-desc\" placeholder=\"&nbsp댓글을 작성해주세요.\"></textarea>&nbsp' +
               '<button class=\"btn btn-dark\" id=\"btn-reply\" onclick=\"replyWrite()\">작성</button>'
    $('#reply-write').append(html);

    $.ajax({
        type: 'GET',
        url: 'http://localhost:80/api/board/' + board_no + '/replies',
        success: (result) => {
            let data = result.data;
            console.log(data);

            if (data.length == 0) {
                let html = "<br><br>&nbsp&nbsp작성된 댓글이 없습니다.";
                $('#reply-wrap').append(html);

            } else {
                let index = 1;
                for (let i = 0; i < data.length; i++) {
                    let writer = data[i].create_member;
                    let date = data[i].create_date;
                    let desc = data[i].reply_desc;
                    let use_yn = data[i].remark;

                    if(use_yn == '삭제') {
                        $('#reply-wrap').append('<table id=\"reply-table\">' +
                            '<td style=\"font-size: 10pt\">'+'삭제된 댓글입니다.'+'</td></table>');

                    } else {
                        if(writer == id) {
                            let reply_no = data[i].reply_no;
                            console.log(reply_no);
                            let html =
                                '<table id=\"reply-table\"><tr><td style=\"font-size: 10pt\">' + writer + '<br>' + '' +
                                '<span style=\"font-size: 8pt\">' + date + '</span>' +'</td>' +
                                '<td align="right">' +
                                '<a id=\"delReply\" href=\"javascript:;\" onclick=\"delReply(' + reply_no + ')\">삭제&nbsp</a>' +
                                '<a id=\"modiReply' + index + '\" href=\"javascript:;\" class=\"modiReply\" ' +
                                'onclick=\"modiReply('+index+ ',' + reply_no + ')\">수정</a></td></tr>' +
                                '<tr><td id=\"ReplyText' + index + '\"style=\"font-size: 11pt\"><pre>' + desc + '</pre></td></tr></table>';

                            $('#reply-wrap').append(html);

                        } else {
                            let html = '<table><tr><td style=\"font-size: 10pt\">' + writer + '<br>' + '' +
                                '<span style=\"font-size: 8pt\">' + date + '</span>' +'</td></tr>' +
                                '<tr><td><pre>' + desc + '</pre></td></tr></table>';

                            $('#reply-wrap').append(html);
                        }
                    }
                    index++;
                }
            }
        }
    })
} else {
    let html = "<a style=\'font-size: 10pt; font-weight: bold;\'>댓글을 작성할 수 없습니다.</a>"
    $('#reply-write').append(html)
}
}

function replyWrite() {
let desc = $('#reply-desc').val();

let reply = {
    "board_no": board_no,
    "reply_desc": desc,
    "create_member": id
}

$.ajax({
    type: 'POST',
    url: 'http://localhost:80/api/board/' + board_no + '/reply',
    data: reply,
    header: {
        'Authorization': `Bearer \${token}`
    },
    success: (result) => {
        $('#reply-wrap').empty();

        let data = result.data;
        if (data.length == 0) {
            $('#reply-wrap').append('작성된 댓글이 없습니다.');

        } else {
            let index = 1;
            for (let i = 0; i < data.length; i++) {
                let writer = data[i].create_member;
                let date = data[i].create_date;
                let desc = data[i].reply_desc;
                let use_yn = data[i].remark;

                if(use_yn == '삭제') {
                    $('#reply-wrap').append('<table id=\"reply-table\">' +
                        '<td style=\"font-size: 10pt\">'+'삭제된 댓글입니다.'+'</td></table>');

                } else {
                    if(writer == id) {
                        let reply_no = data[i].reply_no;
                        console.log(reply_no);
                        let html =
                            '<table id=\"reply-table\"><tr><td style=\"font-size: 10pt\">' + writer + '<br>' + '' +
                            '<span style=\"font-size: 8pt\">' + date + '</span>' +'</td>' +
                            '<td align="right">' +
                            '<a id=\"delReply\" href=\"javascript:;\" onclick=\"delReply(' + reply_no + ')\">삭제&nbsp</a>' +
                            '<a id=\"modiReply' + index + '\" href=\"javascript:;\" class=\"modiReply\" ' +
                            'onclick=\"modiReply('+index+ ',' + reply_no + ')\">수정</a></td></tr>' +
                            '<tr><td id=\"ReplyText' + index + '\"style=\"font-size: 11pt\"><pre>' + desc + '</pre></td></tr></table>';

                        $('#reply-wrap').append(html);

                    } else {
                        let html = '<table><tr><td style=\"font-size: 10pt\">' + writer + '<br>' + '' +
                            '<span style=\"font-size: 8pt\">' + date + '</span>' +'</td></tr>' +
                            '<tr><td><pre>' + desc + '</pre></td></tr></table>';

                        $('#reply-wrap').append(html);
                    }

                }
                index++;
            }
        }
    }
})
}

function delReply(reply_no) {
console.log('delReply');
let data = {
    "reply_no": reply_no,
    "update_member": id
}
console.log(data)

$.ajax({
    type: 'DELETE',
    url: 'http://localhost:80/api/board/' + board_no + '/reply',
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify(data),
    dataType: 'json',
    header: {
        'Authorization': `Bearer \${token}`
    },
    beforeSend: (xhr) => {
        let choice = confirm('댓글을 삭제하시겠습니까?');
        if(!choice) xhr.abort();
    },
    success: (result) => {
        console.log(result);
        $('#reply-wrap').empty();

        let data = result.data;
        if (data.length == 0) {
            $('#reply-wrap').append('작성된 댓글이 없습니다.');

        } else {
            let index = 1;
            for (let i = 0; i < data.length; i++) {
                let writer = data[i].create_member;
                let date = data[i].create_date;
                let desc = data[i].reply_desc;
                let use_yn = data[i].remark;

                if(use_yn == '삭제') {
                    $('#reply-wrap').append('<table id=\"reply-table\">' +
                        '<td style=\"font-size: 10pt\">'+'삭제된 댓글입니다.'+'</td></table>');

                } else {
                    if(writer == id) {
                        let reply_no = data[i].reply_no;
                        console.log(reply_no);
                        let html =
                            '<table id=\"reply-table\"><tr><td style=\"font-size: 10pt\">' + writer + '<br>' + '' +
                            '<span style=\"font-size: 8pt\">' + date + '</span>' +'</td>' +
                            '<td align="right">' +
                            '<a id=\"delReply\" href=\"javascript:;\" onclick=\"delReply(' + reply_no + ')\">삭제&nbsp</a>' +
                            '<a id=\"modiReply' + index + '\" href=\"javascript:;\" class=\"modiReply\" ' +
                            'onclick=\"modiReply('+index+ ',' + reply_no + ')\">수정</a></td></tr>' +
                            '<tr><td id=\"ReplyText' + index + '\"style=\"font-size: 11pt\"><pre>' + desc + '</pre></td></tr></table>';

                        $('#reply-wrap').append(html);

                    } else {
                        let html = '<table><tr><td style=\"font-size: 10pt\">' + writer + '<br>' + '' +
                            '<span style=\"font-size: 8pt\">' + date + '</span>' +'</td></tr>' +
                            '<tr><td><pre>' + desc + '</pre></td></tr></table>';

                        $('#reply-wrap').append(html);
                    }
                }
                index++;
            }
        }
    }
})
}

function delBoard(no) {
console.log('delBoard - ' + no)
$.ajax({
    type: 'DELETE',
    url: 'http://localhost:80/api/board/' + board_no + '/' + id,
    header: {
        'Authorization': `Bearer \${token}`
    },
    beforeSend: (xhr) => {
        let choice = confirm('정말 삭제하시겠습니까?');
        if(!choice) xhr.abort();
    },
    success: (result) => {
        console.log(result);
        location.href = 'board_main.jsp';
    }
})
}

function modifyBoard() {
console.log('modifyBoard - ' + result)
localStorage.setItem('board', JSON.stringify(result));

}

function modiReply(index, no) {
    console.log(index);
    console.log(no);
    $('#ReplyText' + index).empty();

    let html = '<textarea id=\"reply-desc-modify\"></textarea>&nbsp' +
               '<button class=\"btn btn-dark\" id=\"btn-modify-reply\" onclick=\"replyDescModify('+no+','+index+')\">수정</button>';

    $('#ReplyText' + index).append(html);
}

function replyDescModify(no, index) {
    let desc = $('#reply-desc-modify').val();
    console.log(desc);

    let data = {
        "reply_desc": desc,
        "update_member": id,
        "reply_no": no
    }

    $.ajax({
        url: "http://localhost:80/api/board/" + board_no + "/reply",
        type: "PUT",
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(data),
        dataType: "json",
        header: {
            'Authorization': `Bearer \${token}`
        },
        success: (result) => {
            console.log(result);

            let html = "<pre>" + desc + "</pre>";

            $('#ReplyText' + index).empty();
            $('#ReplyText' + index).append(html);

        }
    })

}