# adds fluent style getter/setter methods to an object
# for the given list of properties
define (require) ->


    getterSetter = (key) ->
        return (value) ->
            if not arguments.length then return this[key]
            this[key] = value
            return this


    return (object, properties) ->
        for property in properties
            object[property] = getterSetter('_' + property)