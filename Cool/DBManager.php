<?php

namespace Cool;

class DBManager
{
    private $pdo;

    private function __construct()
    {
        global $params;
        
        $address = $params['db']['host'];
        if ($params['db']['port'])
            $address .= ':'.$params['db']['port'];
        $dsn = 'mysql:dbname='.$params['db']['name'].';host='.$address;
        $user = $params['db']['user'];
        $password = $params['db']['password'];
        $pdo = new PDO($dsn, $user, $password);
        $this->setPdo($pdo);
    }
    
    private static $instance = NULL;
    
    public static function getInstance()
    {
        if (self::$instance === NULL)
        {
            self::$instance = new DBManager();
        }
        return self::$instance;
    }
    
    public function getPdo()
    {
        return $this->pdo;
    }
    
    private function setPdo($pdo)
    {
        $this->pdo = $pdo;
    }
}
