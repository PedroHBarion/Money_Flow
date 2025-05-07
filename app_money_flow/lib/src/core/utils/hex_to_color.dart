import 'dart:ui';

Color hexToColor(String hex) {
  // Normaliza a string
  hex = hex.replaceAll('#', '').trim().toUpperCase();

  // Expande shorthand (#abc → #aabbcc)
  if (hex.length == 3) {
    hex = hex.split('').map((c) => '$c$c').join('');
  }

  // Se for formato RGB (6 dígitos), adiciona o alpha (FF)
  if (hex.length == 6) {
    hex = 'FF$hex';
  }

  // Se ainda não tiver 8 dígitos, lança erro
  if (hex.length != 8) {
    throw FormatException('Cor inválida: $hex');
  }


  return Color(int.parse('0x$hex'));
}
