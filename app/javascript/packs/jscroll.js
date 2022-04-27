$(document).on('scroll', function() {
    $('.jscroll-div').jscroll({ // 追加したdivのclass名と合わせる
      contentSelector: '.jscroll-container',
      nextSelector: 'span.next:last a',  // 次ページリンクのセレクタ
    });
  });


