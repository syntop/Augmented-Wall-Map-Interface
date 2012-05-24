$ ->
    $compass = $('#compass')
    prevHeading = null
    
    $(window).on 'deviceorientation', (e) ->
        heading = Math.round(e.webkitCompassHeading)
        if e.webkitCompassHeading != 0 && heading != prevHeading
            $compass.css
                '-webkit-transform': "rotate(-#{e.webkitCompassHeading}deg)"
            msg = new Message()
            msg.address = '/compass'
            msg.addFloat e.webkitCompassHeading
            msg.send()
            prevHeading = heading