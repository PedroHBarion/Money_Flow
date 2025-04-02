import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final bool obscureText; // Propriedade para indicar se o campo é de senha

  const Input({
    Key? key,
    required this.label,
    required this.controller,
    this.errorText,
    this.obscureText = false, // Padrão é não obscurecer
  }) : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  late bool _obscure; // Estado para controlar a visibilidade da senha

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText; // Inicializa com o valor da propriedade
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure, // Controla a visibilidade do texto
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorText: widget.errorText,
        suffixIcon:
            widget.obscureText
                ? IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure; // Alterna a visibilidade
                    });
                  },
                )
                : null, // Exibe o ícone apenas se for senha
      ),
    );
  }
}
