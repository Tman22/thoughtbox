function changeStatusToUnread() {
  $('.links').delegate('.Read', 'click', function() {
    var id = this.parentElement.parentElement.id;
    var data = {}
    data['status'] = false;
    updateStatus(id, data)
  });
}

function changeStatusToRead() {
  $('.links').delegate('.Unread', 'click', function() {
    var id = this.parentElement.parentElement.id;
    var data = {}
    data['status'] = true;
    updateStatus(id, data)
  });
}

function updateStatus(id, data) {
  $.ajax({
    url: '/api/v1/links/' + id,
    type: 'PUT',
    data: { data },
    success: function() {
      $('.links').empty();
      fetchLinks();
    }
  })
}

function fetchLinks() {
  $.getJSON('/api/v1/links.json', function(data) {
    $.each(data, function(index, link) {
      singleLink(link);
    })
  })
}

var statusOutput = function(link) {
  if(link.status === false) {
    return "Unread"
  } else {
    return "Read"
  }
}

function singleLink(link) {
  $('.links').append(
  "<div id='" + link.id + "'>" +
    "<h3>" + link.title + "</h3>" +
    "<ul><li class='" + statusOutput(link) + "'><a href='" +
      link.url + "'>" +
      link.url + "</a> - " +
      "<button>Mark as " + statusOutput(link) + "</button></li>" +
      "<li><a href='/links/" + link.id + "/edit'>Edit</a></li>"+
    "</ul>" +
  "</div>"
  )
}
