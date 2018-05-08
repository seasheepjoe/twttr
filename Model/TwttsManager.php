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
        $request = $pdo->prepare("INSERT INTO `twtts` (`id`, `author`, `content`) VALUES (NULL, :author, :content)");
        $request->bindParam(':author', $user_id);
        $request->bindParam(':content', $content);
        $request->execute();
    }

    public function getTwtts()
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $request = $pdo->query("SELECT twtts.*, users.name AS author_name, users.pp_url FROM twtts LEFT JOIN users ON users.id = twtts.author");
        $twtts = $request->fetchAll();
        return $twtts;
    }

    public function setRtwtt($user_id, $twtt_id)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);

        $ifRt = $pdo->prepare("SELECT * FROM `rtwtt` WHERE `user_id` = :user_id AND `twtt_id` = :twtt_id");
        $ifRt->bindParam(':user_id', $user_id);
        $ifRt->bindParam(':twtt_id', $twtt_id);
        $ifRt->execute();

        $request = $pdo->prepare("INSERT INTO `rtwtt` (`id`, `twtt_id`, `user_id`) VALUES (NULL, :twtt_id, :user_id)");
        $request->bindParam(':user_id', $user_id);
        $request->bindParam(':twtt_id', $twtt_id);

        $burnRt = $pdo->prepare("DELETE FROM `rtwtt` WHERE `twtt_id` = :twtt_id AND `user_id` = :user_id");
        $burnRt->bindParam(':twtt_id', $twtt_id);
        $burnRt->bindParam(':user_id', $user_id);

        if (empty($ifRt->fetchAll())) {
            $request->execute();
            return json_encode(['status' => 'Rtwtt added on ' . $twtt_id]);
        } else {
            $burnRt->execute();
            return json_encode(['status' => 'Rtwtt removed on ' . $twtt_id]);
        }
    }
}