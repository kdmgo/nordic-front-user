window.onload = function () {
    $.ajax({
        type: 'GET',
        url: 'http://localhost:80/api/board',
        success: (result) => {
            let pageInfo = result.data;
            let boardList = result.data.list;
            console.log(pageInfo);
            console.log(boardList);

            for (let i = 0; i < boardList.length; i++) {

                let title = boardList[i].board_object;
                let writer = boardList[i].create_member;
                let date = boardList[i].create_date;
                let board_no = boardList[i].board_no;

                let image;
                let image_file;
                if( boardList[i].image_file != null && boardList[i].image_use_yn == 'Y' ) {
                    image = boardList[i].image_file
                    image_file = image.substr(image.lastIndexOf('/'));
                }

                console.log('image : ' + image_file);
                let pageNum;

                let html = '<table id=\"board-table\">';
                html += '<tr><td><img id=\"thumbnail\" src=\"http://localhost:80/api/img' + image_file + '\"' +
                    ' onerror="this.onerror = null; this.src=\'http://localhost:80/api/img/no_image.png\'"></td></tr>';
                html += '<tr><td onclick=\"detail(' + pageNum +',' + board_no + ')\">' +
                    '<a href=\"javascript:\" id=\"object\">' + title + '</a></td></tr>';
                html += '<tr><td id=\"writer\">' + writer + '</td></tr>';
                html += '<tr><td id=\"date\">' + date + '</td></tr>';
                html += '</table>';

                $('#board-content').append(html)
            }

            // 페이지 넘버
            let start = 1;
            let end = pageInfo.pages;

            for (let i = 0; i < pageInfo.navigatepageNums.length; i++) {
                let pageNums = pageInfo.navigatepageNums;
                let pageNum = pageNums.at(i);
                let html;

                if(i == 0) {
                    html = '<li class=\"page-item\">' +
                        '<a href=\"javascript:\" class=\"page-link\" onclick=\"move(' +start+ ')\" value=\"'+ start + '\">'+
                        '처음</a></li>'

                    $('#pagination').append(html);
                }

                if(pageNum == 1) {
                    html = '<li class=\"page-item disabled\">' +
                        '<a href=\"javascript:\" class=\"page-link\" onclick=\"move(' +pageNum+ ')\" value=\"'+ pageNum + '\">'
                        +'<strong>'+ pageNum + '</strong></a></li>'

                } else {
                    html = '<li class=\"page-item\">' +
                        '<a href=\"javascript:\" class=\"page-link\" onclick=\"move(' +pageNum+ ')\" value=\"'+ pageNum + '\">'
                        + pageNum + '</a></li>'
                }

                $('#pagination').append(html);

                if(i == pageInfo.navigatepageNums.length - 1) {
                    html = '<li class=\"page-item\">' +
                        '<a href=\"javascript:\" class=\"page-link\" onclick=\"move(' +end+ ')\" value=\"'+ end + '\">'+
                        '끝</a></li>'

                    $('#pagination').append(html);
                }
            }
        }
    })
}

function move(page) {
    console.log("move - " + page)

    $.ajax({
        type: 'GET',
        url: 'http://localhost:80/api/board',
        data: {page},
        success: (result) => {

            $('#board-content').empty();
            $('#pagination').empty();

            let pageInfo = result.data;
            let boardList = result.data.list;
            console.log(pageInfo);
            console.log(boardList);

            for (let i = 0; i < boardList.length; i++) {

                let title = boardList[i].board_object;
                let writer = boardList[i].create_member;
                let date = boardList[i].create_date;
                let board_no = boardList[i].board_no;

                let image;
                let image_file;
                if( boardList[i].image_file != null && boardList[i].image_use_yn == 'Y' ) {
                    image = boardList[i].image_file
                    image_file = image.substr(image.lastIndexOf('/'));
                }

                console.log('image : ' + image_file);
                let pageNum;

                let html = '<table id=\"board-table\">';
                html += '<tr><td><img id=\"thumbnail\" src=\"http://localhost:80/api/img' + image_file + '\"' +
                    ' onerror="this.onerror = null; this.src=\'http://localhost:80/api/img/no_image.png\'"></td></tr>';
                html += '<tr><td onclick=\"detail(' + pageNum +',' + board_no + ')\">' +
                    '<a href=\"javascript:\" id=\"object\">' + title + '</a></td></tr>';
                html += '<tr><td id=\"writer\">' + writer + '</td></tr>';
                html += '<tr><td id=\"date\">' + date + '</td></tr>';
                html += '</table>';

                $('#board-content').append(html)
            }

            // 페이지 넘버
            let start = 1;
            let end = pageInfo.pages;

            for (let i = 0; i < pageInfo.navigatepageNums.length; i++) {
                let pageNums = pageInfo.navigatepageNums;
                let pageNum = pageNums.at(i);
                let html;

                if(i == 0) {
                    html = '<li class=\"page-item\">' +
                        '<a href=\"#\" class=\"page-link\" onclick=\"move(' +start+ ')\" value=\"'+ start + '\">'+
                        '처음</a></li>'

                    $('#pagination').append(html);
                }

                if(pageNum == page) {
                    html = '<li class=\"page-item disabled\">' +
                        '<a href=\"#\" class=\"page-link\" onclick=\"move(' +pageNum+ ')\" value=\"'+ pageNum + '\">'
                        +'<strong>'+ pageNum + '</strong></a></li>'

                } else {
                    html = '<li class=\"page-item\">' +
                        '<a href=\"#\" class=\"page-link\" onclick=\"move(' +pageNum+ ')\" value=\"'+ pageNum + '\">'
                        + pageNum + '</a></li>'
                }

                $('#pagination').append(html);

                if(i == pageInfo.navigatepageNums.length - 1) {
                    html = '<li class=\"page-item\">' +
                        '<a href=\"#\" class=\"page-link\" onclick=\"move(' +end+ ')\" value=\"'+ end + '\">'+
                        '끝</a></li>'

                    $('#pagination').append(html);
                }
            }
        }
    })
}

function detail(page = 1, board_no) {
    console.log('Detail');
    console.log('page - ' + page);
    console.log('board_no - ' + board_no);

    $.ajax({
        type: 'GET',
        url: 'http://localhost:80/api/board/view/' + page + '/' + board_no,
        success: (result) => {
            console.log(result);
            localStorage.setItem('result', JSON.stringify(result))
            localStorage.setItem('page', page);
            location.href = 'board_detail.jsp';
        }

    })
}

function search(page) {
    let searchType = $('#search-type').val();
    let searchContent = $('input[name=search-content]').val();
    console.log(searchType);
    console.log(searchContent);

    $.ajax({
        type: 'GET',
        async: false,
        url: 'http://localhost:80/api/board/' + searchType + '/' + searchContent,
        beforeSend: (xhr) => {
            if(searchContent == "") xhr.abort();
        },
        data: {"page" : page},
        success: (result) => {
            $('#board-content').empty();
            $('#pagination').empty();

            let pageInfo = result.data;
            let boardList = result.data.list;
            console.log(pageInfo);
            console.log(boardList);

            if(boardList.length == 0) {
                $('#board-content').append('검색결과가 없습니다.')

            } else {

                for (let i = 0; i < boardList.length; i++) {

                    let title = boardList[i].board_object;
                    let writer = boardList[i].create_member;
                    let date = boardList[i].create_date;
                    let board_no = boardList[i].board_no;
                    let pageNum;

                    if(i == 0) {
                        let html = '<h1>검색결과<a style=\"font-size: 20pt;\">(' + pageInfo.total + ')</a></h1><hr>';
                        $('#board-content').append(html)
                    }

                    let html = '<table id=\"search-result\" class=\"table table-hover\" style=\"width: 900px\">';
                    html += '<tr><td onclick=\"detail(' + pageNum +',' + board_no + ')\" style=\"table-layout:fixed; width: 400px;\">' +
                            '<a href=\"javascript:\" id=\"object\" style=\"font-size: 10pt;\">' + title + '</a></td>';
                    html += '<td style=\"table-layout:fixed; font-size: 10pt;\">' + writer + '</td>';
                    html += '<td style=\"table-layout:fixed; font-size: 10pt;\">' + date + '</td></tr>';
                    html += '</table>';

                    $('#board-content').append(html)
                }

                // 페이지 넘버
                for (let i = 0; i < pageInfo.navigatepageNums.length; i++) {
                    let pageNums = pageInfo.navigatepageNums;
                    let pageNum = pageNums.at(i);

                    let html = '<li class=\"page-item\">' +
                        '<a href=\"#\" class=\"page-link\" ' +
                        'onclick=\"searchMove('+pageNum+', \'' + searchType + '\' , \'' + searchContent +'\')\" value=\"'+ pageNum + '\">'
                        + pageNum + '</a></li>'

                    $('#pagination').append(html);

                }
            }
        }
    })
}

function searchMove(page, type, content) {
    console.log(page);
    console.log(type);
    console.log(content);

    $.ajax({
        type: 'GET',
        async: false,
        url: 'http://localhost:80/api/board/' + type + '/' + content,
        data: {"page" : page},
        success: (result) => {
            $('#board-content').empty();
            $('#pagination').empty();

            let pageInfo = result.data;
            let boardList = result.data.list;
            console.log(pageInfo);
            console.log(boardList);

            if(boardList.length == 0) {
                $('#board-content').append('검색결과가 없습니다.')

            } else {

                for (let i = 0; i < boardList.length; i++) {

                    let title = boardList[i].board_object;
                    let writer = boardList[i].create_member;
                    let date = boardList[i].create_date;
                    let board_no = boardList[i].board_no;
                    let pageNum;

                    if(i == 0) {
                        let html = '<h1>검색결과<a style=\"font-size: 20pt;\">(' + pageInfo.total + ')</a></h1><hr>';
                        $('#board-content').append(html)
                    }

                    let html = '<table id=\"search-result\" class=\"table table-hover\" style=\"width: 900px\">';
                    html += '<tr><td onclick=\"detail(' + pageNum +',' + board_no + ')\" style=\"table-layout:fixed; width: 400px;\">' +
                        '<a href=\"javascript:\" id=\"object\" style=\"font-size: 10pt;\">' + title + '</a></td>';
                    html += '<td style=\"table-layout:fixed; font-size: 10pt;\">' + writer + '</td>';
                    html += '<td style=\"table-layout:fixed; font-size: 10pt;\">' + date + '</td></tr>';
                    html += '</table>';

                    $('#board-content').append(html)
                }

                // 페이지 넘버
                for (let i = 0; i < pageInfo.navigatepageNums.length; i++) {
                    let pageNums = pageInfo.navigatepageNums;
                    let pageNum = pageNums.at(i);

                    let html = '<li class=\"page-item\">' +
                        '<a href=\"#\" class=\"page-link\" ' +
                        'onclick=\"searchMove('+pageNum+', \'' + type + '\' , \'' + content +'\')\" value=\"'+ pageNum + '\">'
                        + pageNum + '</a></li>'

                    $('#pagination').append(html);

                }
            }
        }
    })
}