<?php

interface IDatabaseHelper
{
    public static function getInstance(): IDatabaseHelper;
    public function getConnection();
}
