import paho.mqtt.client as mqtt
import time
clientName = "RPI"
Server = "localhost"
mqttClient = mqtt.Client(clientName)
topic = "lvl/0"


def on_connect(client, userdata, flags, rc):
    # The topic subscribing to.
    mqttClient.subscribe(topic)


def on_message(client, userdata, msg):
    message = msg.payload.decode(encoding='UTF-8')
    print(message)


mqttClient.on_connect = on_connect
mqttClient.on_message = on_message

mqttClient.connect(Server)
while 1:
    mqttClient.loop_forever()
