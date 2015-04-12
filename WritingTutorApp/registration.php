<?php
/**
 * Created by PhpStorm.
 * User: Rhoda
 * Date: 3/10/15
 * Time: 3:39 PM
 */


include("databaseFunctions.php");
$d=new databaseFunctions();

$firstname="";
if (isset($_REQUEST['firstname'])){
    $firstname=$_REQUEST['firstname'];
}
$lastname="";
if (isset($_REQUEST['lastname'])){
    $lastname=$_REQUEST['lastname'];
}
$username="";
if (isset($_REQUEST['username'])){
    $username=$_REQUEST['username'];
}
$user_password="";
if (isset($_REQUEST['user_password'])){
    $user_password=$_REQUEST['user_password'];
}
$fk_user_type_id=0;
if (isset($_REQUEST['type'])){
    $fk_user_type_id=$_REQUEST['type'];
}

if(isset($_REQUEST['register'])){
    $d->add_user($firstname,$lastname,$username,$user_password,$fk_user_type_id);
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
<form action="registration.php" method="GET">
    <div>First Name:<input type="text" size=12 name="firstname"></div>
    <div>Last Name:<input type="text" name="lastname"></div>
    <div>Username:<input type="text" name="username"></div>
    <div>Password:<input type="password" name="user_password"></div>
    <?php
        $d->get_user_types();
        $row=$d->fetch();
    ?>
    <select name="type">
        <?php
        while($row){
            echo '<option value='.$row["user_type_id"].'>'.$row["user_type"].'</option>';
            $row=$d->fetch();
        }
        ?>
    </select>
    <input type="submit" name="register" value="Register">
</form>



</body>
<script type="text/javascript" src="assets/js/foundation.min.js"></script>
<script>
    $(document).foundation();
</script>
</html>

