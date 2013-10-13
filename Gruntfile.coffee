module.exports = (grunt) ->

    # project configuration.
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        coffee:
            app:
                files:
                    'and-time-picker.js': 'and-time-picker.coffee'

        uglify:
            options:
                compress: true

            app:
                files:
                    'and-time-picker.js': 'and-time-picker.js'

        stylus:
            options:
                import: ['nib']

            app:
                files:
                    'and-time-picker.css': 'and-time-picker.styl'

        watch:
            js:
                files: 'and-time-picker.coffee'
                tasks: 'js'

            css:
                files: 'and-time-picker.styl'
                tasks: 'css'

    # load plugins
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    # default task(s).
    grunt.registerTask 'default', ['js', 'css']

    # other tasks
    grunt.registerTask 'js', ['coffee', 'uglify']
    grunt.registerTask 'css', 'stylus'
