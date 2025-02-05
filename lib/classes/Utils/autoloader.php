<?php
spl_autoload_register('autoloader');

function autoloader($classname) {
    //base directory
    $baseDir = "classes/";
    $filename = $classname . '.php';

    // Search recursively in subdirectories
    $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($baseDir));
    foreach ($iterator as $file) {
        if ($file->isFile() && basename($file) === $filename) {
            include_once $file->getPathname();
            return;
        }
    }

    error_log("Autoloader could not find class: $classname");
}