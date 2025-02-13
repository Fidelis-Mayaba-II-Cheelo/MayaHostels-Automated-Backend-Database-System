<?php

abstract class QueryAdapter{

    //Our database object reference
    protected $database;

    //Our query builder object reference
    protected $queryBuilder;

    //The database tables we perform our queries on
    protected $table;

    //The primary key of our tables
    protected $primaryKey;

    //The page size used for paginations
    protected $pageSize;

    //The other specific non general fields unique to each type of query
    protected $id;
    protected array $fields;
    protected array $values;

    //The properties passed into the constructor are the ones common to and used by all queries
    public function __construct(
        IDatabaseHelper $database,
        ISQLQueryBuilder $queryBuilder,
        $table,
        $primaryKey,
        $pageSize,
    ){
        $this->database = $database;
        $this->queryBuilder = $queryBuilder;
        $this->table = $table;
        $this->primaryKey = $primaryKey;
        $this->pageSize = $pageSize;
    }

    //Our abstract functions that handle query execution(The bridge/meeting point between the query builder and the database connection)
    abstract function select($id=null, $whereClause=null,$page=null,$nextPageSize=null);

    abstract function insert(array $fields, array $values);

    abstract function delete($id);

    abstract function update(array $fields, array $values, $id);

    //Generic function for executing queries(Does the whole creation of the database connection and is used to execute queries within the other functions)
    abstract function executeQuery($sql);

    //Function to run a custom query(Specifically for complex queries involving joins, subqueries, stored procedures, sql functions etc)
    abstract function query($sql);

    //Function that gets the details of every field in a database table
    abstract function describe();
}