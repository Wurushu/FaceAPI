<!doctype html>
<html lang="en">
<head>
    <?php
    include('_head.php');
    ?>
</head>
<body>
<div id="app">
    <?php
    include('_navbar.php');
    ?>
    <main class="py-4">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <table class="table table-bordered table-hover mt-5">
                        <tbody>
                        <?php

                        $dbms = 'mysql';
                        $host = 'localhost';
                        $dbname = 'FaceDB';
                        $user = 'root';
                        $password = '';

                        $conn = new PDO("mysql:host={$host};dbname={$dbname}", $user, $password);

                        $statement = $conn->query("SELECT `device` FROM `faces` GROUP BY `device`");

                        // TODO: Video url?
                        foreach ($statement as $row) {

                            ?>
                            <tr>
                                <td>
                                    <a class="video-link" href="<?php echo '../' . 'walk.mp4'; ?>"><?php echo $row['device']; ?></a>
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
    </main>
</div>
</body>
</html>