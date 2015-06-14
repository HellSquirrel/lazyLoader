module.exports = function (grunt) {

    require('load-grunt-tasks')(grunt);

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        jade: {
            compile: {
                files: {
                    'dist/index.html': 'jade/index.jade'}}},

        compass: {
            compile: {
                options: {
                    config: 'config.rb',
                    environment: 'development',
                    watch: true
                }
            },

            build: {
                options: {
                    config: 'config.rb',
                    environment: 'production'}
            }
        },

        browserify: { // browserify
            bundle: {
                files: {
                    'dist/bundle.js': 'javascripts/index.js'//,
                },
                options: {
                    transform: ["babelify"],
                    browserifyOptions: {
                        debug: true //sourcemap
                    },

                    watch: true,
                    keepAlive: true

                }
            },

            build: {
                files: {
                    'dist/bundle.js': 'javascripts/index.js'//,
                },
                options: {
                    transform: ["babelify", 'uglifyify']
                }
            }
        },


        connect: {
            test_server: {
                options: {
                    livereload: true,
                    base: '.',
                    open: 'http://localhost:8000/dist',
                    keepalive: true
                }
            }
        },

        watch: {
            options: {livereload: true},

            sass: {
                files: ['scss/*.scss'],
                tasks: ['compass:compile']
            },

            jade: {
                files: ['jade/*.jade'],
                tasks: ['jade:compile']
            }
        },

        concurrent: {
            options: {
                logConcurrentOutput: true},
            serve: {
                tasks: ['browserify:bundle','compass:compile', 'watch:sass', 'watch:jade']}}

    });

    grunt.registerTask('build',['compass:build','browserify:build']);
    grunt.registerTask('publish',['build','rsync:staging']);
};
