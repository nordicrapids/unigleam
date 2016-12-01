function search_keyup(){

  $('#gleams').each(function(){
    if ($(this).val() == ''){
      $('.search_button').addClass('disabled').css('pointer-events','none')
    }else{
      $('.search_button').removeClass('disabled').css('pointer-events','all')
    }
  })

  $('#gleams').on('keypress', function(event){
    if ($(this).val() == ''){
      $('.search_button').addClass('disabled').css('pointer-events','none')
      if (event.keyCode == 13){
        event.preventDefault();
      }
    }else{
      $('.search_button').removeClass('disabled').css('pointer-events','all')
      if (event.keyCode == 13){
        $('.search_button').trigger('click');
        return false;
      }
    }

  })

  var gleams = $('#gleams').val();
  $('#gleams').focus().val('').val(gleams);


  // Header Search Typeahead
  $.typeahead({
    input: '#gleams',
    minLength: 1,
    order: "asc",
    dynamic: true,
    delay: 500,
    template: function (query, item) {
      var color = "#777";
      if(item.status === "owner"){
        color = "#ff1493";
      }
      var value = item.name
      return '<span class="username">{{name}}</span>'
    },
    source: {
      restaurants: {
        display: ["name"],
        url: [{
          type: "GET",
          url: "search",
          data: {
            "gleams" : "{{query}}"
          },
          callback: {
            done: function (data) {
              // console.log(data)
              return data;
            }
          }
        }, "pages"]
      }
    },
    callback: {
      onClick: function (node, a, item, event) {
      },
      onClickAfter: function (node, a, item, event){
      },
      onMouseEnter: function (node, a, item, event){
      },
      onNavigateAfter: function (node, lis, a, item, query, event){
      },
      onSendRequest: function (node, query) {
      },
      onReceiveRequest: function (node, query) {
      },
      onReady: function (node){
      },
      onLayoutBuiltAfter: function (node, query, result){
      }
    },
    debug: false
  });
}
