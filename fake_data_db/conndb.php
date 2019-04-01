<?php
$pdo = null;

try {
    $pdo = new PDO('mysql:host=localhost; dbname=sgbd_garage; port=3306; charset=utf8', 'root', '');
} catch (PDOException $e) {
    echo 'Erreur de connexion: ' . $e->getMessage();
}
