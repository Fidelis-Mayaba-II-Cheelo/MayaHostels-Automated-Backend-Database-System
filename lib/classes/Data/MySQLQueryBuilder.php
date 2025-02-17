<?php

class MySQLQueryBuilder implements ISQLQueryBuilder
{

    protected $query;

    public function reset(): void
    {
        $this->query = new stdClass();
    }
    public function select(string $table, array $fields=[]): ISQLQueryBuilder
    {
        $this->reset();
        $this->query->base = "SELECT ";
        if($fields){
        $this->query->base.= implode(", ", $fields);
        }
        else{
            $this->query->base.= "*"; 
        }
        $this->query->base.=" FROM " . $table;
        $this->query->type = 'select';
        return $this;
    }

    public function insert(string $table, array $fields, array $values): ISQLQueryBuilder
    {
        $this->reset();
        $this->query->base = "INSERT INTO " . $table . " (" . implode(", ", $fields) . ") VALUES (" . implode(", ", $values) . ")";
        $this->query->type = 'insert';
        return $this;
    }

    public function update(string $table, array $fields, array $values, string $operator = '='): ISQLQueryBuilder
    {
        $this->reset();

        $sets = [];
        $count = 0;
        foreach($fields as $field){
            $value = $values[$count]===null?"NULL":("'".$values[$count]."'");
            $sets[]="$field = $value";
            $count++;
        }

        $this->query->base = "UPDATE " . $table . " SET " . implode(", ", $sets);
        $this->query->type = 'update';
        return $this;
    }

    public function delete(string $table): ISQLQueryBuilder
    {
        $this->reset();
        $this->query->base = "DELETE FROM " . $table;
        $this->query->type = 'delete';
        return $this;
    }

    public function where(string $field, string $value, string $operator = '='): ISQLQueryBuilder
    {
        if (!in_array($this->query->type, ['select', 'delete', 'update'])) {
            throw new Exception("WHERE can only be added to select, update or delete queries.");
        }
        $this->query->where[] = "$field $operator $value";
        return $this;
    }

    public function limit(int $start, int $offset): ISQLQueryBuilder
    {
        if (!in_array($this->query->type, ['select'])) {
            throw new Exception("LIMIT can only be added to SELECT queries.");
        }
        $this->query->limit = " LIMIT " . $start . ", " . $offset;
        return $this;
    }

    public function drop(string $table = null, string $constraint = null, string $choice): ISQLQueryBuilder
    {
        $this->reset();
        if ($choice == "table") {
            $this->query->base = "DROP TABLE IF EXISTS " . $table;
            $this->query->type = 'drop';
        } else if ($choice == "constraint") {
            $this->query->base = "DROP CONSTRAINT IF EXISTS " . $constraint;
            $this->query->type = 'drop';
        }
        return $this;
    }

    public function getSQL(): string
    {
        $sql = $this->query->base;

        if (isset($this->query->where) && !empty($this->query->where)) {
            $sql .= " WHERE " . implode(' AND ', $this->query->where);
        }

        if (isset($this->query->limit)) {
            $sql .= " " . $this->query->limit; 
        }

        $sql .= ";"; 
        return $sql;
    }
}
