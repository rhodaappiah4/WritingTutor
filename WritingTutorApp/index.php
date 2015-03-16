<?php session_start(); ?>
<!doctype html>
<html>
<head>
    <title>WrytaBOT</title>
    <link rel="stylesheet" href="assets/css/foundation.min.css">
    <script type="text/javascript" src="assets/js/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="assets/js/csshttprequest.js"></script>
    <script type="text/javascript" src="assets/js/jquery.atd.js"></script>
    <script type="text/javascript" src="assets/js/jquery.atd.textarea.js"></script>
    <script type="text/javascript" src="assets/js/tinymce/tinymce.min.js"></script>
    <script type="text/javascript" src="assets/js/app.js"></script>
    <link rel="stylesheet" href="assets/css/style.css"><link>
</head>
<body>
<div id="userID_Holder" style="display: none"><?php echo $_SESSION['user_id'];?></div>
<div id="userType_Holder" style="display: none"><?php echo $_SESSION['fk_user_type_id'];?></div>
<nav class="top-bar">
    <ul>
        <li><a>Welcome, <?php echo @$_SESSION['username'];?></a></li>
    </ul>
</nav>


<section id="essayList_Section" class="columns small-2">
        <ul class="essayList">
            Loading...
        </ul>

</section>

<div id="textAreaHolder" class="columns small-8">
    Title of Essay <input id="title" type="text">
    <textarea class="center" id="inputArea" name="inputArea"></textarea>
    <p class="center" id="outputArea"><span class="sentence"><span class="thumbs"></span></span> </p>

    <button class="small" id="submitBtn">Submit</button>
    <button class="small" id="saveEssay">Save to Database</button>
</div>
<section id="comment" about="" class="columns small-2">
    <div>
        <div class="comm_descriptor">
            <i class='icon-thumbsup' title='Good sentence'></i>
            <i class='icon-thumbsdown' title='Bad sentence'></i>
        </div>
        <textarea class="comm_text"></textarea>
    </div>
    <button class="small" id="saveComm">Save comment</button>
</section>


<!--    <button class="center" id="select">Select Essay</button>-->
<br><br>
<div id="sentence"></div><br>
<div id="nltk"></div><br>
<div id="bigrams"></div><br>
<div id="trigrams"></div><br>
<div id="display"></div>
</body>
<script type="text/javascript" src="assets/js/foundation.min.js"></script>
<script>
    $(document).foundation();
</script>
</html>

