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

    public function setReaction($type, $user_id, $twtt_id)
    {

        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);

        $ifReactionExists = $pdo->prepare("SELECT * FROM $type WHERE `user_id` = :user_id AND `twtt_id` = :twtt_id");
        $ifReactionExists->bindParam(':user_id', $user_id);
        $ifReactionExists->bindParam(':twtt_id', $twtt_id);
        $ifReactionExists->execute();

        $request = $pdo->prepare("INSERT INTO $type (`id`, `twtt_id`, `user_id`) VALUES (NULL, :twtt_id, :user_id)");
        $request->bindParam(':user_id', $user_id);
        $request->bindParam(':twtt_id', $twtt_id);
        

        $burnReaction = $pdo->prepare("DELETE FROM $type WHERE `twtt_id` = :twtt_id AND `user_id` = :user_id");
        $burnReaction->bindParam(':user_id', $user_id);
        $burnReaction->bindParam(':twtt_id', $twtt_id);

        if (empty($ifReactionExists->fetchAll())) {
            $request->execute();
            return json_encode(['status' => $type . ' added on ' . $twtt_id]);
        } else {
            $burnReaction->execute();
            return json_encode(['status' => $type . ' removed on ' . $twtt_id]);
        }
    }
}