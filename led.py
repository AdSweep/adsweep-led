import sys, time
import RPi.GPIO as GPIO

# Pins the led is connected to on the 3b+
rPin  = 33
gPin = 12
bPin = 32

# Use board pin numbers
GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)

# Set pins to output
GPIO.setup(rPin, GPIO.OUT)
GPIO.setup(gPin, GPIO.OUT)
GPIO.setup(bPin, GPIO.OUT)

# Set pins to output nothing for now
GPIO.output(rPin, GPIO.LOW)
GPIO.output(gPin, GPIO.LOW)
GPIO.output(bPin, GPIO.LOW)

# Set up PWM
rPWM = GPIO.PWM(rPin, 150)
gPWM = GPIO.PWM(gPin, 150)
bPWM = GPIO.PWM(bPin, 150)

# Enable PWM
rPWM.start(0)
gPWM.start(0)
bPWM.start(0)

# Green on: everything is OK
def greenOn():
	gPWM.ChangeDutyCycle(100)

# Red on: Something is wrong with Pi-Hole
def redOn():
	rPWM.ChangeDutyCycle(100)

# Flash green: booting the OS and Pi-Hole
def greenFlash():
	for dc in range(0, 100):
		gPWM.ChangeDutyCycle(dc)
		time.sleep(0.0075)
	for dc in range(100, 0, -1):
		gPWM.ChangeDutyCycle(dc)
		time.sleep(0.01)
	gPWM.ChangeDutyCycle(0)
		
# Flash red: Something is VERY WRONG
def redFlash():
	for dc in range(0, 100):
		rPWM.ChangeDutyCycle(dc)
		time.sleep(0.0075)
	for dc in range(100, 0, -1):
		rPWM.ChangeDutyCycle(dc)
		time.sleep(0.01)
	rPWM.ChangeDutyCycle(0)

# Turn the led off
def off():
	rPWM.ChangeDutyCycle(0)
	gPWM.ChangeDutyCycle(0)
	bPWM.ChangeDutyCycle(0)

# Cleanup, not important
def end():
	rPWM.stop()
	gPWM.stop()
	bPWM.stop()
	GPIO.cleanup()

def main():
	while True:
		file = open("led.status", "r")
		ledStatus = file.readline()
		ledStatus.rstrip()
		ledStatus.strip()
		print ledStatus
		if ledStatus == "greenOn":
			greenOn()
		if ledStatus == "greenFlash":
			greenFlash()
		if ledStatus == "redOn":
			redOn()
		if ledStatus == "redFlash":
			redFlash()
		if ledStatus == "off":
			off()
		time.sleep(1)
	end()

main()
