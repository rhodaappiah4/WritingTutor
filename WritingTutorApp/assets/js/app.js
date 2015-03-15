/**
 * Created by HP on 9/24/2014.
 */


$(document).ready(function(){
    var output =  $('#outputArea');
    var input = $('#inputArea');
    var textbox = $('#inputEssay');
    var comment = $("#comment");
    var userID = $('#userID_Holder').html();
    var userType = $('#userType_Holder').html();


    var nltk,atd,bigrams,trigrams,sentence;
    if(userType==2) {
        input.hide();
        output.show();
        var str="";  var t = 0;
        for (var i=1;i<=3;i++) {
            //var title = ["y","m","o"];
           /// str+='<li>'+title[i-1]+'</li>';
            t = i;
            console.log(i);
            $.get('../ATDWeb/request.php', {getEssays: 2, user_id: userID, basis: i}, function (data) {
                $.each(data, function (key, value) {
                    str += '<li><a onclick="showEssay(' + value[0] + ')">' + value[1] + '</a></li>';
                });
                console.log("MUT?"+t);
                var title = ["y","m","o"];
                str+='<li>'+title[t-1]+'</li>';
                $("#essayList_Section").find(".essayList").html(str);
            }, "json");
        }

    }else {
        input.show();
        output.hide();
        $.get('../ATDWeb/request.php',{getEssays:2,user_id:userID,basis:1},function(data){
            console.log(data);
            var str = "";
            $.each(data,function(key,value){
                str += '<li><a onclick="showEssay('+value[0]+')">'+value[1]+'</a></li>';
            });
            $("#essayList_Section").find(".essayList").html(str);
        },"json");
    }



    $('.explanation').mouseover(function() {
        console.log('hover');
        //alert('yolo');
        //$.get('../ATDWeb/request.php', {explain: $(this).find('.url')}, function (data) {
        //    $('.feedback').append(data);
        //});

    });

    $(document).on('click','.sentence span',function(){
        //send sentence id of related comment too to facilitate save
        comment.find(".comm_text").val($(this).data().comment);
        comment.attr("about",$(this).data().sid);
        if($(this).data().quality == 1){
            $('#comment .icon-thumbsup').addClass('selected');
            $('#comment .icon-thumbsdown').removeClass('selected');
        }else{
            $('#comment .icon-thumbsdown').addClass('selected');
            $('#comment .icon-thumbsup').removeClass('selected');
        }
    });
    $('#saveComm').click(function() {
        $.get('../ATDWeb/request.php', {
            comment_save: comment.attr('about'),
            comm_qly: comment.find('.icon-thumbsup').hasClass('selected') ? 1 : 0,
            comm_desc: comment.find('.comm_text').val()
        }, function (data) {
            alert('Saved');
        });
    });

    $('#saveEssay').click(function(){
        var checkEssayBody = input.val();
        var essayTitle = $('#title').val();
        //var checkEssayDescription =
        console.log(encodeURI(checkEssayBody));
        $.get('../ATDWeb/request.php',{userid:userID,saveEssay:2,essay:checkEssayBody,title:essayTitle},function(data){

            //console.log(data);

        });
    });


    $('#submitBtn').click(function(){
        var toCheck = input.val();
        $.get('../ATDWeb/request.php',{parse:2,inputArea:toCheck},function(data){
            var parts = data.split('|break|');

            sentence = parts[1];
            nltk = parts[2];
            atd = parts[5];
            bigrams = parts[3];
            trigrams = parts[4];

            console.log("SENTENCE: "+sentence);
            console.log("NLTK: "+nltk);
            console.log("ATD: "+atd);
            console.log("Bigrams: "+bigrams);
            console.log("Trigrams: "+trigrams);
            errorCheckAMAL(atd.substr(atd.indexOf('<'),atd.lastIndexOf('>')+1));

        });
    });

    $('#select').click(function(){
        var toCheck = textbox.val();
        $.get('../ATDWeb/request.php',{selectEssay:2,inputEssay:toCheck},function(data){

            console.log(data);

        });
    });

    $('#get').click(function(){
        var toCheck = textbox.val();
        $.get('../ATDWeb/request.php',{getEssays:2,inputEssay:toCheck},function(data){

            console.log(data);

        });
    });



});

function errorCheckAMAL(xmlString){
    atd = $.parseXML(xmlString);
    var unformattedStr = input.val();
    $('#sentence').html("Sentence: "+sentence);
    $('#nltk').html("POS Tagging: "+nltk);
    $('#bigrams').html("Bigrams: "+bigrams);
    $('#trigrams').html("Trigrams: "+trigrams);
    $(atd).find('error').each(function(key,value){
        var urldata = $(value).find('url').text();
        (urldata=="")?urldata="None":urldata='<a target="_blank" href="'+ $(value).find('url').text() + '">View explanation</a>';
        var errorStr = $(value).find('string').text();
        var errorType = $(value).find('type').text();
        var errorSuggestions = $(value).find('suggestions').text();
        errorSuggestions = errorSuggestions==""?'None':errorSuggestions;
        var errorFormatted =
            '<span class="error-'+ errorType + '">'+
            errorStr +
            '<div class="feedback">'+
            '<div class="header">Error description</div>'+
            '<div class="description">'+
            $(value).find('description').text()+
            '</div>'+

            '<div class="header">Suggestions</div>'+
            '<div class="suggestions">'+
            errorSuggestions +
            '</div>'+

            '<div class="header">Explanation</div>'+
            '<div class="explanation">'+
            '<div class="url">' +
            urldata+
            '</div>'+
            '</div>'+
            '</div>' +

            '</span>';

        unformattedStr = unformattedStr.replace(errorStr,errorFormatted);


    });

    input.hide();

    output.html(unformattedStr);
    //$('p').html(spanned);
    output.show();
}


function highlight(caller){
    highlightColor = 'rgb(127, 255, 212)';
    caller = $(caller);
    console.log(caller.css('background-color'));
    if(caller.css('background-color') == highlightColor){
        $(caller).css({'background-color': ''});
    }else{
        $(caller).css({'background-color': highlightColor});
    }

}

function showEssay(esID){
    $.get('../ATDWeb/request.php',{selectEssay:2,inputEssay:esID},function(data){
        var str = "",inStr = "";
        $.each(data,function(key,value){
            var sentences = value[0].split("|");
            var sentence_id = value[1].split("|");
            var comments = value[2].split("|");
            var quality = value[3].split("|");
            console.log(comments);
            $.each(sentences,function(key,value){
                inStr +=value;
                //console.log("SI:"+sentence_id[key]);
                str+= "<span class='sentence'  onclick='highlight(this)'> "+value +
                "<span data-quality='"+quality[key]+"' data-comment='"+ comments[key] +"' data-sID='"+ sentence_id[key] +"' class='thumbs' style='background-color: rgba(255, 255, 255, 0.96)'>" +
                "<i class='icon-thumbsup' title='Good sentence'></i>" +
                "<i class='icon-thumbsdown' title='Bad sentence'></i>" +
                "</span>" +
                "</span>";
            });
            str+="<br/>";
            //inStr +="\n";
        });
        $('#outputArea').html(str);
        $('#inputArea').html(inStr);
    },"json");
}


