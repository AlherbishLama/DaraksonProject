import paho.mqtt.client as mqtt
import time
import I2CDriver
import RPi.GPIO as g
clientName = "RPI"
Server = "localhost"
mqttClient = mqtt.Client(clientName)
topic = "lvl/2"
mylcd = I2CDriver.lcd()
def init():
    g.setmode(g.BCM)
    g.setup(17,g.OUT)
    g.setup(22,g.OUT)
    g.setup(23,g.OUT)
    g.setup(24,g.OUT)
def loopright(sec):
    init()
    g.output(17,True)
    g.output(22,False)
    g.output(23,False)
    g.output(24,True)
    time.sleep(sec)
    g.cleanup()
def loopleft(sec):
    init()
    g.output(17,False)
    g.output(22,True)
    g.output(23,True)
    g.output(24,False)
    time.sleep(sec)
    g.cleanup()
def on_connect(client, userdata, flags, rc):
    # The topic subscribing to.
    mqttClient.subscribe(topic)

def loop(sleep,message):

def on_message(client, userdata, msg):
    message = msg.payload.decode(encoding='UTF-8')
    for i in list(range(int(message))):
        if i % 2 == 0:
            loopright(1)
            time.sleep(2)
        else:
            loopleft(1)
            time.sleep(2)



mqttClient.on_connect = on_connect
mqttClient.on_message = on_message

mqttClient.connect(Server)
while 1:
    mqttClient.loop_forever()