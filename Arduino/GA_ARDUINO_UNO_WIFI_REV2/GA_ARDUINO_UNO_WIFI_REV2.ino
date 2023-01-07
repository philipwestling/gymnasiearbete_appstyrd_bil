/* 

Denna kod exekveras på Arduino UNO WiFi Rev2 och fungerar som "master-device" till 
Arduino UNO Rev3 genom att skicka signaler via följande bibliotek https://www.arduino.cc/reference/en/language/functions/communication/wire/.
Arduino UNO WiFi Rev2 får data via bluetooth från den mobilenhet som är ansluten till Arduinokortet.

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

// Importera bibliotek
#include <Wire.h>
#include <ArduinoBLE.h>

// Bluetooth Low Energy Service - UUID för att identifiera Service
BLEService appstyrdBilService("19B10000-E8F2-537E-4F6C-D104768A1214");

// BluetoothLow Energy Characteristic - UUID som går att läsa samt skriva till
BLEByteCharacteristic appStyrdBilCharacteristic("19B10001-E8F2-537E-4F6C-D104768A1214", BLERead | BLEWrite);

// Lampor fram
const int highBeamLeft = A0;
const int highBeamRight = A1;
const int lowBeamLeft = 2;
const int lowBeamRight = 3;
const int frontTurnSignalLeft = 4;
const int frontTurnSignalRight = 5;

// Lampor bak
const int backLightLeft = 6;
const int backLightRight = 7;
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

  // Lägg till Characteristic till Service
  appstyrdBilService.addCharacteristic(appStyrdBilCharacteristic);

  // Bestäm namn som enheten ska visa sig under
  BLE.setLocalName("Appstyrd Bil");
  BLE.setAdvertisedService(appstyrdBilService);

  // Lägg till Service
  BLE.addService(appstyrdBilService);

  // Börja visa enhet
  BLE.advertise();

  // Lampor
  for (int i = 2; i < 13; i++) {
    pinMode(i, OUTPUT);
  }
  pinMode(A0, OUTPUT);
  pinMode(A1, OUTPUT);

  // Halvljus konstant på
  //digitalWrite(lowBeamLeft, 1);
  //digitalWrite(lowBeamRight, 1);

  // Bakljus konstant på
  //digitalWrite(backLightLeft, 1);
  //digitalWrite(backLightRight, 1);

  // Bromsljus aktiverade i början för att visa att bilen står still och väntar på kommandon
  //brakeLightsActivate();
}

void loop() {
  BLEDevice connectedDevice = BLE.central();
  // Gör detta medan en Bluetoothanslutning är upprättad
  if (connectedDevice) {
    Serial.println("Connected to " + connectedDevice.address());
    while (connectedDevice.connected()) {
      if (appStyrdBilCharacteristic.written()) {
        if (appStyrdBilCharacteristic.value()) {
          dataFromPhone = appStyrdBilCharacteristic.value();
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
    // Exekveras när en Bluetoothanslutning avslutas
    bluetoothConnectionLost(connectedDevice.address());
  }
}

void bluetoothConnectionLost(String connectedDeviceAddress) {
  Wire.beginTransmission(4);
  Wire.write(4);
  Wire.endTransmission(4);
  Serial.println("Disconnected from " + connectedDeviceAddress);
}

// Skickar data vidare till Arduino UNO Rev3
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

// Vänster blinkers
void turnSignalLeft() {
  int x = 0;
  while (x < 3) {
    digitalWrite(frontTurnSignalLeft, 1);
    digitalWrite(rearTurnSignalLeft, 1);
    delay(turnSignalDelayTime);
    digitalWrite(frontTurnSignalLeft, 0);
    digitalWrite(rearTurnSignalLeft, 0);
    delay(turnSignalDelayTime);
    x++;
  }
}

// Höger blinkers
void turnSignalRight() {
  int x = 0;
  while (x < 3) {
    digitalWrite(frontTurnSignalRight, 1);
    digitalWrite(rearTurnSignalRight, 1);
    delay(turnSignalDelayTime);
    digitalWrite(frontTurnSignalRight, 0);
    digitalWrite(rearTurnSignalRight, 0);
    delay(turnSignalDelayTime);
    x++;
  }
}

// Aktivera bromsljus
void brakeLightsActivate() {
  digitalWrite(brakeLightLeft, 1);
  digitalWrite(brakeLightRight, 1);
}

// Deaktiveras bromsljus
void brakeLightsDeactivate() {
  digitalWrite(brakeLightLeft, 0);
  digitalWrite(brakeLightRight, 0);
}

// Aktivera backljus
void reverseLightActivate() {
  digitalWrite(reverseLight, 1);
}

// Deaktivera backljus
void reverseLightDeactivate() {
  digitalWrite(reverseLight, 0);
}
