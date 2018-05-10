<?php

namespace Model;

use Cool\DBManager;

class TwttsManager
{
    public function setTwtt($user_id, $content, $date = NULL, $rt_author = NULL)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        $request = $pdo->prepare("INSERT INTO `twtts` (`id`, `rt`, `rt_author`, `author`, `content`, `date`) VALUES (NULL, :rt, :rt_author, :author, :content, :date)");
        isset($rt_author) ? $rt = 1 : $rt = NULL;
        $request->bindParam(':rt', $rt);
        $request->bindParam(':rt_author', $rt_author);
        $request->bindParam(':author', $user_id);
        $request->bindParam(':content', $content);
        isset($date) ? : $date = date("Y-m-d H:i:s");
        $request->bindParam(':date', $date);
        $request->execute();
    }

    public function unsetTwtt($twtt_id)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $request = $pdo->prepare("DELETE FROM `twtts` WHERE `twtts`.`id` = $twtt_id");

        $request->execute();
    }

    public function setRT($twtt_id, $rtwtter)
    {
        $twtt = $this->getTwtt($twtt_id);
        return $this->setTwtt($twtt['author'], $twtt['content'], $twtt['date'], $rtwtter);
    }

    public function unsetRT($twtt_id, $rtwtter)
    {
        $twtt = $this->getTwtt($twtt_id);
        $rt = $this->getRT($twtt['content'], $rtwtter);
        return $this->unsetTwtt($rt['id']);
    }

    public function getRT($content, $rt_author)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $request = $pdo->query("SELECT * FROM `twtts` WHERE twtts.content = '$content' AND twtts.rt = 1 AND twtts.rt_author = $rt_author");
        return $request->fetch(\PDO::FETCH_ASSOC);
    }

    public function getTwtt($twtt_id)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $request = $pdo->query("SELECT * FROM `twtts` WHERE twtts.id = $twtt_id");
        return $request->fetch(\PDO::FETCH_ASSOC);
    }

    public function getTwtts()
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $user = $_SESSION['id'];
        $request = $pdo->query("SELECT twtts.*, users.name AS author_name, users.pp_url, u2.name AS rt_author_name FROM twtts LEFT JOIN users ON users.id = twtts.author LEFT JOIN users u2 ON u2.id = twtts.rt_author WHERE twtts.author IN( SELECT followed FROM `follows` WHERE follower = $user ) OR twtts.author = $user OR twtts.rt_author = $user ORDER BY `post_time` DESC");
        $twtts = $request->fetchAll(\PDO::FETCH_ASSOC);
        foreach ($twtts as $key => $value) {
            $id = $value['id'];
            $twtts[$key]['favs'] = $this->getFavs($id);
            $twtts[$key]['rtwtts'] = $this->getRtwtts($id);
            $twtts[$key]['rtwtted'] = $this->isRT($twtts[$key]['id'], $_SESSION['id']) ? true : false;
            $twtts[$key]['faved'] = $this->isFav($twtts[$key]['id'], $_SESSION['id']) ? true : false;
        }
        return $twtts;
    }

    public function isRT($twtt_id, $user_id)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        return $pdo->query("SELECT * FROM `rtwtt` WHERE `rtwtt`.`user_id` = '$user_id' AND `rtwtt`.`twtt_id` = '$twtt_id'")->fetch(\PDO::FETCH_ASSOC);
    }

    public function isFav($twtt_id, $user_id)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        return $pdo->query("SELECT * FROM `favs` WHERE `favs`.`user_id` = '$user_id' AND `favs`.`twtt_id` = '$twtt_id'")->fetch(\PDO::FETCH_ASSOC);
    }

    public function getUserTwtts($user_id)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $request = $pdo->query("SELECT twtts.*, users.name AS author_name, users.pp_url FROM twtts LEFT JOIN users ON users.id = twtts.author WHERE twtts.author = $user_id OR twtts.rt_author = $user_id ORDER BY `twtts`.`date` DESC");
        $twtts = $request->fetchAll(\PDO::FETCH_ASSOC);
        foreach ($twtts as $key => $value) {
            $id = $value['id'];
            $twtts[$key]['favs'] = $this->getFavs($id);
            $twtts[$key]['rtwtts'] = $this->getRtwtts($id);
            if (isset($_SESSION['id']))
            {
                $twtts[$key]['rtwtted'] = $this->isRT($twtts[$key]['id'], $_SESSION['id']) ? true : false;
                $twtts[$key]['faved'] = $this->isFav($twtts[$key]['id'], $_SESSION['id']) ? true : false;
            }
        }
        return $twtts;
    }

    public function getFavs($id)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);

        $getFavs = $pdo->prepare("SELECT COUNT(favs.id) AS favs FROM favs WHERE favs.twtt_id = ?");
        $getFavs->execute([$id]);

        return $getFavs->fetch()['favs'];
    }

    public function getRtwtts($id)
    {
        $dbManager = DBManager::getInstance();
        $pdo = $dbManager->getPdo();
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);

        $getFavs = $pdo->prepare("SELECT COUNT(rtwtt.id) AS rtwtts FROM rtwtt WHERE rtwtt.twtt_id = ?");
        $getFavs->execute([$id]);

        return $getFavs->fetch()['rtwtts'];
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
            if ($type == 'rtwtt')
            {
                $this->setRT($twtt_id, $user_id);
            }
            return json_encode([
                'status' => $type . ' added on ' . $twtt_id,
                'rtwtts' => $this->getRtwtts($twtt_id),
                'favs'   => $this->getFavs($twtt_id),
                'type'   => $type,
                'action' => 'do'
            ]);
        } else {
            $burnReaction->execute();
            if ($type == 'rtwtt')
            {
                $this->unsetRT($twtt_id, $user_id);
            }
            return json_encode([
                'status' => $type . ' removed on ' . $twtt_id,
                'rtwtts' => $this->getRtwtts($twtt_id),
                'favs'   => $this->getFavs($twtt_id),
                'type'   => $type,
                'action' => 'undo'
            ]);
        }
    }
}