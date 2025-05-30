import 'package:app_money_flow/src/core/models/bank_account_model.dart';
import 'package:app_money_flow/src/core/utils/format_input_currency.dart';
import 'package:app_money_flow/src/widgets/button.dart';
import 'package:app_money_flow/src/widgets/inputs/colors_input.dart';
import 'package:app_money_flow/src/widgets/inputs/dropdown_input.dart';
import 'package:app_money_flow/src/widgets/inputs/input.dart';
import 'package:app_money_flow/src/widgets/modals/confirm_delete_modal.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:validatorless/validatorless.dart';
import './account_modal_controller.dart';
import '../../../core/enums/bank_acount_type.dart';

class AccountModal extends StatefulWidget {
  final BankAccountModel? account;
  const AccountModal({super.key, this.account});

  @override
  State<AccountModal> createState() => _AccountModalState();
}

class _AccountModalState extends State<AccountModal> {
  final controller = GetIt.I<AccountModalController>();
  late final ValueNotifier<String?> _selectedColor;

  @override
  void initState() {
    super.initState();

    if (widget.account != null) {
      controller.loadAccountToEdit(widget.account!);
    } else {
      controller.reset();
    }

    _selectedColor = ValueNotifier<String?>(controller.selectedColor);
  }

  void _handleDelete(String? accountId) {
    final currentContext = context;

    Navigator.of(context).pop(); // fecha o modal de edição

    Future.delayed(Duration.zero, () {
      showConfirmDeleteModal(
        context: currentContext,
        title: 'Tem certeza que deseja excluir esta conta?',
        description:
            'Ao excluir a conta, também serão excluídos todos os registros de receita ee despesas relacionados.',
        isLoading: controller.isDeleting,
        onConfirm: () => controller.deleteAccount(currentContext, accountId!),
      );
    });
  }

  void handleSubmitForm() {
    if (controller.isLoading) return;

    controller.submit(() {
      Navigator.of(context).pop();
    }).then((success) {
      if (!success) setState(() {});
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding:
          const EdgeInsets.all(16), // Evita o modal encostar nas bordas
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Evita sobreposição com teclado
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 400,
                maxHeight: MediaQuery.of(context).size.height *
                    0.9, // Limita a altura total
              ),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.reset();
                              Navigator.of(context).pop();
                            },
                            child:
                                const Icon(Icons.close, color: Colors.black54),
                          ),
                          Text(
                            controller.isEditing
                                ? 'Editar Conta'
                                : 'Nova Conta',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (controller.isEditing)
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _handleDelete(controller.editingAccount?.id);
                              },
                            )
                          else
                            const SizedBox(width: 48),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            Input(
                              label: 'Nome da Conta',
                              controller: controller.nameController,
                              validator:
                                  Validatorless.required('Nome é obrigatório'),
                            ),
                            const SizedBox(height: 16),
                            Input(
                              label: 'Saldo Inicial',
                              controller: controller.initialBalanceController,
                              validator:
                                  Validatorless.required('Saldo é obrigatório'),
                              inputFormatters: [CurrencyInputFormatter()],
                            ),
                            const SizedBox(height: 16),
                            DropdownFormInput<BankAccountType>(
                              label: 'Tipo',
                              value: controller.selectedType,
                              items: BankAccountType.values.map((type) {
                                return DropdownMenuItem(
                                  value: type,
                                  child: Text(type.label),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) controller.setType(value);
                              },
                            ),
                            const SizedBox(height: 16),
                            ValueListenableBuilder<String?>(
                              valueListenable: _selectedColor,
                              builder: (_, selectedColor, __) {
                                return ColorPickerDropdownFormField(
                                  initialValue: selectedColor,
                                  onChanged: (value) {
                                    _selectedColor.value = value;
                                    controller.setColor(value!);
                                  },
                                  validator:
                                      Validatorless.required('Informe a cor'),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Button(
                        text: controller.isEditing ? 'Editar' : 'Criar',
                        isLoading: controller.isLoading,
                        onPressed: handleSubmitForm,
                        disabled: controller.isLoading,
                        variant: ButtonVariant.normal,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
