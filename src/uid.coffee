# adapted from http://stackoverflow.com/questions/3231459/create-unique-id-with-javascript
define (require) ->
    id = 0
    return ->
        return id++