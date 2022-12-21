import 'package:gymnasiearbete_appstyrd_bil/bluetooth/setup.dart';

/*

              valueToSend:
1 - Svänga Vänster
2 - Centrera styrning
3 - Svänga Höger
4 - Bromsa
5 - Åka Framåt
6 - Åka Bakåt

*/

void sendToUnoWifi(int valueToSend) async {
  await flutterReactiveBle.writeCharacteristicWithResponse(
    characteristic,
    value: [valueToSend],
  );
}
