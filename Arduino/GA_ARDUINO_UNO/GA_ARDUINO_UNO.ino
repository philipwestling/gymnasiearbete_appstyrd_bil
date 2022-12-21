/* 

Denna kod exekveras på Arduino UNO, och fungerar som en "slave-device" till 
Arduino UNO WiFi Rev2 som skickar insignaler via följande bibliotek 
https://www.arduino.cc/reference/en/language/functions/communication/wire/.

Utöver <Wire.h> biblioteket används ytterliggare två bibliotek, ett för servostyrningen (https://www.arduino.cc/reference/en/libraries/servo/) 
och ett för motorerna (https://github.com/adafruit/Adafruit-Motor-Shield-library).

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

#include <Servo.h>
#include <AFMotor.h>
#include <Wire.h>
Servo servoSteering;

AF_DCMotor frontLeft(1);
AF_DCMotor frontRight(4);
AF_DCMotor rearRight(3);
AF_DCMotor rearLeft(2);


int receiver;

void setup() {
  Wire.begin(4);
  Wire.onReceive(dataReceieve);
  Serial.begin(9600);
  servoSteering.attach(A0);
  // Centrera servon
  servoSteering.write(95);
}

void loop() {
  delay(100);

  

  // switch-operator beroende på insignal från UNO WiFi
}

void dataReceieve() {

  receiver = Wire.read();
  Serial.println(receiver);
  if (receiver > 79 && receiver < 161) {
    servoSteering.write(receiver);
  }
    switch (receiver) {
    case 1:
      Serial.println("Left \n");
      left();
      break;
    case 2:
      Serial.println("Straight \n");
      straight();
      break;
    case 3:
      Serial.println("Right \n");
      right();
      break;
    case 4:
      Serial.println("Brake \n");
      brake();
      break;
    case 5:
      Serial.println("Forward \n");
      forward();
      break;
    case 6:
      Serial.println("Backward \n");
      backward();
      break;
    default:
      break;
  }
  
  
}

void forward() {
  frontRight.setSpeed(200);
  frontLeft.setSpeed(200);
  rearRight.setSpeed(200);
  rearLeft.setSpeed(200);
  frontRight.run(FORWARD);
  frontLeft.run(FORWARD);
  rearLeft.run(FORWARD);
  rearRight.run(FORWARD);
}

void backward() {
  frontRight.setSpeed(255);
  frontLeft.setSpeed(255);
  rearRight.setSpeed(255);
  rearLeft.setSpeed(255);
  frontRight.run(BACKWARD);
  frontLeft.run(BACKWARD);
  rearLeft.run(BACKWARD);
  rearRight.run(BACKWARD);
}

void left() {
  servoSteering.write(160);
}

void right() {
  servoSteering.write(80);
}

void straight() {
  servoSteering.write(95);
}

void brake() {
  frontRight.run(RELEASE);
  frontLeft.run(RELEASE);
  rearLeft.run(RELEASE);
  rearRight.run(RELEASE);
}
