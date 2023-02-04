import 'package:pdf/widgets.dart';

cutomQr({required String data}) {
  return Container(
    height: 50,
    width: 50,
    child: BarcodeWidget(
      barcode: Barcode.qrCode(),
      data: data,
    ),
  );
}
