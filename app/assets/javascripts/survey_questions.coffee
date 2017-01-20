# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("body").on "click",".reply-btn", ->
    btn = $(this)
    reply_form = $("."+btn.data("parent-div") + " .reply-form")
    reply_form.toggle()

  $("body").on "click",".toogle-replies", ->
    btn = $(this)
    reply_container = $("."+btn.data("parent-div") + " .comment-reply-container")
    reply_container.toggle()

  $("body").on "click",".toogle-comments", ->
    btn = $(this)
    comment_container = $("#"+btn.data("parent-div") + " .comments-container")
    comment_container.toggle()

  $("body").on "click",".like-btn", ->
    btn = $(this)
    other_btn = btn.next()
    path = btn.data("path")
    id = btn.data("id")
    btn.button("loading")

    $.post(
      path+"/like",
      { id : id}
    ).done (data) ->
      if(data.status == "success")
        btn.removeClass("fa-thumbs-o-up").addClass("fa-thumbs-up")
        other_btn.removeClass("fa-thumbs-down").addClass("fa-thumbs-o-down")
        btn.button("reset")
        btn.text(data.up_count)
        other_btn.text(data.down_count)
      else
        btn.button("reset")
        btn.tooltip({title: data.message, placement: "bottom"}).tooltip("show")

  $("body").on "click",".dislike-btn", ->
    btn = $(this)
    other_btn = btn.prev()
    path = btn.data("path")
    id = btn.data("id")
    btn.button("loading")
    $.post(
      path+"/dislike",
      { id : id}
    ).done (data) ->
      if(data.status == "success")
        btn.removeClass("fa-thumbs-o-down").addClass("fa-thumbs-down")
        other_btn.removeClass("fa-thumbs-up").addClass("fa-thumbs-o-up")
        btn.button("reset")
        btn.text(data.down_count)
        other_btn.text(data.up_count)
      else
        btn.button("reset")
        btn.tooltip({title: data.message, placement: "bottom"}).tooltip("show")


