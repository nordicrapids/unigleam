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
    reply_container = $("."+btn.data("parent-div") + " .comment-reply-containers")
    reply_container.toggle()

  $("body").on "click",".like-btn", ->
    btn = $(this)
    path = btn.data("path")
    id = btn.data("id")
    btn.button("loading")

    if(btn.hasClass("fa-heart-o"))
      $.post(
        path+"/like",
        { id : id}
      ).done (data) ->
        if(data.status == "success")
          btn.toggleClass("fa-heart-o")
          btn.button("reset")
          btn.text(data.count)
        else
          btn.button("reset")
          btn.tooltip({title: data.message, placement: "bottom"}).tooltip("show")

    else
      $.post(
        path+"/dislike",
        { id : id}
      ).done (data) ->
        if(data.status == "success")
          btn.toggleClass("fa-heart-o")
          btn.button("reset")
          btn.text(data.count)
        else
          btn.button("reset")
          btn.tooltip({title: data.message, placement: "bottom"}).tooltip("show")


