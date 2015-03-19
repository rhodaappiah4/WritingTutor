<?php
/**
 * Created by PhpStorm.
 * User: Rhoda
 * Date: 3/16/15
 * Time: 6:42 PM
 */
	session_start();
	session_destroy();
	header("location: login.php");
