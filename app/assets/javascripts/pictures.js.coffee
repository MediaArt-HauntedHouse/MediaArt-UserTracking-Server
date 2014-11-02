@picture = ->
  dispatcher = new WebSocketRails window.location.host + '/websocket'

  success = (response) ->
    console.info response.message

  failure = (response) ->
    console.error response.message

  dispatcher.on_open = ->
    console.info 'Connection Start'

  channel = dispatcher.subscribe 'streaming'
  channel.bind 'newpicture', (picture) ->
    console.log picture
    table = $('table.table tbody')

    img = $('<img>', {"class": "picture", "width": "64", "height": "64", "src": picture.body})
    buttons = $('<div>', {"class": "btn-group"})
    dl = $('<a>', {'class': 'btn btn-success', 'href': 'data:Application/octet-stream,'+picture.body, 'download': 'image.png'})
    del = $('<a>', {'class': 'btn btn-default', 'data-method': 'DELETE', 'href': '/pictures/' + picture.id})
    show = $('<a>', {'class': 'btn btn-default', 'href': '/pictures/' + picture.id})
    buttons.append dl.append $('<i>', {'class':'fa fa-download fa-fw'})
    buttons.append show.append $('<i>', {'class':'fa fa-search fa-fw'})
    buttons.append del.append $('<i>', {'class':'fa fa-trash fa-fw'})
    tr = $('<tr>')
    tr.append $('<td>').text(picture.id)
    tr.append $('<td>').append(img)
    tr.append $('<td>').text(picture.created_at)
    tr.append $('<td>', {'class':'text-right'}).append buttons

    tr.prependTo(table).hide().fadeIn(1000);
return 0