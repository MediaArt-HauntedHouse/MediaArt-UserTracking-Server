@map_status = ->
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

    polygon = document.createElementNS("http://www.w3.org/2000/svg", "polygon")
    points_x = []
    points_y = []
    points = []
    for key, val of beacon
      points.push Math.abs(Math.round((val.proximity * 100)))

    console.log Number(avelage(points))
    circle = document.createElementNS("http://www.w3.org/2000/svg", "circle")
    circle.setAttribute 'cx', 350 / 2
    circle.setAttribute 'cy', 350 / 2
    circle.setAttribute 'r', Number(avelage(points))
    circle.setAttribute 'fill', 'none'
    circle.setAttribute 'stroke', '#35d6c9'
    circle.setAttribute 'strokeWidth', '2'
    $('svg').append circle

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

  beacons.map (beacon)->
    circle = document.createElementNS("http://www.w3.org/2000/svg", "circle")
    circle.setAttribute 'cx', beacon.x
    circle.setAttribute 'cy', beacon.y
    circle.setAttribute 'r', '10'
    circle.setAttribute 'fill', '#343434'
    $('svg').append circle
    return 0


  circle = document.createElementNS("http://www.w3.org/2000/svg", "circle")
  circle.setAttribute 'cx', (350 / 2)
  circle.setAttribute 'cy', (350 / 2)
  circle.setAttribute 'r', '110'
  circle.setAttribute 'fill', 'none'
  circle.setAttribute 'stroke', '#23b750'
  circle.setAttribute 'stroke-width', 8
  $('svg').append circle
return 0