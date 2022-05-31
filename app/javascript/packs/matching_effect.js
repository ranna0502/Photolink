
// 依頼ボタンクリック時にポップアップ
$(document).on('submit','.like-form',function(){
    $('.popup').addClass('show').fadeIn();
});

// ポップアップ閉じる
$('#close').on('click',function(){
    $('.popup').fadeOut();
});

