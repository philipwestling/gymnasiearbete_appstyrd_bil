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
#include <ArduinoBLE.h>

// Bluetooth® Low Energy LED Service
BLEService appstyrdBilService("19B10000-E8F2-537E-4F6C-D104768A1214");

// Bluetooth® Low Energy LED Switch Characteristic - custom 128-bit UUID, read and writable by central
BLEByteCharacteristic switchCharacteristic("19B10001-E8F2-537E-4F6C-D104768A1214", BLERead | BLEWrite);

// Lampor fram
const int highBeamLeft = A0;
const int highBeamRight = A1;
const int lowBeamLeft = 2;
const int lowBeamRight = 3;
const int frontTurnSignalLeft = 4;
const int frontTurnSignalRight = 5;

// Lampor sida
const int sideTurnSignalLeft = 6;
const int sideTurnSignalRight = 7;

// Lampor bak
const int rearTurnSignalLeft = 8;
const int rearTurnSignalRight = 9;
const int brakeLightLeft = 10;
const int brakeLightRight = 11;
const int reverseLight = 12;

// Lampor övrigt
const int turnSignalDelayTime = 600;

// Data från telefonen sparas i denna variabel
int dataFromPhone;


void setup() {

  Wire.begin();
  Serial.begin(9600);
  if (!BLE.begin()) {
    Serial.println("Kunde inte starta bluetoothmodul!");

    while (true)
      ;
  } else {
    Serial.println("Startar bluetoothmodul!");
  }

  // add the characteristic to the service
  appstyrdBilService.addCharacteristic(switchCharacteristic);

  BLE.setLocalName("Appstyrd Bil");
  BLE.setAdvertisedService(appstyrdBilService);

  // add service
  BLE.addService(appstyrdBilService);

  // start advertising
  BLE.advertise();

  // Lampor
  for (int i = 2; i < 13; i++) {
    pinMode(i, OUTPUT);
  }
  pinMode(A0, OUTPUT);
  pinMode(A1, OUTPUT);

  // Halvljus konstant på
  digitalWrite(lowBeamLeft, 1);
  digitalWrite(lowBeamRight, 1);

  // Bromsljus aktiverade i början för att visa att bilen står still och väntar på kommandon
  brakeLightsActivate();
}

void loop() {
  BLEDevice central = BLE.central();
  if (central) {
    Serial.println("Connected to " + central.address());

    while (central.connected()) {


      if (switchCharacteristic.written()) {
        if (switchCharacteristic.value()) {
          dataFromPhone = switchCharacteristic.value();
          Serial.println(dataFromPhone);
          sendDataToUNO();
          switch (dataFromPhone) {
            case 4:
              brakeLightsActivate();
              break;
            case 5:
              brakeLightsDeactivate();
              break;
            case 6:
              brakeLightsDeactivate();
              reverseLightActivate();
              break;
            case 7:
              highBeamOnOff();
              break;
            case 8:
              turnSignalLeft();
              break;
            case 9:
              turnSignalRight();
              break;
            case 10:
              reverseLightActivate();
              break;
            case 11:
              reverseLightDeactivate();
              break;
          }
        }
      }
    }
    Serial.println("Disconnected from " + central.address());
  }
}

void sendDataToUNO() {
  Wire.beginTransmission(4);
  Wire.write(dataFromPhone);
  Wire.endTransmission(4);
}

// Helljus
void highBeamOnOff() {
  Serial.println(digitalRead(highBeamLeft));
  digitalWrite(highBeamLeft, !digitalRead(highBeamLeft));
  digitalWrite(highBeamRight, !digitalRead(highBeamRight));
}

// INTE FÄRDIG
void turnSignalLeft() {
  int x = 0;
  while (x < 3) {
    digitalWrite(frontTurnSignalLeft, 1);
    digitalWrite(sideTurnSignalLeft, 1);
    digitalWrite(rearTurnSignalLeft, 1);
    delay(turnSignalDelayTime);
    digitalWrite(frontTurnSignalLeft, 0);
    digitalWrite(sideTurnSignalLeft, 0);
    digitalWrite(rearTurnSignalLeft, 0);
    delay(turnSignalDelayTime);
    x++;
  }
}

// INTE FÄRDIG
void turnSignalRight() {
  int x = 0;
  while (true) {
    digitalWrite(frontTurnSignalRight, 1);
    digitalWrite(sideTurnSignalRight, 1);
    digitalWrite(rearTurnSignalRight, 1);
    delay(turnSignalDelayTime);
    digitalWrite(frontTurnSignalRight, 0);
    digitalWrite(sideTurnSignalRight, 0);
    digitalWrite(rearTurnSignalRight, 0);
    delay(turnSignalDelayTime);
    x++;
  }
}


void brakeLightsActivate() {
  digitalWrite(brakeLightLeft, 1);
  digitalWrite(brakeLightRight, 1);
}

void brakeLightsDeactivate() {
  digitalWrite(brakeLightLeft, 0);
  digitalWrite(brakeLightRight, 0);
}


void reverseLightActivate() {
  digitalWrite(reverseLight, 1);
}

void reverseLightDeactivate() {
  digitalWrite(reverseLight, 0);
}
