$ ->
  $(".modal-link").click ->
    open_target_modal = $(this).data("modal-target")
    $(".modal").modal("hide")
    $(open_target_modal).modal("show")