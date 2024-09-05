import 'dart:ui';

class HexColor extends Color {
  String hex;

  HexColor(this.hex) : super(detectHexColor(hex));
}

int detectHexColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return (int.parse(buffer.toString(), radix: 16));
}
