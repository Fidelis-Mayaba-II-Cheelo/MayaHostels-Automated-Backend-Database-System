<?php

class MySQLQueryAdapter extends QueryAdapter{
    function select($id=null, $whereClause=null,$page=null,$nextPageSize=null){

    }

    function insert(array $fields, array $values){

    }

    function delete($id){

    }

    function update(array $fields, array $values, $id){

    }

    //Generic function for executing queries(Does the whole creation of the database connection and is used to execute queries within the other functions)
    function executeQuery($sql){

    }

    //Function to run a custom query
    function query($sql){

    }

    //Function that gets the details of every field in a database table
    function getFieldDetails()
    {
        
    }
}