import 'package:flutter/material.dart';
import '../icons/color_icon.dart'; 

class _Color {
  final String color;
  final String bg;

  _Color({required this.color, required this.bg});
}

final List<_Color> _colors = [
  _Color(color: '#868E96', bg: '#F8F9FA'),
  _Color(color: '#FA5252', bg: '#FFF5F5'),
  _Color(color: '#E64980', bg: '#FFF0F6'),
  _Color(color: '#BE4BDB', bg: '#F8F0FC'),
  _Color(color: '#7950F2', bg: '#F3F0FF'),
  _Color(color: '#4C6EF5', bg: '#EDF2FF'),
  _Color(color: '#228BE6', bg: '#E7F5FF'),
  _Color(color: '#15AABF', bg: '#E3FAFC'),
  _Color(color: '#12B886', bg: '#E6FCF5'),
  _Color(color: '#40C057', bg: '#EBFBEE'),
  _Color(color: '#82C91E', bg: '#F4FCE3'),
  _Color(color: '#FAB005', bg: '#FFF9DB'),
  _Color(color: '#FD7E14', bg: '#FFF4E6'),
  _Color(color: '#212529', bg: '#F8F9FA'),
];

class ColorPickerDropdownFormField extends FormField<String> {
  ColorPickerDropdownFormField({
    super.key,
    super.initialValue,
    required void Function(String?) onChanged,
    super.validator,
  }) : super(
          builder: (FormFieldState<String> state) {
            final selectedColor = _colors.firstWhere(
              (c) => c.color == state.value,
              orElse: () => _Color(color: '', bg: ''),
            );

            final bool isSelectedColor = selectedColor.bg != '' && selectedColor.color != '';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: state.context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        content: SizedBox(
                          width: 250,
                          child: GridView.count(
                            crossAxisCount: 4,
                            shrinkWrap: true,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: _colors.map((c) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  state.didChange(c.color);
                                  onChanged(c.color);
                                },
                                child: ColorIcon(color: c.color, bg: c.bg),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 52,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: state.hasError ? Colors.red : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(isSelectedColor ? "Sua cor" : 'Selecione uma cor'),
                        isSelectedColor
                            ? ColorIcon(color: selectedColor.color, bg: selectedColor.bg)
                            : const Icon(Icons.expand_more),
                      ],
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 4),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        );
}
