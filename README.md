# nodemcu2mqtt-si7021
A zigbee2mqtt-like mqtt-tls client for NodeMcu and Si7021

Since I am running [zigbee2mqtt](https://github.com/Koenkk/zigbee2mqtt) and [home-assistant](https://github.com/home-assistant/home-assistant)
on a Raspberry Pi for controlling my IoT devices.

It use [MQTT topics and message structure](https://www.zigbee2mqtt.io/information/mqtt_topics_and_message_structure.html) similar to zigbee2mqtt.

i.e. nodemcu2mqtt/nodemcu-si7021	{"humidity":76.67,"temperature":28.60}

## Quick Start
Use dev [nodemcu-firmware](https://github.com/nodemcu/nodemcu-firmware/tree/dev) or you may not able to connect to the mqtt broker with tls support.

Edit config-template.lua and rename it to config.lua

Upload all lua files and you are good to go

Read home-assistant.yaml if you need home-assistant configurations 


## Pin connections
NodeMcu| Si7021 
----|------
3.3v  | 3.3v 
GND   | GND
6     | SDA
5     | SCL


![Alt text](images/breadboard.jpeg?raw=true "breadboard")
![Alt text](images/home-assistant.png?raw=true "ads free")

