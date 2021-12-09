$(document).on('click', '.time-link > a', function (e) {
    var video = $(this).parents('.card').find('video').get(0);
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

$(document).on('click', '.video-link', function (e) {
    window.open($(this).attr('href'), 'showVideo', "width=800,height=450");
    e.preventDefault();
});

$(document).on('click', '#btn_search_face', function (e) {
    $('.search-loading').fadeIn();
    e.preventDefault();
    setTimeout(() => {
        $('#formSearch').submit();
    }, 2000);
});