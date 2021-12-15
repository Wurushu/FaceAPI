<!doctype html>
<html lang="en">
<head>
    <?php
    include('_head.php');
    ?>
    <style>
        .video-table {
            height: 500px;
            overflow: auto;
        }
    </style>
</head>
<body>
<video class="bg-video" playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop">
    <source src="assets/video/example.mp4" type="video/mp4"/>
</video>
<div class="masthead">
    <div class="masthead-content text-white">
        <div class="container-fluid px-4 px-lg-0">
            <h1 class="fst-italic lh-1 mb-5 mt-3" style="cursor: pointer;" onclick="location.href='index.php';">
                Face Surveillance System
            </h1>
            <div class="video-table">
                <table class="table table-bordered table-hover">
                    <tbody>
                    <?php

                    $dbms = 'mysql';
                    $host = 'localhost';
                    $dbname = 'FaceDB';
                    $user = 'root';
                    $password = '';

                    $conn = new PDO("mysql:host={$host};dbname={$dbname}", $user, $password);

                    $statement = $conn->query("SELECT `device` FROM `faces` GROUP BY `device`");

                    foreach ($statement as $row) {

                        ?>
                        <tr>
                            <td>
                                <a class="video-link"
                                   href="<?php echo '../' . $row['device']; ?>"><?php echo $row['device']; ?></a>
                            </td>
                        </tr>
                        <?php
                    }

                    ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<?php
include('_script.php');
?>
</body>
</html>