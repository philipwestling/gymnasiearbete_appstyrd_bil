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
AF_DCMotor frontLeft(2);
AF_DCMotor frontRight(1);
AF_DCMotor rearRight(4);
AF_DCMotor rearLeft(3);
Servo servo;

int receiver;

void setup() {
  Serial.begin(9600);
  servo.attach(A0);
  Wire.begin(1);
  Wire.onReceive(dataReceieve);
}

void loop() {
  /*servo.write(90);  // Mitten
  delay(2500);
  servo.write(70);
  delay(2500);
  servo.write(90);
  delay(2500);
  servo.write(110);
  delay(2500);*/
 


  // switch-operator beroende på insignal från UNO WiFi
  forward();
  delay(3000);
  brake();
  delay(2000);
  backward();
  delay(3000);
  brake();
  delay(2000);
}

void dataReceieve() {
  receiver = Wire.read();

  Serial.println(receiver);
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
}

void right() {
}

void brake() {
  frontRight.run(RELEASE);
  frontLeft.run(RELEASE);
  rearLeft.run(RELEASE);
  rearRight.run(RELEASE);
}



void servoSteeringTest() {
  servoSteering.write(82);  // Mitten
  delay(1000);
  servoSteering.write(62);  // Vänster
  delay(1000);
  servoSteering.write(82);  // Mitten
  delay(1000);
  servoSteering.write(102);  // Höger
  delay(1000);
}

void motorDriveTest() {
  frontRight.setSpeed(200);
  frontLeft.setSpeed(200);
  rearLeft.setSpeed(200);
  rearRight.setSpeed(200);
  frontRight.run(FORWARD);
  frontLeft.run(FORWARD);
  rearLeft.run(FORWARD);
  rearRight.run(FORWARD);
  delay(2000);
  frontRight.run(BACKWARD);
  frontLeft.run(BACKWARD);
  rearLeft.run(BACKWARD);
  rearRight.run(BACKWARD);
  delay(2000);
  frontRight.run(RELEASE);
  frontLeft.run(RELEASE);
  rearLeft.run(RELEASE);
  rearRight.run(RELEASE);
  delay(2000);
}
