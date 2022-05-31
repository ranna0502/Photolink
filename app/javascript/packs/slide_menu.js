// スライドメニュー

$('#btn-menu').on('click', function(){
  SlideMenu()
});

const SlideMenu = () => {
  if($('#slideL').hasClass("SlideOut")){
    // スライドメニューが非表示なら表示
    $('#slideL').removeClass('SlideOut');
    $('#slideL').addClass('SlideIN');
  } else {
    // スライドメニューがあれば非表示
    $('#slideL').removeClass('SlideIN');
    $('#slideL').addClass('SlideOut');
  }
}

//開閉ボタン

$('#btn-menu').on('click',function(){
  if($('#btn-menu').hasClass('off')){

    $('#btn-menu').removeClass('off');
    $('#btn-menu').addClass('on');
  }else{
    $('#btn-menu').removeClass('on');
    $('#btn-menu').addClass('off');
  }
});

$('#btn-menu').on('click', function () {
  if ($(this).text() === 'MENU') {
    $(this).text('CLOSE');
  } else {
    $(this).text('MENU');
  }
});


// メニュー内にあるタグ４つ

$('#tab-contents .tab[id != "tab1"]').hide();

$('#tab-menu a').on('click', function(event) {
  $("#tab-contents .tab").hide();
  $("#tab-menu .active").removeClass("active");
  $(this).addClass("active");
  $($(this).attr("href")).show();
  event.preventDefault();
});