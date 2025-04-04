import 'package:flutter/material.dart';

class ReceitaCard extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onDelete;
  final VoidCallback onSave;

  const ReceitaCard({
    super.key,
    required this.onClose,
    required this.onDelete,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onClose,
                  child: const Icon(Icons.close, color: Colors.black54),
                ),
                const Text(
                  'Receita',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: onDelete,
                  child: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'R\$ ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 4),
                Text(
                  '2.500,00',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(labelText: 'Nome da Receita'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              dropdownColor: Color(0xffFFFFFF),
              decoration: const InputDecoration(labelText: 'Categoria'),
              items:
                  ['Salário', 'Investimento', 'Outros']
                      .map(
                        (categoria) => DropdownMenuItem(
                          value: categoria,
                          child: Text(categoria),
                        ),
                      )
                      .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              dropdownColor: Color(0xffFFFFFF),
              decoration: const InputDecoration(labelText: 'Receber na conta'),
              items:
                  ['Conta Corrente', 'Carteira', 'Outros']
                      .map(
                        (conta) =>
                            DropdownMenuItem(value: conta, child: Text(conta)),
                      )
                      .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Data',

                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF087F5B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
