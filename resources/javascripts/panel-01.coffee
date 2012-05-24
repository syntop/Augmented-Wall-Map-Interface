$ ->
    $('.button').on 'touchstart', (e) ->
        $(this).addClass('touched')
    .on 'touchend', (e) ->
        if $(this).is('.touched')
            msg = new Message('/run-program')
            msg.addInt parseInt($(this).data('program'),10)
            msg.send()
    .on 'touchend touchmove', (e) ->
        $(this).removeClass('touched')
