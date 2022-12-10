/* 

Denna kod exekveras på Arduino UNO WiFi Rev2 och fungerar som "master-device" till 
Arduino UNO genom att skicka signaler via följande bibliotek https://www.arduino.cc/reference/en/language/functions/communication/wire/.
Arduino UNO WiFi Rev2 får data via bluetooth från den mobilenhet som är ansluten till Arduinokortet.

Komponenter:
Arduino UNO WiFi Rev2
Arduino UNO
L293D Motor Driver Shield
HS-755HB Servo
DC-motorer 6V (4 stycken)
Robothjul 65mm (4 stycken)
LiPo 18650 3.7V|2200mAh (2 stycken) - Seriekopplade
1.5V AA-batterier (4 stycken) - Seriekopplade

*/

#include <Wire.h>


void setup() {
  Serial.begin(9600);
  Wire.begin();
  // Lampor

}

void loop() {
  for (int i = 0; i < 256; i++) {
    Wire.beginTransmission(1);
    Wire.write(i);
    Serial.println(i);
    Wire.endTransmission();
    delay(100);
  }
  
}

void turnSignal() {

}
