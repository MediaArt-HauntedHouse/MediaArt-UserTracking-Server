@obake = () ->
  # dispatcher = new WebSocketRails window.location.host + '/websocket'

  # success = (response) ->
  #   console.info response.message

  # failure = (response) ->
  #   console.error response.message

  # dispatcher.on_open = ->
  #   console.info 'Connection Start'

  # channel = dispatcher.subscribe 'streaming'
  # channel.bind 'newpicture', (picture) ->
  #   obakes = $('.obake')
  #   obake = obakes[Math.floor(Math.random() * obakes.length)]
  #   console.log obake
  #   console.log obake.attr("src")
  #   return 0

  $('#fullscreen_button').on 'click', ->
    map = document.getElementsByClassName("container-view")[0]
    if map.webkitRequestFullscreen
      map.webkitRequestFullscreen()

  colors = [
    '#224687',
    '#2ABFD4',
    '#FFCD40',
    '#E61875',
    '#8BC34A',
    '#AB47BC'
  ]

  $('.obake').each (index, ele) ->
    setInterval ->
      $(ele).css({
        borderColor: colors[Math.floor(Math.random() * colors.length)],
        transform: "scale(" + Math.random() + ")",
        borderRadius: "16%",
        opacity: 1
      })
      return 0
    ,  Math.random() * 500 + 500

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