# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  audioSection = $('section#audio')
  $('a.html5').click ->
    audio = $('<audio>', controls: 'controls')
    url = $(this).attr('href')
    $('<source>').attr('src', url).appendTo audio
    audioSection.html audio
    false
  return