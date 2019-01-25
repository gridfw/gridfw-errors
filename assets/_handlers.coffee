### Error views ###
viewsDir = Path.join __dirname, 'views'
### Error handlers ###
errorHandlers =
	404: (ctx, errCode, err) ->
		ctx.statusCode = 404
		ctx.debug 'REQ_ERR', 'Page not found'
		Path.join viewsDir, '404'
	'404-file': (ctx, errCode, err) ->
		ctx.statusCode = 404
		ctx.debug 'REQ_ERR', 'File not found'
		Path.join viewsDir, '404-file'
	else: (ctx, errCode, err)->
		# error status
		errCode = 500 unless Number.isSafeInteger errCode
		ctx.statusCode = errCode
		# Debuging
		if errCode >= 500
			ctx.fatalError 'REQ_ERR', error
		else
			ctx.warn 'REQ_ERR', error
		# error details
		ctx.locals.error = err
		# render
		Path.join viewsDir, '500'
