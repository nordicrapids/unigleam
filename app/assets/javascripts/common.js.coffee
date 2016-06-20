$ ->
  $("form#sign_up_user").bind "ajax:success", (e, data, status, xhr) ->
    debugger
    if data.success
      $('#sign_up').modal('hide')
      $('#sign_up_button').hide()
      $('#submit_comment').slideToggle(1000, "easeOutBack" )
    else
      alert('failure!')

  $("form#sign_in_user").bind "ajax:success", (e, data, status, xhr) ->
    console.log data
    alert "123"
    if data.success
      $('#login_modal').modal('hide')
      window.location.href = $("body").data("url")

    else
      $("#login_error_message").show()
