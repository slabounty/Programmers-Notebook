# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->

  $(".comment_edit_drop_down").hide()

  $(".edit_comment_link").click ->
      comment_id = $(this).attr 'comment_id'
      $("#comment_edit_drop_down_" + comment_id).toggle()
