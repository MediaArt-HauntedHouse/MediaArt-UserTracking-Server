# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  dispatcher = new WebSocketRails window.location.host + '/websocket'

  success = (response) ->
    console.info response.message

  failure = (response) ->
    console.error response.message

  dispatcher.on_open = ->
    console.info 'Connection Start'

  channel = dispatcher.subscribe 'streaming'
  channel.bind 'create', (beacon) ->
    console.log beacon