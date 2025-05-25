import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters; // ✅ novo

  const Input({
    super.key,
    required this.label,
    required this.controller,
    this.errorText,
    this.obscureText = false,
    this.validator,
    this.inputFormatters, // ✅ novo
  });

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const ValueKey('senha_input'),
      controller: widget.controller,
      obscureText: _obscure,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters, // ✅ novo
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorText: widget.errorText,
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    }
                  });
                },
                child: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                  color: Colors.black,
                ),
              )
            : null,
      ),
    );
  }
}
