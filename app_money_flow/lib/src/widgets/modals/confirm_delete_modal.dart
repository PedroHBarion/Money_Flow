import 'package:app_money_flow/src/widgets/button.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final String? description;
  final VoidCallback onConfirm;
  final bool isLoading;

  const ConfirmDeleteDialog({
    super.key,
    required this.title,
    this.description,
    required this.onConfirm,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.delete_outline, color: Colors.red, size: 24),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1F2937),
                ),
              ),
              if (description != null) ...[
                const SizedBox(height: 8),
                Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              Column(
                children: [
                  Button(
                    text: 'Sim, desejo excluir',
                    isLoading: isLoading,
                    onPressed: isLoading ? null : onConfirm,
                    disabled: isLoading,
                    variant: ButtonVariant.danger,
                  ),
                  const SizedBox(height: 12),
                  Button(
                    text: 'Cancelar',
                    onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                    variant: ButtonVariant.ghost,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


void showConfirmDeleteModal({
  required BuildContext context,
  required String title,
  String? description,
  required bool isLoading,
  required VoidCallback onConfirm,
}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      pageBuilder: (_, __, ___) {
        return ConfirmDeleteDialog(
          title: title,
          description: description,
          isLoading: isLoading,
          onConfirm: onConfirm,
        );
      },
    ),
  );
}
