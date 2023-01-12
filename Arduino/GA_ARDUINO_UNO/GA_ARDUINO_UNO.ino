/* 

Denna kod exekveras på Arduino UNO Rev3, och fungerar som en "slave-device" till 
Arduino UNO WiFi Rev2 som skickar insignaler via följande bibliotek 
https://www.arduino.cc/reference/en/language/functions/communication/wire/.

Utöver <Wire.h> biblioteket används ytterliggare två bibliotek, ett för servostyrningen (https://www.arduino.cc/reference/en/libraries/servo/) 
och ett för motorerna (https://github.com/adafruit/Adafruit-Motor-Shield-library).

Komponenter:
Arduino UNO WiFi Rev2
Arduino UNO Rev3
L293D Motor Driver Shield
HS-755HB Servo
DC-motorer 6V (4 stycken)
Robothjul 65mm (4 stycken)
LiPo 18650 3.7V|2200mAh (2 stycken) - Seriekopplade
1.5V AA-batterier (4 stycken) - Seriekopplade

*/

// Inkludera nödvändiga bibliotek
#include <Servo.h>
#include <AFMotor.h>
#include <Wire.h>

// Använd bibliotek och skapa instanser av klasser
Servo servoSteering;
AF_DCMotor frontLeft(1);
AF_DCMotor frontRight(4);
AF_DCMotor rearRight(3);
AF_DCMotor rearLeft(2);

// Servovariabel - Värde från SDL ingång
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
}

// Konstant dataflöde --> Denna funktion loopas
void dataReceieve() {
  receiver = Wire.read();
 
  if (receiver > 79 && receiver < 161) {
    servoSteering.write(receiver);
  } else {
    switch (receiver) {
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
}



void tankSteering() {
  if (receiver == 120) {
    brake();
  }

  else if (receiver > 120 && receiver < 161) {
    tankSteerRight();

  } else if (receiver < 121 && receiver > 79) {
    tankSteerLeft();
  } else {
    brake();
  }
}

void tankSteerRight() {
  frontRight.setSpeed(255);
  frontLeft.setSpeed(255);
  rearRight.setSpeed(255);
  rearLeft.setSpeed(255);
  frontLeft.run(BACKWARD);
  frontRight.run(FORWARD);
  rearRight.run(FORWARD);
  rearLeft.run(BACKWARD);
}

void tankSteerLeft() {
  frontRight.setSpeed(255);
  frontLeft.setSpeed(255);
  rearRight.setSpeed(255);
  rearLeft.setSpeed(255);
  frontLeft.run(FORWARD);
  frontRight.run(BACKWARD);
  rearRight.run(BACKWARD);
  rearLeft.run(FORWARD);
}

void forward() {
  frontRight.setSpeed(255);
  frontLeft.setSpeed(255);
  rearRight.setSpeed(255);
  rearLeft.setSpeed(255);
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

void brake() {
  frontRight.run(RELEASE);
  frontLeft.run(RELEASE);
  rearLeft.run(RELEASE);
  rearRight.run(RELEASE);
}
