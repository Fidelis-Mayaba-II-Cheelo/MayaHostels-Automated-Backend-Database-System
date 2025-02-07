<?php

interface ISQLQueryBuilder{
    public function select(string $table, array $fields=[]): ISQLQueryBuilder;
    public function insert(string $table, array $fields, array $values): ISQLQueryBuilder;
    public function update(string $table, array $fields, array $values, string $operator = '='): ISQLQueryBuilder;
    public function delete(string $table): ISQLQueryBuilder;
    public function where(string $field, string $value,string $operator= '='): ISQLQueryBuilder;
    public function limit(int $start, int $offset): ISQLQueryBuilder;
    public function drop(string $table=null, string $constraint=null, string $choice): ISQLQueryBuilder;
    public function getSQL(): string;
}