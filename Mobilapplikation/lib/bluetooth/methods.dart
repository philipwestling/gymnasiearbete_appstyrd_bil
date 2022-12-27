import 'package:gymnasiearbete_appstyrd_bil/bluetooth/setup.dart';

/*

              valueToSend:
4  --> Bromsa
5  --> Åka Framåt + Deaktivera bromsljus
6  --> Åka Bakåt + Backljus + Deaktivera bromsljus
7  --> Helljus på/av
8  --> Blinkers vänster
9  --> Blinkers höger
10 --> Aktivera backljus
11 --> Deaktivera backljus
80 - 160 --> Kontrollera styrservot


*/

void sendToUnoWifi(int valueToSend) async {
  await flutterReactiveBle.writeCharacteristicWithResponse(
    characteristic,
    value: [valueToSend],
  );
}
