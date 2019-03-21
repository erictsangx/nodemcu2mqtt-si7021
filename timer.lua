function setInterval(period, callback)
    local mytimer = tmr.create()
    mytimer:register(period, tmr.ALARM_AUTO, function(t)
        callback(t)
    end)
    mytimer:start()
    return mytimer
end