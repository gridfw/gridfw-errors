# Gridfw-errors
This plugin adds error handlers to the framework.
It's recommanded for dev stage, you should add custom ones for developement. (or just do not add anyting)

@see "Gridfw error handling" for more info on how to add them

## Add the plugin
In your config file, under plugins option, add the following
```javascript
{
    plugins:{
        errorHandling:{
            require: 'gridfw-errors'
        }
    }
}
```

## Add the plugin for dev only
```javascript
{
    plugins:{
        <% if(mode === 'dev'){ %>
        errorHandling:{
            require: 'gridfw-errors'
        }
        <% } %>
    }
}
```

## Gridfw Error handling:
Adding the plugin will not override your custom error handlers.
Adding error handlers is pretty easy
```javascript
{
    errors:
        <errorCode>: function(ctx, errCode, error){
            //do what ever
        },
        // else will match any other error code
        else: function(ctx, errCode, error){
            //do what ever
        },

}
```

Example:
```javascript
{
    errors:
        404: async function(ctx, errCode, error){
           ctx.debug('REQ_ERR', 'Page not found'); // Debuging
           ctx.statusCode = 404;
           await ctx.render('errors/404');
        },
        '404-file': function(ctx, errCode, error){
           ctx.debug('REQ_ERR', 'File not found'); // Debuging
           ctx.statusCode = 404;
           return 'errors/404-file'; // equivalent to ctx.render('errors/404-file')
        },
        500: function(ctx, errCode, error){
           ctx.fatalError('REQ_ERR', error); // Debuging
           ctx.statusCode = 500;
           return ctx.render('errors/500', {error: error});
        },
        // else will match any other error code
        else: function(ctx, errCode, error){
            // status code
            var statusCode = 500
            if(Number.isSafeInteger(errCode))
                statusCode = errCode;
            ctx.statusCode = statusCode;
            // debuging
            if(statusCode >= 500)
                ctx.fatalError('REQ_ERR', error);
            else
                ctx.warn('REQ_ERR', error);
            // render
            ctx.locals.error = error;
            return 'errors/500';
        },

}
```
