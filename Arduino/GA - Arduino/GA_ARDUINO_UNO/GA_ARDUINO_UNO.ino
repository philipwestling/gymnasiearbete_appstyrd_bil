#include <Servo.h>
#include <AFMotor.h>
Servo servo;
AF_DCMotor frontLeft(4);
AF_DCMotor frontRight(3);
AF_DCMotor rearRight(2);
AF_DCMotor rearLeft(1);
void setup() {
  // put your setup code here, to run once:
  servo.attach(A0);
}

void loop() {
  // put your main code here, to run repeatedly:

  servoSteering();
  delay(1000);
  motorDrive();

}

void servoSteering() {
  servo.write(82);  // Mitten
  delay(1000);
  servo.write(62);  // Vänster
  delay(1000);
  servo.write(82);  // Mitten
  delay(1000);
  servo.write(102);  // Höger
  delay(1000);
}

void motorDrive() {
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
