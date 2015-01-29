// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    var user_cards = $('[class*="card-shirt-"]');
    user_cards.click(function() {
        trigger_move($(this), $($($('.row')[2]).find('.card')[1]));
    });
});

function trigger_move(card, target) {
    var o1 = card.offset(),
        o2 = target.offset(),

        vector = [o2.left-o1.left, o2.top-o1.top],

        p = card.position(),
        left = p.left + vector[0],
        top = p.top + vector[1];

    card.animate({ 'left': left, 'top': top }, 200 );
}
