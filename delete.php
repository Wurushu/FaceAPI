<?php

require_once('_config.php');

if (empty($_POST['id'])) {
    abort('Lost parameters');
}

/** @var PDO $conn */
$statment = $conn->prepare("DELETE faces WHERE `id` = :id;");
$result = $statment->execute([
    'id' => $_POST['id']
]);

if ($result) {
    echo json_encode([
        'success' => true
    ]);
}

