window.init = ()->
  ret = (event, data, status, xhr)->
    event.preventDefault()
    $.ajax {url: this, data:"_pjax=true", success: (data)-> $("#content").html(data)}
  $('a.js-pjax').live "click", ret

window.init_pjax = ()->
  error_func = (xhr, err)-> $('.error').text('Something went wrong: ' + err)
  $('.js-pjax').pjax '#content', {timeout: null, error: error_func}
  $('body').bind 'start.pjax', ()-> $('#content').html('<div class="more"><img src="/ajax-loader.gif" id="more-display" /></div>')
  #$('body').bind 'end.pjax'  , ()-> $('#content').html('<div class="more"><img src="/ajax-loader.gif" id="more-display" /></div>')
