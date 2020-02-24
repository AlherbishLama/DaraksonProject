import paho.mqtt.client as mqtt
import I2CDriver
import time


mylcd = I2CDriver.lcd()
clientName = "RPI"
# mqtt server address
serverAddress = "192.168.100.144"


def topic(client, userdata, flags, rc):
    # The topic that the raspberry pi is subscribing to.
    mqttClient.subscribe("rpi/LCD")


def display_play(client, userdata, msg):
    time.sleep(0.1)
    message = msg.payload.decode(encoding='UTF-8')
    if message == "Play":
        mylcd.lcd_display_string("Let's Play", 1)
    elif message == "Learn":
        mylcd.lcd_display_string("Let's Learn!", 1)
    else:
        mylcd.lcd_display_string("", 1)
        mqtt.Client(clientName).loop_stop()
        mqtt.Client(clientName).disconnect()


mqttClient = mqtt.Client(clientName)
mqttClient.on_connect = topic
mqttClient.on_message = display_play
# connect to the server
mqttClient.connect(serverAddress)
# forever
mqttClient.loop_forever()
