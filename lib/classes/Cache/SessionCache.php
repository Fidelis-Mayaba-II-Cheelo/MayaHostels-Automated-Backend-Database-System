<?php

class SessionCache implements ICache{


    function store($key)
    {
        if(!isset($_SESSION['__session-cache'])){
            $_SESSION['__session-cache']=[];
        }
        if(!in_array($key,$_SESSION['__session-cache'])){
            $_SESSION['__session-cache'][]=$key;
        }

        //print_r($_SESSION['__session-cache']);
    }

    function put($key,$data)
    {
        $this->store($key);

        $_SESSION[$key] = json_encode($data);
    }

    function get($key)
    {
        $this->store($key);
        return json_decode($_SESSION[$key]??'[]');
    }

    function destroy($key)
    {
        unset($_SESSION[$key]);
    }

    function destroyAll(){
       
        $keys = ($_SESSION['__session-cache']??[]);
        foreach($keys as $key){
            unset($_SESSION[$key]);
        }
            
    }
}