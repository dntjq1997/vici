#include <Servo.h>
#include <SoftwareSerial.h>
#include <DHT.h>
#define DHTPIN 6
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

SoftwareSerial btSerial(10,11);
Servo myServo;
int CDS = A1;
int LED = 7;
int value = 0; //ingam`s sensor value
int ingam = 4;
void setup() {
  pinMode(LED,OUTPUT);
  pinMode(ingam,INPUT);
  
  Serial.begin(9600);
  btSerial.begin(9600);
  dht.begin();
  write(90);
  write2(90);
}

void loop() {
  int jodo = analogRead(CDS);
  value = digitalRead(ingam);
  int t = dht.readTemperature();
  int h = dht.readHumidity();

  Serial.println("----MANUAL----");
  Serial.print("온도(°C) : ");      
  Serial.println(t);   
  Serial.print("습도(%)  : ");          
  Serial.println(h);
  Serial.println("--------------");                  
              
  delay(1000);
  btSerial.write(h);

  if(btSerial.available()){
    char c = btSerial.read();
    
    if (c == 'q'){ // SUDONG MODE
    
      if (btSerial.available()){
        char q = btSerial.read(); // sensor control
      
        switch(q){
          case 'a': // open main door 
          write(0);
          break;
      
          case 'b': // close main door
          write(90);
          break;

          case 'c': // open window
          write2(150);
          break;

          case 'd': // close window
          write2(90);
          break;

          case 'o': // led on
          digitalWrite(LED,HIGH);
          break;

          case 'f': // led off
          digitalWrite(LED,LOW);
          break;
        }
      }
    }
  
    else if (c == 'w'){ //automatic mode
      while(1){
        int jodo = analogRead(CDS);
        char c = btSerial.read();
        int h = dht.readHumidity();
        value = digitalRead(ingam);

        Serial.println("-----AUTO-----");
        Serial.print("-조도(lx) : "); 
        Serial.println(jodo);
        Serial.print("-습도(%)  : "); 
        Serial.println(h);
        Serial.println("--------------");
        delay(500);
        
        if(c == 'e'){ //automatic off
        break;
        }
        if (h >= 70) {
          write2(150);
        }
        else {
          write2(90);
        }
        if (value == HIGH) {
          write(0);
        }
        else {
          write(90);
        }
        if (jodo <= 800){
          digitalWrite(LED,HIGH);
        }
        else{
          digitalWrite(LED,LOW);
        }
      } 
    }
  }  
}

void write(int angle) { // main door
  myServo.attach(9);
  myServo.write(angle);
  delay(1000);
  myServo.detach();
}
void write2(int angle) { // window 
  myServo.attach(8);
  myServo.write(angle);
  delay(1000);
  myServo.detach();
}
