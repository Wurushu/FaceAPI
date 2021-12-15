$(document).on('click', '.time-link > a', function (e) {
    var video = $(this).parents('.video-result-block').find('video').get(0);
    video.currentTime = parseInt($(this).data('seconds'));
    video.play();
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
    }, 1000);
});

$(document).on('click', '.btn-page-prev', function (e) {
    $(this).parents('.video-result-block').removeClass('active').prev().addClass('active');
});

$(document).on('click', '.btn-page-next', function (e) {
    $(this).parents('.video-result-block').removeClass('active').next().addClass('active');
});