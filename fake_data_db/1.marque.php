<?php
require_once 'conndb.php';

$makesSql = file_get_contents('marque.sql');

if(!empty($makesSql)) {
    $pdo->exec($makesSql);
} else {
    die("Could not read makes file");
}
