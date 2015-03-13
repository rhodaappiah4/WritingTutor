<?php
/**
 * Created by PhpStorm.
 * User: Rhoda
 * Date: 3/10/15
 * Time: 3:45 PM
 */
session_start();	//initiate session for the current login

$msg="Login";
if(isset($_REQUEST['username'])){
    //the login form has been submitted
    $username=$_REQUEST['username'];
    $password=$_REQUEST['password'];
    $loginDATA=login($username,$password);
    //call login to check username and password
    if($loginDATA){
        loadUserProfile($username,$loginDATA[0],$loginDATA[1]);	//load user information into the session
        echo $loginID;
        header("location: index.php");	//redirect to home page
        echo "<a href='index.php'>click here</a>";	//if redirect fails, provide a link
        exit();
    }else{
        //if login returns false, then something is worng
        $msg="username or password is wrong";
    }
}


?>
    <html>
    <head>
        <title>WrytaBOT-Login</title>
        <link rel="stylesheet" href="assets/css/foundation.min.css">
        <script type="text/javascript" src="assets/js/jquery-1.11.0.js"></script>
        <script type="text/javascript" src="assets/js/csshttprequest.js"></script>
        <script type="text/javascript" src="assets/js/jquery.atd.js"></script>
        <script type="text/javascript" src="assets/js/jquery.atd.textarea.js"></script>
        <script type="text/javascript" src="assets/js/app.js"></script>
        <link rel="stylesheet" href="assets/css/style.css"><link>
    </head>
    <body>
    <form action="login.php" method="POST">
        <table align="center" width="80%">
            <tr>
                <td width="30%"></td>
                <td colspan="2" align="center"><span><?php echo $msg ?></span></td>
                <td width="30%"></td>
            </tr>
            <tr>
                <td width="30%"></td>
                <td>username</td>
                <td><input type="text" name="username"></td>
                <td width="30%"></td>
            </tr>
            <tr>
                <td width="30%"></td>
                <td>password</td>
                <td><input type="password" name="password"></td>
                <td  width="30%"></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td><input type="submit" name="submit" value="login"></td>
                <td></td>
            </tr>
            <table>
    </form>
    If you do not have an account, please go to the <a href="registration.php">Registration Page</a>
    </body>
    </html>

<?php
//include_once ('adb.php');
function login($user, $pass){
    //connect to db
    //select db
    //if connection fails, return false
    //query for the $username and $password
    //if the user with the right password is found,
    //	return true
    //else
    //	return false
    $database="testPython";	//this database has to exist.
    $username="root";		//the main admin user of mysql
    $password="";			//use root password of mysql
    $server="localhost";	//name of the server

    $link=mysql_connect($server,$username,$password);
    //if result is false, the connection did not open
    if(!$link){
        echo "Failed to connect to mysql.";
        //display error message from mysql
        echo mysql_error();
        return false;	//end script
    }

    //select the database to work with using the open connection
    if(!mysql_select_db($database,$link)){
        echo "Failed to select database.";
        //display error message from mysql
        echo mysql_error();
        exit();
    }

    $query = "select user_id,username,user_password,fk_user_type_id from users where username='$user' and user_password=MD5('$pass')";
    $dataset= mysql_query($query,$link);

    $num = mysql_num_rows($dataset);

    if ($num == 0){
        return false;
    }

    else{
        $row=mysql_fetch_assoc($dataset);
        return array($row['user_id'],$row['fk_user_type_id']);
    }
}

function loadUserProfile($username,$userID,$userType){
    //load username and other informaiton into the session
    //the user informaiton comes from the database
    $_SESSION['username']=$username;
    $_SESSION['user_id']=$userID;
    $_SESSION['fk_user_type_id']=$userType;
}