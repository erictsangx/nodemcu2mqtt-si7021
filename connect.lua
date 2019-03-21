function wifi_connect(callback)
    if wifi.sta.getip() == nil then
        wifi.setmode(wifi.STATION)
        wifi.sta.config(station_cfg)
        wifi.sta.connect()
    end

    setInterval(1000, function(t)
        if wifi.sta.getip() == nil then
            print("Obtaining IP Address...")
        else
            t:unregister()
            print("hostname: " .. wifi.sta.gethostname())
            print("ip: " .. wifi.sta.getip())
            callback()
        end
    end)
end


local publish_timer = tmr.create()

function mqtt_connect()
    local m_client = mqtt.Client(mqtt_clientId, 120, mqtt_user, mqtt_password)

    m_client:on("connect", function(client) print("connected") end)

    m_client:on("offline", function(client)
        print("mqtt offline")
        publish_timer:stop()
        mqtt_connect()
    end)

    m_client:on("message", function(client, topic, data)
        print(topic .. ":")
        if data ~= nil then
            print(data)
        end
    end)

    m_client:on("overflow", function(client, topic, data)
        print(topic .. " partial overflowed message: " .. data)
    end)

    print('Connecting to the MQTT broker...', mqtt_host)
    m_client:connect("192.168.1.85", 8883, 1, loop_publish, handle_mqtt_error)


    m_client:close();
end

function loop_publish(client)
    publish(client)
    publish_timer:register(30000, tmr.ALARM_AUTO, function(t)
        publish(client)
    end)
    publish_timer:start()
end

function publish(client)
    local payload = read_sensor()
    client:publish("nodemcu2mqtt/" .. mqtt_clientId, payload, 0, 0, function(client) print("sent nodemcu2mqtt/" .. mqtt_clientId, payload) end)
end

function handle_mqtt_error(client, reason)
    print("failed reason: " .. reason)
    publish_timer:stop()
    tmr.create():alarm(3000, tmr.ALARM_SINGLE, mqtt_connect)
end
