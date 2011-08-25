function init(){
    $('a.js-pjax').live("click", function(event, data, status, xhr){
	    event.preventDefault();
	    $.ajax({url: this,
			data:"_pjax=true",
			success: function(data){
			$("#content").html(data);
		    },
			});
	});
}

function init_pjax(){
    $('.js-pjax').pjax('#content', { timeout: null, error: function(xhr, err){
		$('.error').text('Something went wrong: ' + err)
		    }});
    $('body')
	.bind('start.pjax', function(){$('.loader').show();alert('k')})
	.bind('end.pjax'  , function(){$('.loader').hide();});
}
