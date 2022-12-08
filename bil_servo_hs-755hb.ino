#include <Servo.h>
Servo servo;
void setup() {
  // put your setup code here, to run once:
  servo.attach(A0);
  
}

void loop() {
  // put your main code here, to run repeatedly:
    servo.write(82); // Mitten
    delay(1000);
    servo.write(62); // Vänster
    delay(1000);
    servo.write(82); // Mitten
    delay(1000);
    servo.write(102); // Höger
    delay(1000);
    

    
    

}
