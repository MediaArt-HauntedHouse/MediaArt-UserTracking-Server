# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
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
      if status < 110
        console.log 'inside'
        ghost_show()
  channel.bind 'create_old', (beacon) ->

    polygon = document.createElementNS("http://www.w3.org/2000/svg", "polygon")
    points_x = []
    points_y = []
    points = []
    for key, val of beacon
      # points_x.push Math.abs(beacons[val.major-1].x - Math.round((val.proximity * 100)))
      # points_y.push Math.abs(beacons[val.major-1].y - Math.round((val.proximity * 100)))
      points.push Math.abs(Math.round((val.proximity * 100)))

      # circle = document.createElementNS("http://www.w3.org/2000/svg", "circle")
      # circle.setAttribute 'cx', beacons[val.major-1].x
      # circle.setAttribute 'cy', beacons[val.major-1].y
      # circle.setAttribute 'r', Math.round((val.proximity * 100))
      # circle.setAttribute 'fill', 'none'
      # circle.setAttribute 'stroke', '#35d6c9'
      # circle.setAttribute 'strokeWidth', '#35d6c9'
      # $('svg').append circle



    # circle = document.createElementNS("http://www.w3.org/2000/svg", "circle")
    # circle.setAttribute 'cx', avelage(points_x)
    # circle.setAttribute 'cy', avelage(points_y)
    # circle.setAttribute 'r', 5
    # circle.setAttribute 'fill', 'none'
    # circle.setAttribute 'stroke', '#35d6c9'
    # circle.setAttribute 'strokeWidth', '1'
    # circle.setAttribute 'class', 'position'
    # $('svg').find('.position').remove()
    # $('svg').append circle

    status = Number(avelage(points))
    if status < 13
      console.log 'inside'
    circle = document.createElementNS("http://www.w3.org/2000/svg", "circle")
    circle.setAttribute 'cx', 350 / 2
    circle.setAttribute 'cy', 350 / 2
    circle.setAttribute 'r', Number(avelage(points))
    circle.setAttribute 'fill', 'none'
    circle.setAttribute 'stroke', '#35d6c9'
    circle.setAttribute 'strokeWidth', '#35d6c9'
    $('svg').append circle

    # console.log points
    # polygon.setAttribute 'points', points.join(',')
    # polygon.setAttribute 'stroke', '#35d6c9'
    # polygon.setAttribute 'fill', 'none'
    # $('svg').find('polygon').remove()
    # $('svg').append polygon
    # for key, val of beacon
    #   console.log val
      # circle = document.createElementNS("http://www.w3.org/2000/svg", "circle")
      # circle.setAttribute 'cx', beacons[val.major-1].x
      # circle.setAttribute 'cy', beacons[val.major-1].y
      # circle.setAttribute 'r', Number(val.proximity) * 100
      # circle.setAttribute 'fill', 'none'
      # circle.setAttribute 'stroke', '#35d6c9'
      # circle.setAttribute 'strokeWidth', '#35d6c9'
      # $('svg').append circle

## 15.5 * 22.5
# width = 350(cm)
#0.6(m) * 
  width = 350
  height = 350
  margin = 0

  beacons = [
    {
      x: margin
      y: margin
    }
    {
      x: margin
      y: height - margin
    }
    {
      x: width - margin
      y: height - margin
    }
    {
      x: width - margin
      y: margin
    }
  ]

  # beacons.map (beacon)->
  #   circle = document.createElementNS("http://www.w3.org/2000/svg", "circle")
  #   circle.setAttribute 'cx', beacon.x
  #   circle.setAttribute 'cy', beacon.y
  #   circle.setAttribute 'r', '10'
  #   circle.setAttribute 'fill', '#343434'
  #   $('svg').append circle
  #   return 0
