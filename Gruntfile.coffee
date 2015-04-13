# vim:ft=coffee :

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-release"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-mocha-test"
  grunt.registerTask "default", "watch"
  grunt.registerTask "lint", "coffeelint:app"
  grunt.registerTask "spec", "mochaTest:spec"

  grunt.initConfig
    watch:
      coffee:
        files: [
          "**/*.coffee"   # Watch everything
          "!node_modules" # ...except dependencies
        ]
        tasks: ["lint", "spec"]
        options:
          atBegin: true
          interrupt: true

    coffeelint:
      app:
        files:
          src: ["spec/**/*.coffee", "base/**/*.coffee", "scripts/**/*.coffee"]
        options:
          force: true
          configFile: "coffeelint.json"

    mochaTest:
      spec:
        options:
          reporter: "spec"
          timeout: 3000
          require: [
            "coffee-script/register"
            "./spec/helpers/base.coffee"
          ]
        src: ["spec/**/*spec.coffee"]
