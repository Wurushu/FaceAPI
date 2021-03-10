<?php

require_once('_db_connect.php');

if (empty($_POST['features']) || empty($_POST['time']) || empty($_POST['camera'])) {
    abort('Lost parameters');
}

/** @var PDO $conn */
$statment = $conn->prepare("INSERT INTO faces (`features`, `time`, `camera`) VALUES (:features, :time, :camera)");
$result = $statment->execute([
    'features' => $_POST['features'],
    'time' => $_POST['time'],
    'camera' => $_POST['camera']
]);

if ($result) {
    echo json_encode([
        'success' => true
    ]);
}

