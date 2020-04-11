import paho.mqtt.client as mqtt
import time
import I2CDriver

clientName = "RPI"
Server = "localhost"
mqttClient = mqtt.Client(clientName)
topic = "lvl/3"
mylcd = I2CDriver.lcd()

def on_connect(client, userdata, flags, rc):
    # The topic subscribing to.
    mqttClient.subscribe(topic)


def on_message(client, userdata, msg):
    message = msg.payload.decode(encoding='UTF-8')
    mylcd.lcd_display_string(msg, 1)


mqttClient.on_connect = on_connect
mqttClient.on_message = on_message

mqttClient.connect(Server)
while 1:
    mqttClient.loop_forever()
