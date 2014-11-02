@ghost_status = false

@ghost_show = ->
  ghost_status == true
  ghost = $("svg.ghost")
  ghost
    .queue ->
      $(this).attr("class", "ghost").dequeue()
      console.info 'clear'
      return 0
    .delay 1000
    .queue ->
      $(this).attr("class", "ghost before").dequeue()
      console.info 'before'
      return 0
    .delay 3000
    .queue ->
      $(this).attr("class", "ghost push").dequeue()
      console.info 'open'
      return 0
    .delay 1200
    .queue ->
      $(this).attr("class", "ghost path").dequeue()
      console.info 'show'
      return 0
    .delay 5000
    .queue ->
      $(this).attr("class", "ghost spin").dequeue()
      console.info 'close'
      return 0
    .delay 400
    # .queue ->
    #   $(this).attr("class", "ghost pop").dequeue()
    #   console.info 'close'
    #   return 0
    # .delay 1200
    .queue ->
      $(this).attr("class", "ghost after").dequeue()
      console.info 'after'
      return 0
    .delay 3000
    .queue ->
      $(this).attr("class", "ghost arrow").dequeue()
      console.info 'arrow'
      return 0
    .delay 3000
    .queue ->
      $(this).attr("class", "ghost").dequeue()
      $(this).clearQueue()
      console.info 'clear'
      return 0
  ghost_status == false
  console.log 'show'
  return 0

@map = ->
  $('#fullscreen_button').on 'click', ->
    map = document.getElementsByClassName("ghost-container")[0]
    if map.webkitRequestFullscreen
      map.webkitRequestFullscreen()

  dispatcher = new WebSocketRails window.location.host + '/websocket'

  success = (response) ->
    console.info response.message

  failure = (response) ->
    console.error response.message

  avelage = (arr) ->
    sum = 0
    for i in arr
      sum += i
    return sum/arr.length

  dispatcher.on_open = ->
    console.info 'Connection Start'

  channel = dispatcher.subscribe 'streaming'
  channel.bind 'create', (beacon) ->
    if ghost_status == false
      points = []
      for key, val of beacon
        points.push Math.abs(Math.round((val.proximity * 100)))

      status = Number(avelage(points))
      if status < 220
        ghost_show()
