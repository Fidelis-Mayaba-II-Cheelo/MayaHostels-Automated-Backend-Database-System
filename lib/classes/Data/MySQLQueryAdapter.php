<?php

class MySQLQueryAdapter extends QueryAdapter{
    function select($id=null, $whereClause=null,$page=null,$nextPageSize=null){
        $currentPageSize = isset($nextPageSize) ? $nextPageSize : $this->pageSize;

        //create query base   
        $this->queryBuilder->select($this->table);

        if ($whereClause) {
            //$sql.="AND ".$whereClause;
            $ands = explode("AND", $whereClause);
            foreach ($ands as $and) {
                $andParts = explode("=", $and);
                $field = trim($andParts[0]);
                $value = trim($andParts[1]);

                $this->queryBuilder->where($field, $value, "=");
            }
        }

        if ($page) {
            $offset = ($page - 1) * $this->pageSize;
            //$sql.=" LIMIT $offset,$nextPage";
            $this->queryBuilder->limit($offset, $currentPageSize);
        }

        if ($id) {
            $this->queryBuilder->where($this->primaryKey, $id, '=');
        }

        $sql = $this->queryBuilder->getSQL();

         echo $sql;
        $query = $this->database->getConnection()->query($sql);
        $rows = [];
        if ($query) {
            $rows = $query->fetch_all(MYSQLI_ASSOC);
        }
        return $rows;
    }

    function insert(array $fields, array $values){
        $sql = $this->queryBuilder->insert($this->table, $fields, $values)->getSQL();
        return $this->executeQuery($sql);
    }

    function delete($id){
        $sql = $this->queryBuilder->delete($this->table)->where($this->primaryKey, $id, "=")->getSQL();
        $this->database->getConnection()->query($sql);

        return $this->database->getConnection()->affected_rows > 0;
    }

    function update(array $fields, array $values, $id){
        $sql = $this->queryBuilder->update($this->table, $fields, $values)->where($this->primaryKey, $id, "=")->getSQL();

        return $this->executeQuery($sql);
    }

    //Generic function for executing queries(Does the whole creation of the database connection and is used to execute queries within the other functions)
    function executeQuery($sql){
        $insertId = null;
        try {
            $query = $this->database->getConnection()->query($sql);
           
            if ($query && $this->database->getConnection()->affected_rows > 0) {
                $insertId = $this->database->getConnection()->insert_id;
            }
            return $insertId;
        } catch (Exception $ex) {
            throw $ex;
        }
    }

    //Function to run a custom query(Specifically for complex queries involving joins, subqueries, stored procedures, sql functions etc)
    function query($sql){
        $query = $this->database->getConnection()->query($sql);     
        return $query->fetch_all(MYSQLI_ASSOC);
    }

    //Function that gets the details of every field in a database table
    function describe()
    {
        $sql ="DESCRIBE $this->table;";
        $query = $this->database->getConnection()->query($sql);
        $fields = [];
        if($query){
            while($row = $query->fetch_assoc()){
                $fields[$row['Field']] = $row;
            }
        }
        return $fields;
    }
}