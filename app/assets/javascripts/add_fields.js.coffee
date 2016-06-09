$ ->
  $('form').on 'click', '.add_tr_fields', (e) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    table = $(this).data('table-id')
    $("#" + table).append($(this).data('fields').replace(regexp, time))
    e.preventDefault()

  $('form').on 'click', '.link_to_remove_field', (event) ->
    event.preventDefault();
    $(this).prev('input[type=hidden]').val '1'
    $(this).closest('.section_rows').hide()
    return
