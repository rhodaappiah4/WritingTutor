<?php session_start();
if($_SESSION['username']==null){
    header('location: login.php');
}
?>
<!doctype html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title>WrytaBOT</title>
    <link rel="stylesheet" href="assets/css/foundation.min.css">
    <script type="text/javascript" src="assets/js/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="assets/js/csshttprequest.js"></script>
    <script type="text/javascript" src="assets/js/jquery.atd.js"></script>
    <script type="text/javascript" src="assets/js/jquery.atd.textarea.js"></script>
    <script type="text/javascript" src="assets/js/tinymce/tinymce.min.js"></script>
    <script type="text/javascript" src="assets/js/plugin.js"></script>
    <script type="text/javascript" src="assets/js/app.js"></script>
    <link rel="stylesheet" href="assets/css/style.css"><link>
</head>
<body>
<div id="userID_Holder" style="display: none"><?php echo $_SESSION['user_id'];?></div>
<div id="userType_Holder" style="display: none"><?php echo $_SESSION['fk_user_type_id'];?></div>

<nav class="top-bar fixed" data-topbar role="navigation">
    <section class="top-bar-section">

        <ul class="left">
            <li><a href="#">Home</a></li>
        </ul>
        <ul class="right">
            <li class="has-dropdown">
                <a href="#">Hello, <?php echo $_SESSION['username']!= null? $_SESSION['username'] : "Who are you?"; ?></a>
                <ul class="dropdown">
                    <li class="active" ><a id="logout" >Logout</a></li>
                </ul>
            </li>
        </ul>
    </section>
</nav>


<section id="essayList_Section" class="columns small-2">
    <ul class="essayList">
        Loading...
    </ul>

</section>

<div id="textAreaHolder" class="columns small-8">
    <div class="card">
    <label>
    Title of Essay <input id="title" type="text">
    </label>
    <textarea class="center" id="inputArea" name="inputArea"></textarea>
    <p class="center" id="outputArea"><span class="sentence"><span class="thumbs"></span></span> </p>

    <button class="small" id="submitBtn">Submit</button>
    <button class="small" id="saveEssay">Save to Database</button>
        </div>
</div>
<section id="comment" about="" class="columns small-2">
    <div class="card">
    <h6>Comments on selected sentence.</h6>
    <div>
        <div class="comm_descriptor row">
            <div class="columns small-6">
                <label>
                    <input id="goodSent" type="radio" name="quality" title='Good sentence'>
                    <i class="icon-thumbsup"></i>
                </label>
            </div>
            <div class="columns small-6">
                <label>
                    <input id="badSent" type="radio" name="quality" title='Bad sentence'>
                    <i  class="icon-thumbsdown"></i>
                </label>
            </div>
        </div>
        <textarea class="comm_text"></textarea>
    </div>
    <button class="small small-12" id="saveComm">Save comment</button>
    </div>
</section>

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

