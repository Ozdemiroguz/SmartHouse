import 'dart:ui';

class ColorConverter {
  static Color hexToColor(String hexString) {
    // Hex renk kodunu geçerli bir renk nesnesine dönüştürme
    final buffer = StringBuffer();

    // Hex kodun başında # işareti varsa onu kaldırma
    if (hexString.length == 7 || hexString.length == 9) {
      hexString = hexString.replaceFirst('#', '');
    }

    // Opaklık değeri olup olmadığını kontrol etme
    if (hexString.length == 6) {
      buffer.write('ff'); // Opaklık değeri yoksa, varsayılan olarak 'ff' (255) kullan
    }

    buffer.write(hexString);

    return Color(int.parse(buffer.toString(), radix: 16));
  }
}