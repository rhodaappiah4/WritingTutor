
<?php
require_once "databaseFunctions.php";
$dataFunctions = new databaseFunctions();

if (isset($_REQUEST["parse"])) {

    $str = "";
    $str = $_REQUEST["inputArea"];
    $str = urlencode($str);
    $url = "http://localhost:8080/?sentence=" . $str; //calls python
    $contents = file_get_contents($url);


    $url = 'http://localhost:1049/checkDocument?data=' . $str; //calls ATD
    $contents .= '|break|' . file_get_contents($url);
    var_dump($contents);

}elseif(isset($_REQUEST["explain"])) {
    $url = $_REQUEST["explain"]; //calls ATD external link
    $contents .= file_get_contents($url);
    var_dump($contents);
}elseif(isset($_REQUEST['selectEssay'])){
    $str = "";
    $str = $_REQUEST["inputEssay"];
    $str = urlencode($str);
    $url = "http://localhost:8080/?essay_by_id=" . $str; //calls python
    $contents = get_url_contents($url);
    print_r($contents);
}elseif(isset($_REQUEST['getEssays'])){
    $str = "";
    $str = $_REQUEST["user_id"];
    $basis = $_REQUEST["basis"];
    $str = urlencode($str);
    $url = "http://localhost:8080/?essays_of_user=" . $str ."&basis=" . $basis; //calls python

    $content = get_url_contents($url);

    print_r($content);
}elseif(isset($_REQUEST['comment_save'])){
    $comm_id = $_REQUEST['comment_save'];
    $quality = $_REQUEST['comm_qly'];
    $comment = $_REQUEST['comm_desc'];
    $dataFunctions->update_sentence_comment($comm_id,$quality,$comment);
}elseif(isset($_REQUEST['saveEssay'])) {
    $str = "";
    $str = $_REQUEST["essay"];
    $title = urlencode($_REQUEST["title"]);

    $user_id = $_REQUEST["userid"];
    $str = urlencode($str);
    $url = "http://localhost:8080/?essay=" . $str ."&title=" . $title."&userid=".$user_id; //calls python

    $content = get_url_contents($url);

    print_r($url);
}

echo $dataFunctions->err();

function get_url_contents($url){
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_URL, $url );
    $content = curl_exec($ch);
    return $content;
}

//$ch = curl_init();
//curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
//curl_setopt($ch, CURLOPT_URL,
//    $url
//);
//$content = curl_exec($ch);
//print_r($content) ;
