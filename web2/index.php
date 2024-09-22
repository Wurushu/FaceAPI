<?php
$results_convert = [];

if (!empty($_FILES['face'])) {
    $fileFace = $_FILES['face'];
    $imageFolder = '../image/';

    if ($fileFace['error'] === UPLOAD_ERR_OK) {
        if (file_exists($imageFolder . $fileFace['name'])) {
            rename($imageFolder . $fileFace['name'], $imageFolder . bin2hex(random_bytes(10)) . '.jpg');
        }

        move_uploaded_file($fileFace['tmp_name'], $imageFolder . $fileFace['name']);
    } else {
        echo '<script>alert("錯誤：' . $fileFace['error'] . '");</script>';
    }

    $pythonCmd = "conda run -n face-env python ../no_merge.py --image " . $imageFolder . $fileFace['name'];
    exec($pythonCmd, $output);

    if (count($output) > 0) {
        $results = json_decode($output[0]);

        foreach ($results as $result) {
            if (array_key_exists($result[2], $results_convert)) {
                $results_convert[$result[2]][] = floor($result[0]);
            } else {
                $results_convert[$result[2]] = [floor($result[0])];
            }
        }
    }

}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <?php
    include('_head.php');
    ?>
    <style>
        body {
            background-color: black;
        }

        video.bg-video {
            transform: translateX(-30%) translateY(-50%);
        }

        .video-result {
            max-height: 615px;
            overflow-y: auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            color: #333;
        }

        .video-result-block {
            display: none;
        }

        .video-result-block.active {
            display: block;
        }

        .link-videos {
            position: absolute;
            font-family: system-ui;
            font-size: 1.5rem;
            top: 25px;
            right: -1rem;
            text-decoration: none;
        }

        .preview-image {
            position: absolute;
            z-index: 1;
            top: 50%;
            right: 100px;
            padding: 20px;
            border-radius: 5px;
            transform: translateY(-50%);
            background-color: #fff;
            max-width: 200px;
        }

        .preview-image img{ 
            width: 100%;
        }
    </style>
</head>
<body>
<video class="bg-video" playsinline autoplay muted loop>
    <source src="assets/video/example.mp4" type="video/mp4"/>
</video>
<?php
if (!empty($_FILES['face'])) {
    ?>
    <div class="preview-image">
        <img src="<?php echo $imageFolder . $fileFace['name']; ?>" alt="">
    </div>
    <?php
}
?>

<div class="masthead">
    <div class="masthead-content text-white">
        <div class="container-fluid px-4 px-lg-0">
            <h1 class="fst-italic lh-1 mb-5 mt-3" style="cursor: pointer;" onclick="location.href='index.php';">
                Face Surveillance System
                <a class="link-videos" href="videos.php">Show Videos</a>
            </h1>
            <div class="search-loading text-center my-3" style="display: none;">
                <div class="spinner-border text-success" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <?php
            if (!empty($_FILES['face'])) {
                if (count($results_convert) == 0) {
                    ?>
                    <div class="alert alert-danger my-4" role="alert">
                        Face Not Found.
                    </div>
                    <?php
                } else {

                    ?>


                    <div id="videoResult" class="video-result mt-3 mb-5">
                        <?php
                        $i = 0;
                        foreach ($results_convert as $key => $result_convert) {
                            $i++;
                            sort($result_convert);
                            ?>
                            <div class="video-result-block <?php echo $i == 1 ? 'active' : ''; ?>">
                                <video id="video_<?php echo $i; ?>" class="w-100" src="../<?php echo $key; ?>"
                                       controls></video>
                                <div class="result-timeline mb-4">
                                    <p style="margin: 0;">Face appears in:</p>
                                    <p class="time-link">
                                        <?php
                                        foreach ($result_convert as $timeline) {
                                            ?>
                                            <a href="#video_<?php echo $i; ?>"
                                               data-seconds="<?php echo $timeline; ?>"><?php echo $timeline . 's'; ?></a>
                                            <?php
                                        }
                                        ?>
                                    </p>
                                </div>
                                <div class="result-page row">
                                    <div class="col-2">
                                        <button class="btn btn-primary btn-page-prev"
                                                type="button" <?php echo $i == 1 ? 'disabled' : ''; ?>><
                                        </button>
                                    </div>
                                    <div class="col-2 offset-8 text-end">
                                        <button class="btn btn-primary btn-page-next"
                                                type="button" <?php echo $i == count($results_convert) ? 'disabled' : ''; ?>>
                                            >
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <?php
                        }
                        ?>
                    </div>

                    <?php
                }
            }
            ?>


            <form id="formSearch" method="post" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-10 mb-3">
                        <label for="formFile" class="form-label">Face Searching:</label>
                        <input class="form-control" type="file" id="searchFaceFile" name="face">
                    </div>
                    <div class="col-md-12">
                        <button id="btn_search_face" class="btn btn-primary" type="submit">Search</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<?php
include('_script.php');
?>
</body>
</html>
