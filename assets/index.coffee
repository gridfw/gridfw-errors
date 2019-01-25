###*
 * Error handlers
 * @copyright khalid RAFIK 2019
###
'use strict'
Path = require 'path'

#=include _handlers.coffee

class ErrorHandling
	constructor: (@app)->
		@enabled = on # the plugin is enabled
		return
	###*
	 * Reload parser
	###
	reload: (settings)-> @enable()
	###*
	 * destroy
	###
	destroy: -> @disable()
	###*
	 * Disable, enable
	###
	disable: ->
		gErr = @app.errors
		for k,v of gErr
			if v is errorHandlers[k]
				delete gErr[k]
		return
	enable: ->
		gErr = @app.errors
		for k,v of errorHandlers
			unless k of gErr
				gErr[k] = v
		return

module.exports = ErrorHandling