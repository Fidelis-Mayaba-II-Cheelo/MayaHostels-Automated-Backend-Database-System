<?php

interface ICache
{
    
    function put($key,$data);


    function get($key);
 

    function destroy($key);

    function destroyAll();
}