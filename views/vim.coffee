# vim key binding
# by linjunhalida <linjunhalida@gmail.com>
# mit license

pre_g = false
scroll_size = 100

window.init_vim_key = (div)->
    div = document unless div
    target = $(div)
    $(document).keypress (e)->
        if (e.keyCode == 107) # k
            target.scrollTop(target.scrollTop()-scroll_size)
            e.preventDefault()

        if (e.keyCode == 106) # j
            target.scrollTop(target.scrollTop()+scroll_size)
            e.preventDefault()

        if (e.keyCode == 104) # h
            target.scrollTop(target.scrollLeft()-scroll_size)
            e.preventDefault()

        if (e.keyCode == 108) # l
            target.scrollTop(target.scrollLeft()+scroll_size)
            e.preventDefault()


    $(document).keydown (e)->
        if (e.keyCode == 191 and e.shiftKey) # ?
            if $('#vim-help').length > 0
                $('#vim-help').remove()
                return

            help = $('<div id="vim-help" >
                    <h1 style="padding-bottom: 20px">Key binding:</h1>
                    <ul>
                        <li><em style="width: 30px; display: inline-block">k</em> scroll up</li>
                        <li><em style="width: 30px; display: inline-block">j</em> scroll down</li>
                        <li><em style="width: 30px; display: inline-block">h</em> scroll left</li>
                        <li><em style="width: 30px; display: inline-block">l</em> scroll right</li>
                        <li><em style="width: 30px; display: inline-block">G</em> scroll to bottom</li>
                        <li><em style="width: 30px; display: inline-block">gg</em> scroll to top</li>
                        <li><em style="width: 30px; display: inline-block">?</em> show help</li>
                    </ul>
                    <p style="padding-top: 30px">Press ? again to hide this help</p>
                </div>
                ')

            help.css(
                width: "300px"
                height: "300px"
                position: "fixed"
                top: ($(window).height() / 2 - 150 - 20) + "px"
                left: ($(window).width() / 2 - 150) + "px"

                background: "white"
                border: "2px solid #4690C8"
                "-moz-border-radius": "4px"
                "-webkit-border-radius": "4px"
                "border-radius": "4px"

                "padding": "20px"
                "z-index": "300"
                "font-size": '14px'
            )
            help.appendTo('body')

        if (e.keyCode == 71 and e.shiftKey) # G
            if div == document
                total_height = target.height()
            else
                total_height = target[0].scrollHeight
            target.scrollTop(total_height)
            e.preventDefault()
            return

        if (e.keyCode == 71) # gg
            if pre_g
                pre_g = false
                target.scrollTop(0)
                e.preventDefault()
            else
                pre_g = true
