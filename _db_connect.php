<?php

header('Content-Type:text/json');
$dbms = 'mysql';
$host = 'localhost';
$dbname = 'FaceDB';
$user = 'root';
$password = '';

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

