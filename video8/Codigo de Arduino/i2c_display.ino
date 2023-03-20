#include <Wire.h>

byte in;
byte out;

void setup() {
 Wire.begin();
 Serial.begin(115200);
}

void loop() {
 while(!Serial.available()>0){;}
 in=Serial.read()-'0';
 Serial.print("Enviando a la FPGA ");
 Serial.println(in);

 Wire.beginTransmission(0x3);
 Wire.write(in);
 Wire.endTransmission();

 delay(1);

 Wire.requestFrom(3,1);
 while(!Wire.available()){;}
 out=Wire.read();

 Serial.print("Recibiendo de la FPGA ");
 Serial.println(out,DEC);
 
 delay(1000);

}
