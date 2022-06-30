from flask import Flask, render_template
state='STATE'
import serial

app = Flask(__name__)

btSerial = serial.Serial("/dev/rfcomm0", baudrate=9600)


a=bytes('w','utf-8')
b=bytes('e','utf-8')
c=bytes('qo','utf-8')
d=bytes('qf','utf-8')
e=bytes('qa','utf-8')
f=bytes('qb','utf-8')
g=bytes('qc','utf-8')
h=bytes('qd','utf-8')

def turnOn(onoff):
    if onoff == "AUTO":
        btSerial.write(a)
        return "AUTO"
    elif onoff == "MANUAL":
        btSerial.write(b)
        return "MANUAL"
    elif onoff == "ON":
        btSerial.write(c)
        return "ON"
    elif onoff == "OFF":
        btSerial.write(d)
        return "OFF"
    elif onoff == "OPEN1":
        btSerial.write(e)
        return "OPEN1"
    elif onoff == "CLOSE1":
        btSerial.write(f)
        return "CLOSE1"
    elif onoff == "OPEN2":
        btSerial.write(g)
        return "OPEN2"
    elif onoff == "CLOSE2":
        btSerial.write(h)
        return "CLOSE2"

@app.route('/')
def index():
   
   return render_template('index.html',state=state)
@app.route('/switch/<onoff>')
def led(onoff):
  global state
  state=onoff
  turnOn(state)
  print('light %s' % state)
  return render_template('index.html',state=onoff)

if __name__ == "__main__":
    app.run(host='0.0.0.0',port=80, debug=True)