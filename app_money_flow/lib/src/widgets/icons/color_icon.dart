import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorIcon extends StatelessWidget {
  final String color;
  final String bg;

  const ColorIcon({
    super.key,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
          '''
    <svg width="35" height="34" viewBox="0 0 35 34" fill="none" xmlns="http://www.w3.org/2000/svg">
      <rect x="1.3335" y="0.5" width="33" height="33" rx="16.5" fill="$bg" />
      <path fill-rule="evenodd" clip-rule="evenodd"
        d="M17.3479 11.499H17.3946C17.5613 11.499 17.7346 11.579 17.8746 11.7123L22.5946 16.4323L23.1146 16.9589C23.268 17.1123 23.3479 17.3056 23.3279 17.4856C19.2479 17.3456 17.4879 15.579 17.3479 11.499ZM24.1946 16.7989C24.1146 16.5989 23.9879 16.4123 23.8213 16.2523L18.5813 11.0056C18.4279 10.859 18.2546 10.739 18.0746 10.6523C18.0546 10.6456 18.0413 10.639 18.0213 10.6323C17.9946 10.619 17.9679 10.6056 17.9413 10.6056C17.7213 10.519 17.4946 10.4856 17.2613 10.5056C13.8879 10.8056 11.2879 13.6923 11.3346 17.0789C11.3813 20.5723 14.2613 23.4523 17.7479 23.4989H17.8413C21.1879 23.4989 24.028 20.9123 24.3279 17.5723C24.3479 17.3123 24.3079 17.0456 24.1946 16.7989Z"
        fill="$color" />
      <rect x="1.3335" y="0.5" width="33" height="33" rx="16.5" stroke="white" />
    </svg>
    ''',
      width: 35,
      height: 34,
    );
  }
}
