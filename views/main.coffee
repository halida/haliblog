window.init = ()->
  init_pjax()
  $('select#color-select').change ()->
    $('#color-css').attr('href', '/color'+$(this).val()+'.css')

window.init_pjax = ()->
  error_func = (xhr, err)-> $('.error').text('Something went wrong: ' + err)
  $('.js-pjax').pjax '#content', {timeout: null, error: error_func}
  $('body').bind 'start.pjax', ()-> $('#content').html('<div class="more"><img src="/ajax-loader.gif" id="more-display" /></div>')
  #$('body').bind 'end.pjax'  , ()-> $('#content').html('<div class="more"><img src="/ajax-loader.gif" id="more-display" /></div>')
