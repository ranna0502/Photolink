$('#slideL').on('click',function(){
  if($('#slideL').hasClass('.off')){
    $('#slideL').removeClass('.off');
    $(this).animate({'marginLeft':'350px'},300).addClass('.on');
  }else{
    $('#slideL').addClass('.off');
    $(this).animate({'marginLeft':'0px'},300);
  }
});


//左のコンテンツ用にウィンドウの高さを取得
$(document).ready(function(){
  fit();
  $(window).resize(function(){
    fit();
  })
  function fit(){
    var h = $(window).height();
    $('.slide-inner').css("height",h);
  }
})
