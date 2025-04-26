import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const Input({
    super.key,
    required this.label,
    required this.controller,
    this.errorText,
    this.obscureText = false,
    this.validator, // <- Adicionado aqui
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
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorText: widget.errorText, // Pode ser removido futuramente
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
