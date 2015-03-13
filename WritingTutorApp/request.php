
<?php
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
}elseif(isset($_REQUEST['database'])){
    $str = "";
    $str = $_REQUEST["inputArea"];
    $str = urlencode($str);
    $url = "http://localhost:8080/?essay=" . $str; //calls python
    $contents = file_get_contents($url);
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
    $str = urlencode($str);
    $url = "http://localhost:8080/?essays_of_user=" . $str; //calls python

    $content = get_url_contents($url);

    print_r($content);
}

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
