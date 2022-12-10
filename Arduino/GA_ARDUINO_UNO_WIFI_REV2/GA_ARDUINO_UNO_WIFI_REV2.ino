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

BLEService appstyrdBilService("19B10000-E8F2-537E-4F6C-D104768A1214");  // Bluetooth® Low Energy LED Service

// Bluetooth® Low Energy LED Switch Characteristic - custom 128-bit UUID, read and writable by central
BLEByteCharacteristic switchCharacteristic("19B10001-E8F2-537E-4F6C-D104768A1214", BLERead | BLEWrite);

int dataFromPhone;

void setup() {
  Serial.begin(9600);
  Wire.begin();
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
}

void loop() {
  BLEDevice central = BLE.central();
  if (central) {
    Serial.println("Connected to " + central.address());

    while (central.connected()) {
      if (switchCharacteristic.written()) {
        dataFromPhone = switchCharacteristic.value();
        Wire.beginTransmission(1);
        Wire.write(dataFromPhone);
        delay(50);
        Wire.endTransmission();
      }
    }
    Serial.println("Disconnected from " + central.address());
  }
}

void turnSignal() {
}
