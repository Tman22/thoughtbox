function searchLinks() {
  $('#search').keyup(function() {
    var context = $(this).val().toLowerCase();
    var $links = $('.link');
    $links.each(function(index, link) {
      $link = $(link);
      text = $link.find('.content').text().toLowerCase();
      if (text.indexOf(context) >= 0) {
        $link.show();
      } else {
        $link.hide();
      }
    })
  })
}
