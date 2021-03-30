<?php

// Fill in Database information here.
$dbms = 'mysql';
$host = 'localhost';
$dbname = 'FaceDB';
$user = 'root';
$password = '';

header('Content-Type:text/json');
try {
    $conn = new PDO("mysql:host={$host};dbname={$dbname}", $user, $password);
} catch (PDOException $e) {
    abort('Database connect error!');
}

function abort($message = null) {
    if (empty($message)) {
        $message = 'Unknown error...';
    }

    die(json_encode([
        'success' => false,
        'message' => $message
    ]));
}

