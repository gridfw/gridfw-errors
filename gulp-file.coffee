gulp			= require 'gulp'
gutil			= require 'gulp-util'
# minify		= require 'gulp-minify'
include			= require "gulp-include"
uglify			= require('gulp-uglify-es').default
rename			= require "gulp-rename"
coffeescript	= require 'gulp-coffeescript'

GfwCompiler		= require 'gridfw-compiler'

# compile final values (consts to be remplaced at compile time)
settings=
	isProd: gutil.env.hasOwnProperty('prod')
# compile final values (consts to be remplaced at compile time)
# handlers
compileCoffee = ->
	glp = gulp.src 'assets/**/[!_]*.coffee', nodir: true
		# include related files
		.pipe include hardFail: true
		# template
		.pipe GfwCompiler.template(settings).on 'error', GfwCompiler.logError
		# convert to js
		.pipe coffeescript(bare: true).on 'error', GfwCompiler.logError
	# uglify when prod mode
	if settings.isProd
		glp = glp.pipe uglify()
	# save 
	glp.pipe gulp.dest 'build'
		.on 'error', GfwCompiler.logError
compileViews= ->
	gulp.src 'assets/views/**/[!_]*.pug'
		.pipe GfwCompiler.views()
		.pipe gulp.dest 'build/views/'
		.on 'error', GfwCompiler.logError
# watch files
watch = (cb)->
	unless settings.isProd
		gulp.watch ['assets/**/*.coffee'], compileCoffee
		gulp.watch ['assets/views/**/*.pug'], compileViews
	do cb
	return

# default task
gulp.task 'default', gulp.series (gulp.parallel compileCoffee, compileViews), watch