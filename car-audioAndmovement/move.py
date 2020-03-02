import RPi.GPIO as g
import paho.mqtt.client as mqtt
import time
from playsound import playsound
# playsound("/home/pi/Desktop/s.mp3")
from pydub import AudioSegment
from pydub.playback import play
def play_song(filename):
    song = AudioSegment.from_wav("b.wav")
    play(song)
clientName = "RPI"
# mqtt server address
serverAddress = "192.168.100.209"
def topic(client, userdata, flags, rc):
    # The topic that the raspberry pi is subscribing to.
    mqttClient.subscribe("rpi/move")



def init():
    g.setmode(g.BCM)
    g.setup(17,g.OUT)
    g.setup(22,g.OUT)
    g.setup(23,g.OUT)
    g.setup(24,g.OUT)
def forword(sec):
    init()
    g.output(17,True)
    g.output(22,False)
    g.output(23,True)
    g.output(24,False)
    time.sleep(sec)
    g.cleanup()
def back(sec):
    init()
    g.output(17,False)
    g.output(22,True)
    g.output(23,False)
    g.output(24,True)
    time.sleep(sec)
    g.cleanup()
def left(sec):
    init()
    g.output(17,False)
    g.output(22,True)
    g.output(23,True)
    g.output(24,False)
    time.sleep(sec)
    g.cleanup()
def right(sec):
    init()
    g.output(17,True)
    g.output(22,False)
    g.output(23,False)
    g.output(24,True)
    time.sleep(sec)
    g.cleanup()
def stop(sec):
    time.sleep(sec)
    g.cleanup()
def display_play(client, userdata, msg):
    time.sleep(0.1)
    message = msg.payload.decode(encoding='UTF-8')
    if message == "Top":
        forword(2)
    elif message == "Back":
        back(2)
    elif message == "Right":
        right(2)
    elif message == "Left":
        left(2)
    elif message == "beeb":
        play(song)
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