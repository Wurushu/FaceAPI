$(document).on('click', '.time-link > a', function (e) {
    var video = $('#video_search_result').get(0);
    video.currentTime = parseInt($(this).data('seconds'));
    video.play();
});

$(document).on('change', '#searchFaceFile', function (e) {
    $(this).siblings('label').text($(this).get(0).files[0].name ?? 'FILE SELECTED');
});

$(document).on('change', 'input[name="dateLimit"]', function () {
    if ($(this).val() == 1) {
        $('#blockDatePick').fadeIn();
    } else {
        $('#blockDatePick').fadeOut();
    }
});