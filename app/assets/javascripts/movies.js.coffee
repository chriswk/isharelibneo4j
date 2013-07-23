jQuery ->
  $("#find_tmdb").click ->
    url = $(this).data("url")
    $.ajax url,
      type: 'GET'
      dataType: 'json',
      success: (data, textStatus, jqXHR) ->
        window.location.reload(true)