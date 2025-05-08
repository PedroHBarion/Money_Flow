import 'package:app_money_flow/src/core/utils/format_date.dart';
import 'package:app_money_flow/src/widgets/inputs/input.dart';
import 'package:flutter/material.dart';


class DatePickerInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerInput({
    super.key, 
    required this.controller,
    required this.label,
    required this.onDateSelected,
    this.errorText,
    this.initialDate,
  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          locale: const Locale('pt', 'BR'),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Color(0xFF087F5B), // teal-900
                  onPrimary: Colors.white, // text on header
                  onSurface: Color(0xFF343A40), // gray-800
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFF099268), // teal-800
                  ),
                ), 
                datePickerTheme: DatePickerThemeData(
                  backgroundColor: Color(0xFFF8F9FA), // gray-50
                  todayBackgroundColor: WidgetStateProperty.all(Color(0xFFE9ECEF)), // gray-200
                  todayForegroundColor: WidgetStateProperty.all(Color(0xFF212529)), // gray-900
                  dayOverlayColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Color(0xFF087F5B).withOpacity(0.9); // teal-900
                    }
                    if (states.contains(WidgetState.hovered)) {
                      return Color(0xFFE6FCF5); // teal-50
                    }
                    return null;
                  }),
                  dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.white;
                    }
                    return Color(0xFF495057); // gray-700
                  }),
                ), dialogTheme: DialogThemeData(backgroundColor: Color(0xFFF8F9FA)),
              ),
              child: child!,
            );
          },
        );


        if (pickedDate != null) {
          onDateSelected(pickedDate); 
          controller.text = formatDate(pickedDate);
        }
      },
      child: AbsorbPointer(
        child: Input(
          label: label,
          controller: controller,
          errorText: errorText,
        ),
      ),
    );
  }
}
