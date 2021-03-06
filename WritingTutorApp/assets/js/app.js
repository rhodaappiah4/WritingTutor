/**
 * Created by HP on 9/24/2014.
 */


$(document).ready(function(){
    var output =  $('#outputArea');
    var input = $('#inputArea');
    var textbox = $('#inputEssay');
    var comment = $("#comment");
    var comment_student = $("#comment_student");
    var userID = $('#userID_Holder').html();
    var userType = $('#userType_Holder').html();

    tinymce.init({
        selector: "textarea#inputArea",
        plugins: [
            "advlist autolink lists link image charmap print preview anchor",
            "searchreplace visualblocks code fullscreen","WritingTutor",
            "insertdatetime media table contextmenu paste"
        ],
        content_css:"assets/css/content.css",
        toolbar: "review | insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
        command: "example",
        statusbar: false
    });

    var nltk,atd,bigrams,trigrams,sentence;
    //usertype 2 is a tutor
    if(userType==2) {
        input.hide();comment_student.hide();
        $('#submitBtn,#saveEssay').hide();
        output.show();
        var str="";  var t = 0;
        for (var i=1;i<=3;i++) {
            //var title = ["y","m","o"];
           /// str+='<li>'+title[i-1]+'</li>';
            t = i;
            console.log(i);
            $.get('../ATDWeb/request.php', {getEssays: 2, user_id: userID, basis: i}, function (data) {
                $.each(data, function (key, value) {
                    str += '<li><a onclick="showEssay(' + value[0] + ',this)">' + value[1] + '<img src="assets/img/482.GIF"/></a></li>';
                });
                console.log("MUT?"+t);
                //var title = ["y","m","o"];
                //str+='<li>'+title[t-1]+'</li>';
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
                str += '<li><a onclick="showEssay('+value[0]+',this)">'+value[1]+'<img src="assets/img/482.GIF"/></a></li>';
            });
            $("#essayList_Section").find(".essayList").html(str);
        },"json");
        comment.hide();
    }



    $('.explanation').mouseover(function() {
        console.log('hover');
        //alert('yolo');
        //$.get('../ATDWeb/request.php', {explain: $(this).find('.url')}, function (data) {
        //    $('.feedback').append(data);
        //});

    });

    $(document).on('click','.sentence span',function(){
        //send sentence id of related comment to facilitate save
        comment.find(".comm_text").val($(this).data().comment);
        comment.attr("about",$(this).data().sid);
        if($(this).data().quality == 1){
            $('#goodSent').prop('checked',true);
            $('#badSent').prop('checked',false);
        }else{
            $('#goodSent').prop('checked',false);
            $('#badSent').prop('checked',true);
        }
    });
    $('#saveComm').click(function() {
        if($('#goodSent').is(':checked')||$('#badSent').is(':checked')) {
            $.get('../ATDWeb/request.php', {
                comment_save: comment.attr('about'),
                comm_qly: $('#goodSent').is(':checked') ? 1 : 0,
                comm_desc: comment.find('.comm_text').val()
            }, function (data) {
                alert('Saved');
            });
        }else{
            alert('Please rate the sentence.\n Click the like or dislike buttons above the comment box');
        }
    });

    $('#saveEssay').click(function(){
        var tMCE = tinyMCE.activeEditor;
        var checkEssayBody = htmlTAGCleanUp(tMCE.getContent());
        //checkEssayBody.match()
        input.val(checkEssayBody);
        checkEssayBody = input.val();
        console.log(checkEssayBody);
        var essayTitle = $('#title').val();
        if(essayTitle== String.empty()){
            tMCE.windowManager.alert("Please add a title to your essay.");
            return;
        }
        tMCE.setProgressState(1);
        console.log(encodeURI(checkEssayBody));
        $.get('../ATDWeb/request.php',{userid:userID,saveEssay:2,essay:checkEssayBody,title:essayTitle},function(data){
            tMCE.setProgressState(0);
            tMCE.windowManager.alert("Saved");

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

            errorCheckAMAL();

        });
    });

    $("#logout").click(function(){
       window.location.href='logout.php';
    });

});

function errorCheckAMAL(xmlString){
    xmlString = xmlString.substr(xmlString.indexOf('<'),xmlString.lastIndexOf('>')+1)
    xmlString = $.parseXML(xmlString);
    var unformattedStr = input.val();
    $('#sentence').html("Sentence: "+sentence);
    $('#nltk').html("POS Tagging: "+nltk);
    $('#bigrams').html("Bigrams: "+bigrams);
    $('#trigrams').html("Trigrams: "+trigrams);
    $(xmlString).find('error').each(function(key,value){
        var urldata = $(value).find('url').text();
        urldata=(urldata=="")?"None":'<a target="_blank" href="'+ $(value).find('url').text() + '">View explanation</a>';
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

function showEssay(esID,caller){
    var spinner = $(caller).find('img');
    spinner.show();
    var oldVal;
    function paraNext(newVal){
        var res;
        if(oldVal==undefined){
            oldVal = newVal;
        }else if((oldVal+1) == newVal){
            res =  (oldVal+1) == newVal;
            oldVal = newVal;
        }
        return res;
    }
    $.get('../ATDWeb/request.php',{selectEssay:2,essayID:esID},function(data){
        var str = "",inStr = "", commStr = "";
        $.each(data,function(key,sentenceData){

            var sentence = sentenceData[0];
            var sentence_id = sentenceData[1];
            var comment = sentenceData[2];
            var quality = sentenceData[3];
            var paragraphID = sentenceData[4];
            console.log(comment);

            if(paraNext(paragraphID)){
                str+="<br/> ";
                inStr +="<br/> ";
            }
            inStr +=sentence;

            //console.log("SI:"+sentence_id[key]);
            str+= "<span class='sentence'  onclick='highlight(this)'> "+ sentence +
            "<span data-quality='"+quality+"' data-comment='"+ comment +"' data-sID='"+ sentence_id +
            "' class='thumbs' style='background-color: rgba(255, 255, 255, 0.96)'>" +
            "<i class='icon-thumbsup' title='Good sentence'></i>" +
            "<i class='icon-thumbsdown' title='Bad sentence'></i>" +
            "</span>" +
            "</span>";

            commStr+=createCommentsForStudent(sentence,comment);

            spinner.hide();
        });
        $('#comment_student').html(commStr);
        $('#outputArea').html(str);
        $('#inputArea').html(inStr);
        console.log(inStr);
        tinymce.activeEditor.setContent(decodeURI(inStr), {format: 'raw'});
    },"json");

}
function createCommentsForStudent(sent,comm){
    var str="";
    if(comm.trim()!="None") {
        str =
            '<br/>' +
            '<div class="card">' +
            '<p>'+sent+'</p>' +
            '<hr/>' +
            '<article>'+comm+'</article>' +
            '</div>';
    }
    return str;
}
function htmlTAGCleanUp(htmlStr){
    var regex = new RegExp('<([^>])*>',"g");
    return htmlStr.replace(regex,"");
}


