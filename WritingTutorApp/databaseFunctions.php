<?php
/**
 * Created by PhpStorm.
 * User: Rhoda
 * Date: 3/10/15
 * Time: 4:29 PM
 */

include_once("databaseConnection.php");
class databaseFunctions extends databaseConnection{
    function databaseFunctions(){
        databaseConnection::databaseConnection();
    }

    //adding user type
    function add_user_type($user_type){
        $sql_query="INSERT INTO user_type(user_type) VALUES ('$user_type')";
        if (!$this->query($sql_query)){
            return false;
        }
        return true;
    }

    //deleting user type based on id
    function delete_user_type($user_type_id){
        $sql_query="DELETE FROM user_type WHERE user_type_id=$user_type_id";
        if (!$this->query($sql_query)){
            return false;
        }
        return true;
    }

    //editing user type based on id
    function update_user_type($user_type_id,$user_type){
        $sql_query="UPDATE user_type SET user_type='$user_type' WHERE user_type_id=".$user_type_id;
        if (!$this->query($sql_query)){
            return false;
        }
        return true;
    }

    //displaying all user types
    function get_user_types(){
        $sql_query="SELECT user_type_id,user_type FROM user_type";
        if (!$this->query($sql_query)){
            return false;
        }
        return true;
    }

    //displaying user type with id in question
    function get_user_type_by_id($user_type_id){
        $sql_query="SELECT user_type FROM user_type WHERE user_type_id=".$user_type_id;
        if (!$this->query($sql_query)){
            return false;
        }
        return true;
    }

    //adding user
    function add_user($firstname,$lastname,$username,$user_password,$fk_user_type_id){
        $sql_query="INSERT INTO users(firstname,lastname,username,user_password,fk_user_type_id) VALUES
        ('$firstname','$lastname','$username','$user_password',$fk_user_type_id)";
        if (!$this->query($sql_query)){
            return false;
        }
        return true;
    }

    //deleting user
    function delete_user($user_id){
        $sql_query="DELETE FROM users WHERE user_id=$user_id";
        if (!$this->query($sql_query)){
            return false;
        }
        return true;
    }

    //editing details of user
    function update_user($user_id,$firstname,$lastname,$username,$user_password,$fk_user_type_id){
        $sql_query="UPDATE users SET firstname='$firstname',lastname='$lastname',username='$username',
        user_password='$user_password',fk_user_type_id=$fk_user_type_id WHERE user_id=$user_id";
        if (!$this->query($sql_query)){
            return false;
        }
        return true;
    }

    //displaying all users
    function get_users(){
        $sql_query="SELECT user_id,firstname,lastname,username,user_password,user_type FROM users,user_type
        WHERE fk_user_type_id=user_type_id";
        if (!$this->query($sql_query)){
            return false;
        }
        return true;
    }

    //displaying user details with id in question
    function get_user_by_id($user_id){
        $sql_query="SELECT firstname,lastname,username,user_password,user_type FROM users,user_type WHERE
        fk_user_type_id=user_type_id AND user_id=".$user_id;
        if (!$this->query($sql_query)){
            return false;
        }
        return true;
    }
}