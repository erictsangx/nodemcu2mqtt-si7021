function read_sensor()
    local sda, scl = 6, 5
    i2c.setup(0, sda, scl, i2c.SLOW) -- call i2c.setup() only once
    si7021.setup()

    local hum, temp = si7021.read()

    return string.format('{"humidity":%.2f,"temperature":%.2f}', hum, temp)
end
