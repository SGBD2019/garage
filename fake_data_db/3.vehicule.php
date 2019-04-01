<?php
require_once 'vendor/fzaninotto/faker/src/autoload.php';
require_once 'conndb.php';

$statement= $pdo->prepare("SELECT id FROM modele");
$statement->execute();
$arrModelsId = $statement->fetchAll(PDO::FETCH_ASSOC);

$faker = Faker\Factory::create('fr_BE');
$sqlStrStart = 'INSERT INTO vehicule (cylindree, annee, numero_chassis, remarques, carburant, type_chassis, premiere_immatriculation, boite, nbre_portes, nbre_sieges, couleur, puissance, emission_co2, FK_modele) VALUES (';
$sqlStrEnd = ');';

for($i = 0; $i < 1000; $i++) {

    $cylindree = $faker->randomElement([1100,1200,1300,1400,1500,1600,1700,1800,1900,2000]);
    $annee = $faker->dateTimeBetween('-10 years', 'now')->format('Y');
    $numChassis = $faker->shuffle(strtoupper(str_replace(' ', '', strval($faker->randomNumber(9)) . $faker->word . $faker->word)));
    $remarque = $faker->text(100);
    $carburant = $faker->randomElement(['Essence', 'Diesel', 'LPG']);
    $typeChassis = $faker->randomElement(['A', 'B', 'C']);
    $premiereImmatriculation = $faker->dateTimeBetween('-10 years', '-7 days')->format('Y-m-d');
    $boite = $faker->randomElement(['automatique', 'manuelle', 'semi-automatique']);
    $nbrePortes = $faker->randomElement([3, 5, 7]);
    $nbreSieges = $faker->randomElement([3, 5, 7]);
    $couleur =$faker->colorName;
    $puissance = $faker->numberBetween(5, 17);

    $emissionCO2 = $faker->randomElement(['EURO 1', 'EURO 2', 'EURO 3', 'EURO 4', 'EURO 5', 'EURO 6']);
    $fkModele  = $faker->randomElement($arrModelsId)["id"];


    $sqlStr = $sqlStrStart .
        "'{$cylindree}', '{$annee}', '{$numChassis}', '{$remarque}', '{$carburant}', '{$typeChassis}', '{$premiereImmatriculation}', '{$boite}', '{$nbrePortes}', '{$nbreSieges}', '{$couleur}', '{$puissance}', '{$emissionCO2}', '{$fkModele}'" .
        $sqlStrEnd;

    //if($i == 0) echo $sqlStr;
    $count = $pdo->exec($sqlStr);
    //echo 'Number of rows affected: ' . $count;
}




