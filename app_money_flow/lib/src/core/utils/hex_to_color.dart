import 'dart:ui';

Color hexToColor(String hex) {
  // Remove o # se existir
  hex = hex.replaceAll('#', '');


  if (hex.length == 3) {
    hex = hex.split('').map((c) => '$c$c').join('');
  }

  if (hex.length == 6) {
    hex = 'FF$hex';
  }

  return Color(int.parse('0x$hex'));
}
