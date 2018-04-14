<?php

namespace Model;

use Cool\DBManager;

class TwttsManager
{
    public function setTwtt($user_id, $content)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        $request = $pdo->prepare("INSERT INTO `twtts` (`id`, `rt`, `author`, `content`) VALUES (NULL, 0, :author, :content)");
        $request->bindParam(':author', $user_id);
        $request->bindParam(':content', $content);
        $request->execute();
    }

    public function getTwtts()
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $request = $pdo->query("SELECT *, users.name AS author_name FROM twtts LEFT JOIN users ON users.id = twtts.author");
        $twtts = $request->fetchAll();
        return $twtts;
    }
}