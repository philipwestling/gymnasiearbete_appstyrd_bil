import 'package:gymnasiearbete_appstyrd_bil/bluetooth/setup.dart';

/*

              valueToSend:
1 - Svänga Vänster
2 - Centrera styrning
3 - Svänga Höger
4 - Bromsa
5 - Åka Framåt + Deaktivera bromsljus
6 - Åka Bakåt + Backljus + Deaktivera bromsljus
7 - Helljus
8 - Blinkers vänster
9 - Blinkers höger
10 - Aktivera backljus
11 - Deaktivera backljus


*/

void sendToUnoWifi(int valueToSend) async {
  await flutterReactiveBle.writeCharacteristicWithResponse(
    characteristic,
    value: [valueToSend],
  );
}
