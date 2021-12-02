<?php
if (!empty($_FILES['face'])) {
    $fileFace = $_FILES['face'];

    if ($fileFace['error'] === UPLOAD_ERR_OK) {
        if (file_exists('upload/' . $fileFace['name'])) {
            rename('upload/' . $fileFace['name'], 'upload/' . bin2hex(random_bytes(10)) . '.jpg');
        }

        move_uploaded_file($fileFace['tmp_name'], 'upload/' . $fileFace['name']);
    } else {
        echo '<script>alert("錯誤：' . $fileFace['error'] . '");</script>';
    }

    //shell_exec('python input.py --image ' . 'web/upload/' . $fileFace['name']);
    $resultVideo = '../walk.mp4';
    $timelines = [13, 31, 65];
}
?>
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
                <div class="col-md-10">
                    <div class="search-loading text-center my-3" style="display: none;">
                        <div class="spinner-border text-success" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                    </div>

                    <?php
                    if (!empty($resultVideo)) {
                        ?>
                        <div class="card card-video-result my-3">
                            <div class="card-header">Search Result</div>

                            <div class="card-body">
                                <div class="col-md-10 offset-md-1">
                                    <video id="video_search_result" class="w-100" src="assets/video/example.mp4"
                                           controls></video>
                                </div>
                                <div class="col-md-10 offset-md-1 mt-3">
                                    <p>Face appear in:</p>
                                    <p class="time-link">
                                        <?php
                                        if (!empty($timelines)) {
                                            foreach ($timelines as $timeline) {
                                                $timeline_seconds = ($timeline % 60);

                                                $timeline_ms = floor($timeline / 60) . ':' . sprintf('%02d',$timeline % 60);
                                                ?>
                                                <a href="#"
                                                   data-seconds="<?php echo $timeline; ?>"><?php echo $timeline_ms; ?></a>
                                                <?php
                                            }
                                        }
                                        ?>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <?php
                    } else {
                        ?>
                        <div class="card card-video-example my-3">
                            <div class="card-header">Video Example</div>

                            <div class="card-body">
                                <div class="col-md-12">
                                    <video class="w-100" src="assets/video/example.mp4" controls></video>
                                </div>
                            </div>
                        </div>
                        <?php
                    }
                    ?>

                    <div class="card my-3">
                        <div class="card-header">Face Searching</div>

                        <div class="card-body">
                            <form method="post" enctype="multipart/form-data">
                                <div class="col-md-12">
                                    <div class="form-check text-center my-2" style="display: none">
                                        <input class="form-check-input" type="radio" name="dateLimit"
                                               id="dateLimit_0" value="0" checked>
                                        <label class="form-check-label" for="dateLimit_0">無限期</label>
                                    </div>
                                    <div class="form-check text-center my-2" style="display: none">
                                        <input class="form-check-input" type="radio" name="dateLimit"
                                               id="dateLimit_1" value="1">
                                        <label class="form-check-label" for="dateLimit_1">選擇日期</label>
                                    </div>
                                    <div id="blockDatePick" style="display: none">
                                        <div class="form-group row">
                                            <div class="col-md-8 offset-md-2 row">
                                                <label for="searchDateStart" class="col-sm-4 col-form-label text-right">起始日期: </label>
                                                <div class="col-sm-6">
                                                    <input id="searchDateStart" type="date" class="form-control"
                                                           name="searchDateStart" value="<?php echo date('Y-m-d'); ?>">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <div class="col-md-8 offset-md-2 row">
                                                <label for="searchDateEnd" class="col-sm-4 col-form-label text-right">結束日期: </label>
                                                <div class="col-sm-6">
                                                    <input id="searchDateEnd" type="date" class="form-control"
                                                           name="searchDateEnd" value="<?php echo date('Y-m-d'); ?>">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mt-4">
                                        <div class="input-group w-50 mx-auto">
                                            <div class="custom-file">
                                                <input type="file" class="custom-file-input" id="searchFaceFile"
                                                       aria-describedby="searchFaceFile" name="face">
                                                <label class="custom-file-label" for="searchFaceFile">Choose file (.jpg,
                                                    .png)</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12 text-center mt-4">
                                    <button id="btn_search_face" class="btn btn-primary" type="submit">Search</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>