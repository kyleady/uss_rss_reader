# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".article-hasBeenRead").bind 'change', () ->
    $.ajax {
      url: this.value + "/toggle_viewed"
      type: 'POST'
    }
    false
