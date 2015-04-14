
<?php
require_once "databaseFunctions.php";
$dataFunctions = new databaseFunctions();

if (isset($_REQUEST["analyze"])) {
    $contents = "";
    $str = "";
    $str = $_REQUEST["analyze"];
    $str = urlencode($str);

    $url = "http://localhost:8080/?sentence=" . $str; //calls python
    $contents .= get_url_contents($url);
    $url = "http://localhost:8008/parserver/parseHandler?analyze=" . $str; //calls python
    $contents .= get_url_contents($url);
    $url = 'http://localhost:1049/checkDocument?data=' . $str; //calls ATD TODO: add atd key
    $url = 'http://service.afterthedeadline.com/checkDocument?data=' . $str; //calls ATD TODO: add atd key
    $contents .= get_url_contents($url);

    $contents = str_replace('<results>',"",$contents);
    $contents = str_replace('</results>',"",$contents);
    print_r('<results>'.$contents.'</results>');

}elseif(isset($_REQUEST["explain"])) {
    $url = $_REQUEST["explain"]; //calls ATD external link
    $contents .= file_get_contents($url);
    print_r($contents);
}elseif(isset($_REQUEST['selectEssay'])){
    $str = "";
    $str = $_REQUEST["essayID"];
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
    $sent_id = $_REQUEST['comment_save'];
    $quality = $_REQUEST['comm_qly'];
    $comment = $_REQUEST['comm_desc'];
    $dataFunctions->update_sentence_comment($sent_id,$quality,$comment);
}elseif(isset($_REQUEST['saveEssay'])) {
    $str = "";
    $str = $_REQUEST["essay"];
    $title = urlencode($_REQUEST["title"]);

    $user_id = $_REQUEST["userid"];
    $str = urlencode($str);
    $url = "http://localhost:8080/?essay=" . $str ."&title=" . $title."&userid=".$user_id; //calls python

    $content = get_url_contents($url);

    print_r($url);
}elseif(isset($_REQUEST['test'])) {


    print_r('some text here <results>
  <error>
    <string>mamsd</string>
    <description>Spelling</description>
    <precontext>the</precontext>
    <suggestions>
        <option>mass</option>
        <option>mast</option>
        <option>mad</option>
        <option>maps</option>
        <option>maid</option>
    </suggestions>
    <type>spelling</type>

  </error>
  <error>
    <string>i</string>
    <description>Make I uppercase</description>
    <precontext></precontext>
    <suggestions>
        <option>I</option>
    </suggestions>
    <type>grammar</type>
    <url>http://service.afterthedeadline.com/info.slp?text=i&amp;tags=PRP&amp;engine=1</url>

  </error>
  <error>
    <string>The sun is high, put on some sunblock.</string>
    <description>Comma splice; use a conjunction after the comma or a semi-colon/full-stop in place of the comma</description>
    <precontext></precontext>
    <suggestions>
        <option>or</option>
        <option>and</option>
        <option>but</option>
        <option>so</option>
        <option>;</option>
        <option>.</option>
    </suggestions>
    <type>grammar</type>
  </error>
</results>');
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
