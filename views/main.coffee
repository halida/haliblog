window.init = ()->
  ret = (event, data, status, xhr)->
    event.preventDefault()
    $.ajax {url: this, data:"_pjax=true", success: (data)-> $("#content").html(data)}
  $('a.js-pjax').live "click", ret

window.init_pjax = ()->
  error_func = (xhr, err)-> $('.error').text('Something went wrong: ' + err)
  $('.js-pjax').pjax '#content', {timeout: null, error: error_func}
  $('body').bind 'start.pjax', ()-> $('#content').slideUp(500)
  $('body').bind 'end.pjax'  , ()-> $('#content').slideDown(500)
