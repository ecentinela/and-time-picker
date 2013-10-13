and-time-picker
===============
A simple timepicker component for the web.


Installation
------------

This project is registered as a Bower package.

``` bash
$ bower install and-time-picker
```


Configuration
-------------

To use **and-time-picker** on your page, you need to include the **js** and **css** files on your **html**.

``` html
<link href="bower_components/and-time-picker/and-time-picker.css" rel="stylesheet">
<script src="bower_components/and-time-picker/and-time-picker.js"></script>
```


Create
------

To create an **and-time-picker** object, create it passing a **dom** element or selctor to convert to a time picker and an optional second parameter with options.

``` javascript
new AndTimePicker("#element", [options])
```

Options
-------

On the object creation, as a second parameter, you can pass an object setting some properties for **and-time-picker**.

``` javascript
var options = {
    buttonText: 'Accept',
    hour: 16,
    minute: 22
}
```
### buttonText ###

The text that will appear on the bottom button.

### hour ###

The initial hour value.

### minute ###

The initial minute value.

Methods
-------

The **and-time-picker** object exposes some methods.

### getHour ###

Get the actual selected hour.

``` javascript
myAndTimePicker.getHour() // 4
```

### getMinute ###

Get the actual selected minute.

``` javascript
myAndTimePicker.getMinute() // 8
```

### selectHour ###

Select the hour (not set it).

``` javascript
myAndTimePicker.selectHour(4)
```

### selectMinute ###

Select the minute (not set it).

``` javascript
myAndTimePicker.selectMinute(8)
```

### setHour ###

Set the hour and trigger the `hour` event with the actual selected hour as a parameter.

``` javascript
myAndTimePicker.setHour(4)
```

### setMinute ###

Set the minute and trigger the `minute` event with the actual selected minute as a parameter.

``` javascript
myAndTimePicker.setMinute(8)
```

### goToHourSelection ###

Show the hour selection div.

``` javascript
myAndTimePicker.goToHourSelection()
```

### goToMinuteSelection ###

Show the minute selection div.

``` javascript
myAndTimePicker.goToMinuteSelection()
```

### accept ###

Accepts the current selected time and trigger the `accept` event with the actual time as a parameter.

``` javascript
myAndTimePicker.accept()
```

### trigger ###

Trigger an **and-time-picker** event. Accepted events are `hour`, `minute` and `accept`.

``` javascript
myAndTimePicker.trigger("accept")
```

### bind ###

Binds a new callback to an **and-time-picker** event. Accepted events are `hour`, `minute` and `accept`.

``` javascript
myAndTimePicker.bind("accept", function(time) {
    alert(time)
})
```

### unbind ###

Unbinds a callback or all the callbacks for the given event type.

If passing a callback:

``` javascript
myAndTimePicker.unbind("accept", previouslyStoredCallback)
```

To remove all callbacks of the given type:

``` javascript
myAndTimePicker.unbind("accept")
```


Contributing
------------

1. Install [NodeJS](http://nodejs.org) and [Node Package Manager](https://npmjs.org).

2. Install packages.

``` bash
$ npm install
```

3. Use [Grunt](http://gruntjs.com) to watch project changes, compress assets, etc.``` bash

``` bash
$ ./node_modules/grunt-cli/bin/grunt watch
```
