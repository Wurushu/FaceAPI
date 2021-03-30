<?php

require_once('_config.php');

if (empty($_POST['features'])) {
    abort('Lost parameters');
}

/** @var PDO $conn */
$statment = $conn->prepare("INSERT INTO faces (`features`, `start_time`, `end_time`, `device`) VALUES (:features, :start_time, :end_time, :device)");
$result = $statment->execute([
    'features' => $_POST['features'],
    'start_time' => $_POST['start_time'] ?? 0,
    'end_time' => $_POST['end_time'] ?? 0,
    'device' => $_POST['device'] ?? null
]);

if ($result) {
    echo json_encode([
        'success' => true
    ]);
}

