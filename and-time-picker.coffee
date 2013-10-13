# selectors
HOUR_SELECTOR = 'header [data-and-time-picker="hours"]'
MINUTE_SELECTOR = 'header [data-and-time-picker="minutes"]'
HOURS_SELECTION_SELECTOR = 'section [data-and-time-picker="hours"]'
MINUTES_SELECTION_SELECTOR = 'section [data-and-time-picker="minutes"]'
HOURS_ITEMS_SELECTOR = "#{HOURS_SELECTION_SELECTOR} a"
MINUTES_ITEMS_SELECTOR = "#{MINUTES_SELECTION_SELECTOR} a"

# return number with 0 on left if number is smaller than 10
leadZero = (i) -> if i < 10 then "0#{i}" else i

# AndTimePicker class definition
class AndTimePicker
    constructor: (elementOrSelector, opts = {}) ->
        # default options
        options =
            buttonText: 'Accept'
            hour: 0
            minute: 0

        # merge options
        options[key] = val for key, val of opts

        # callbacks
        @callbacks = {}

        # actual values
        @hourValue = options.hour
        @minuteValue = options.minute

        # get element
        @element = if typeof elementOrSelector is 'string' then document.querySelector elementOrSelector else elementOrSelector

        # add and-time-picker class
        @element.classList.add 'and-time-picker'

        # set html
        hours = (for i in [1..24]
            "<a data-hour=\"#{if i is 24 then 0 else i}\">#{if i is 24 then '00' else i}</a>"
        ).join ''

        minutes = (for i in [0..11]
            i *= 5
            "<a data-minute=\"#{i}\">#{leadZero i}</a>"
        ).join ''

        @element.innerHTML = """
            <header>
                <a data-and-time-picker="hours">#{leadZero options.hour}</a>:<a data-and-time-picker="minutes">#{leadZero options.minute}</a>
            </header>
            <section>
                <span></span>
                <hr />
                <div data-and-time-picker="hours">
                    #{hours}
                </div>
                <div data-and-time-picker="minutes">
                    #{minutes}
                </div>
            </section>
            <button>#{options.buttonText}</button>
        """

        # get hr
        @hr = @element.querySelector 'hr'

        # add click event
        @element.addEventListener 'click', (e) =>
            # click on header hour
            if e.target in @element.querySelectorAll HOUR_SELECTOR
                @goToHourSelection()

            # click on header minute
            if e.target in @element.querySelectorAll MINUTE_SELECTOR
                @goToMinuteSelection()

            # click on hour
            if e.target in @element.querySelectorAll HOURS_ITEMS_SELECTOR
                # set hour
                @setHour e.target.attributes['data-hour'].value

                # go to minute selection
                @goToMinuteSelection()

            # click on minute
            if e.target in @element.querySelectorAll MINUTES_ITEMS_SELECTOR
                # select minute
                @setMinute e.target.attributes['data-minute'].value

                # accept
                @accept()

            # click on accept
            if e.target.nodeName is 'BUTTON'
                @accept()

        # add mouseover event
        @element.addEventListener 'mouseover', (e) =>
            # mouse over an hour item
            if e.target in @element.querySelectorAll HOURS_ITEMS_SELECTOR
                # select hour
                @selectHour e.target.attributes['data-hour'].value

            # mouse over a minute item
            if e.target in @element.querySelectorAll MINUTES_ITEMS_SELECTOR
                # select minute
                @selectMinute e.target.attributes['data-minute'].value

        # add mouseleave events
        @element.querySelector(HOURS_SELECTION_SELECTOR).addEventListener 'mouseleave', (e) =>
            @selectHour @hourValue

        @element.querySelector(MINUTES_SELECTION_SELECTOR).addEventListener 'mouseleave', (e) =>
            @selectMinute @minuteValue

        # go to hour selection
        @goToHourSelection()

    # get hour
    getHour: ->
        @hourValue

    # get minute
    getMinute: ->
        @minuteValue

    # select hour
    selectHour: (hour) ->
        # remove active class
        @element.querySelector("#{HOURS_ITEMS_SELECTOR}.active")?.classList.remove 'active'

        # add active class
        @element.querySelector("#{HOURS_ITEMS_SELECTOR}[data-hour=\"#{hour}\"]").classList.add 'active'

        # set rotation
        transform = "rotate(#{hour * 30 - 180}deg)"
        @hr.style.transform = transform
        @hr.style["#{prop}Transform"] = transform for prop in ['webkit', 'Moz', 'ms', 'O']

        # set class
        @hr.className = if 1 <= hour <= 12 then 'short' else 'long'

        # return self to chain calls
        @

    # select minute
    selectMinute: (minute) ->
        # remove active class
        @element.querySelector("#{MINUTES_ITEMS_SELECTOR}.active")?.classList.remove 'active'

        # add active class
        @element.querySelector("#{MINUTES_ITEMS_SELECTOR}[data-minute=\"#{minute}\"]").classList.add 'active'

        # set rotation
        transform = "rotate(#{minute / 5 * 30 - 180}deg)"
        @hr.style.transform =
        @hr.style["#{prop}Transform"] = transform for prop in ['webkit', 'Moz', 'ms', 'O']

        # set class
        @hr.className = 'middle'

        # return self to chain calls
        @

    # set hour
    setHour: (hour) ->
        # store hour
        @hourValue = hour

        # set hour on header
        @element.querySelector(HOUR_SELECTOR).innerHTML = leadZero @hourValue

        # select hour
        @selectHour @hourValue

        # trigger event
        @trigger 'hour', @hourValue

        # return self to chain calls
        @

    # set minute
    setMinute: (minute) ->
        # store minute
        @minuteValue = minute

        # set minute on header
        @element.querySelector(MINUTE_SELECTOR).innerHTML = leadZero @minuteValue

        # store and select minute
        @selectMinute @minuteValue

        # trigger event
        @trigger 'minute', @minuteValue

        # return self to chain calls
        @

    # show hour selection
    goToHourSelection: ->
        # set hour
        @selectHour @hourValue

        # set element classes
        @element.classList.remove 'and-time-picker-minute-selection'
        @element.classList.add 'and-time-picker-hour-selection'

        # return self to chain calls
        @

    # show minute selection
    goToMinuteSelection: ->
        # select minute
        @selectMinute @minuteValue

        # set element classes
        @element.classList.remove 'and-time-picker-hour-selection'
        @element.classList.add 'and-time-picker-minute-selection'

        # return self to chain calls
        @

    # accept current value
    accept: ->
        # trigger event
        @trigger 'accept', "#{leadZero @hourValue}:#{leadZero @minuteValue}"

        # return self to chain calls
        @

    # trigger event
    trigger: (event, args...) ->
        # if callbacks of the given event
        if @callbacks[event]?.length
            cb.apply @, args for cb in @callbacks[event]

        # return self to chain calls
        @

    # bind callback
    bind: (event, callback) ->
        # add the callback
        @callbacks[event] = [] unless @callbacks[event]
        @callbacks[event].push callback

        # return self to chain calls
        @

    # unbind callback
    unbind: (event, callback) ->
        # if a callback is given
        if callback
            # remove the callback
            @callbacks[event] = (cb for cb in @callbacks[event] unless cb == callback)

        # no callback given
        else
            # clear callbacks for the given event
            @callbacks[event] = []

        # return self to chain calls
        @

# set class on window
window.AndTimePicker = AndTimePicker
