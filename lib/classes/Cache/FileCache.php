<?php

class FileCache implements ICache
{
    private $cacheFilePath;

    public function __construct()
    {
        $this->cacheFilePath = __DIR__ . '/classes/Data/CacheData.json';
        $this->checkIfFileExists();
    }

    private function checkIfFileExists()
    {
        $directory = dirname($this->cacheFilePath);
        if (!is_dir($directory)) {
            mkdir($directory, 0777, true);
        }

        if (!file_exists($this->cacheFilePath)) {
            file_put_contents($this->cacheFilePath, json_encode([]));
        }
    }

    public function put($key, $data)
    {
        $currentData = json_decode(file_get_contents($this->cacheFilePath), true);

        $currentData[$key] = $data;

        file_put_contents($this->cacheFilePath, json_encode($currentData));
    }

    public function get($key)
    {
        $currentData = json_decode(file_get_contents($this->cacheFilePath), true);
        //return json_decode($currentData[$key] ?? []);
        //return json_decode($currentData[$key]??'[]');

        // Retrieving the value associated with the key
        $value = $currentData[$key] ?? [];

        // If the value is already an array, return it as-is
        if (is_array($value)) {
            return $value;
        }

        // Otherwise, decode the JSON string 
        return json_decode($value, true) ?? [];
    }

    public function destroy($key)
    {

        $currentData = json_decode(file_get_contents($this->cacheFilePath), true);

        if (isset($currentData[$key])) {
            unset($currentData[$key]);

            file_put_contents($this->cacheFilePath, json_encode($currentData));
        }
    }

    public function destroyAll()
    {
        file_put_contents($this->cacheFilePath, json_encode([]));
    }
}