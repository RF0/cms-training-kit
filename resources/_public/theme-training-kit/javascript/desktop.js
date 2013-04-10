$(function() {
    initHandleMainMenu();
});

function initHandleMainMenu() {
    $('#toggle-main-menu').on('click', function(e) {
        e.preventDefault();
        $('#main-menu').slideToggle();
    });
}