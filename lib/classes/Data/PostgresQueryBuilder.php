<?php 

class PostgresQueryBuilder extends MySQLQueryBuilder{
    //overriding the limit function because its different in postgres
    public function limit(int $start, int $offset):ISQLQueryBuilder{
        parent::limit($start, $offset);
        $this->query->limit = " LIMIT ". $start. " OFFSET ". $offset;
        return $this;
    }
}