define (require) ->
    keysort = (key, secondKey, descending = false) ->
        (a,b) ->
            A = a[key]
            B = b[key]
            ret = 0
            if A > B then ret = 1
            else if A < B then ret = -1
            else if A == B and secondKey
                A2 = a[secondKey]
                B2 = b[secondKey]
                if A2 > B2 then ret = 1
                if A2 < B2 then ret = -1
            if descending then 0 - ret else ret