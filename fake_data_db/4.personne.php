<?php
require_once 'vendor/fzaninotto/faker/src/autoload.php';
require_once 'conndb.php';

$faker = Faker\Factory::create('fr_BE');
$sqlStrStart = 'INSERT INTO personne (prenom, nom, telephone, email, adresse, code_postal, date_naissance, remarques, login) VALUES (';
$sqlStrEnd = ');';

for($i = 0; $i < 200; $i++) {

    $firstName = $faker->firstName;
    $firstName = str_replace(' ', '', $firstName);
    $lastName = $faker->lastName;
    $lastName = str_replace(' ', '', $lastName);
    $email = $firstName . '.' . $lastName . '@sgbd2019.be';
    $phoneNumber = $faker->phoneNumber;
    $address = $faker->streetAddress;
    $postalCode = $faker->postcode;
    $birthDate = $faker->dateTimeBetween('-60 years', '-18 years');
    $remarks = $faker->text(200);
    $login = $firstName . '.' . $lastName;

    $sqlStr = $sqlStrStart .
        "'{$firstName}', '{$lastName}', '{$phoneNumber}', '{$email}', '{$address}', '{$postalCode}', '{$birthDate->format('Y-m-d')}', '{$remarks}', '{$login}'" .
        $sqlStrEnd;

    //if($i == 0) echo $sqlStr;
    $count = $pdo->exec($sqlStr);
    //echo 'Number of rows affected: ' . $count;
}




