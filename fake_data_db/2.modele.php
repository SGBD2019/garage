<?php
require_once 'conndb.php';

$makesJson = null;
$makesArr = [];
$modelsJson = null;
$modelsArr = [];

$makesHandle = fopen("makes.json", "r");
if ($makesHandle) $makesJson = fgets($makesHandle);
fclose($makesHandle);
if($makesJson !== false) {
    $makesArr = json_decode($makesJson, true, 512, JSON_OBJECT_AS_ARRAY);
} else {
    die("Could not read makes file");
}

foreach($makesArr["_data"] as $makes) {
    foreach($makes as $make) {
        $sql = "";
        $statement= $pdo->prepare("SELECT id, name FROM marque WHERE name = :make;");
        $statement->bindParam(':make', $make["name"], PDO::PARAM_STR);
        $statement->execute();
        $dbMakeData = $statement->fetchAll(PDO::FETCH_ASSOC);
        if(count($dbMakeData) == 0) continue; // if that make is not in our database, skip the rest
        //var_dump($dbMakeData[0]);

        /*
        // Download all models related to the make specified => does not need to be done again
        $fp = fopen("models/{$make["id"]}.json", 'w');
        if($fp === false) continue;
        $command = "curl https://api.autoscout24.com/makes/{$make["id"]}/models -X GET -H 'X-AS24-Version: 1.1' -H 'Accept-Language: en-GB' > models/{$make["id"]}.json";
        fwrite($fp, shell_exec($command));
        echo "models/{$make["id"]}.json";
        fclose($fp);
        sleep(60);
        */

        $modelFileName = 'models/' . $make["id"] . '.json';
        $modelsHandle = fopen("$modelFileName", "r");
        if ($modelsHandle) $modelsJson = fgets($modelsHandle);
        fclose($modelsHandle);
        if($modelsJson == false) continue;

        $modelsArr = json_decode($modelsJson, true);
        foreach($modelsArr["_data"] as $models) {
            foreach($models as $model) {
                $sql = "INSERT INTO modele(name, FK_marque) VALUES ('{$model["name"]}', {$dbMakeData[0]["id"]});";
                //$sql = "INSERT INTO modele(name, FK_marque) VALUES (':modelName', ':makeId');";
                //var_dump($sql);
                $statement= $pdo->prepare($sql);
                //$statement->bindParam(':modelName', $model["name"], PDO::PARAM_STR);
                //$statement->bindParam(':makeId', $dbMakeData[0]["id"], PDO::PARAM_INT);
                $statement->execute();
            }
        }
    }
}

