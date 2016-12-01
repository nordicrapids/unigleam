// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require plugins/jquery-validation/dist/jquery.validate.min.js
//= require highcharts
//= require theme/js/jquery.unveil
//= require theme/js/jquery.easing.min
//= require theme/js/jquery.mixitup.min
//= require theme/js/scrollReveal
//= require theme/js/owl.carousel.min
//= require theme/js/jquery.magnific-popup.min
//= require theme/js/jquery.snippet.min
//= require theme/js/jquery.fitvids
//= require theme/js/style-switcher
//= require theme/js/activate-snippet
//= require theme/js/skrollr.min
//= require theme/js/main
//= require jquery.remotipart
//= require jquery.typeahead.min
//= require typeahead.jquery
//= require typeahead_search.js
//= require common
//= require_tree .

$(document).ready(function() {
  // search_keyup()
  imgRemove()
  $("#wizard-picture").change(function(){
    readURL(this);
    $(this).parent().addClass('file-uploaded')
  });
  function readURL(input) {
  		if (input.files && input.files[0]) {
  				var reader = new FileReader();
          if (input.value.split('.')[input.value.split('.').length - 1] == "gif"){
             $('.error_msg_for_main_image').empty().append('<label id="wizard-picture-error" class="error" for="wizard-picture">.GIF extension invalid!</label>')
             $('#wizard-picture').val('')
             $('#wizard-picture').attr('value', '')
             $('#wizard-picture').addClass('required')
             $('#wizardPicturePreview').attr('src', '')
             $('#wizardPicturePreview').attr('alt', '')
          }else{
    				reader.onload = function (e) {
    						$('#wizardPicturePreview').attr('src', e.target.result).fadeIn('slow');
    				}
            $('.error_msg_for_main_image').empty()
            reader.readAsDataURL(input.files[0]);
          }
  		}
  }

  function imgRemove(){
    var img_path = $('.logo_upload').data('default-url')
    $('.logo_upload').parent().removeClass('file-uploaded')
    $('#wizard-picture').val('')
    $('#wizard-picture').removeAttr('value')
    //  $('#wizardPicturePreview').attr('src', img_path).fadeIn('slow');
    var img_path = $('.cancle_img').data('default-url')
    $('#wizardPicturePreview').attr('src', img_path).fadeIn('slow');
    $('#wizard-picture').removeAttr('value')
  }

  $('#survey_question').on('hidden.bs.modal', function(e) {
    $('#survey_question_topic_id').val('')
    $('#survey_question_title').val('')
    $('#survey_question_image').val('')
    $('.section_rows').remove()
  });
})
