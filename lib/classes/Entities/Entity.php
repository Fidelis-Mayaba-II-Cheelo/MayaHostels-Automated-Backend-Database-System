<?php

class Entity implements JsonSerializable{
    //Stores the mapping of object properties to database fields.
    var array $__mapping = [];
    //Stores relationships between tables.
    var array $__relationships = [];

    //Converts entity properties into a JSON-serializable format.
    public function jsonSerialize(): mixed
    {
        return get_object_vars($this);
    }
}