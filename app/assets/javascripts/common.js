$(function() {

    $("a.back").click(function() {
        if (window.history.length <= 1) {
            window.location.href = 'http://thxl.memeing.cn/';
        } else {
            window.history.back();
        }
    });
});