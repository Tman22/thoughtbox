function changeStatus() {
  $('.links').delegate('.Unread', 'click', function() {
    var that = this;
    var id = this.parentElement.parentElement.id;
    var data = {}
    data['status'] = true;
    updateStatus(that, id, data)
  });
}

function updateStatus(div, id, data) {
  $.ajax({
    url: '/api/v1/links/' + id,
    type: 'PUT',
    data: { data },
    success: function() {
      console.log('START AGAIN!')
    }
  })
}
