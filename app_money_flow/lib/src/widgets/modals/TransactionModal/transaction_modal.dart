import 'package:app_money_flow/src/core/enums/transaction_type.dart';
import 'package:app_money_flow/src/core/models/transactions/transaction_model.dart';
import 'package:app_money_flow/src/core/utils/format_input_currency.dart';
import 'package:app_money_flow/src/widgets/button.dart';
import 'package:app_money_flow/src/widgets/inputs/date_picker_input.dart';
import 'package:app_money_flow/src/widgets/inputs/dropdown_input.dart';
import 'package:app_money_flow/src/widgets/inputs/input.dart';
import 'package:app_money_flow/src/widgets/modals/confirm_delete_modal.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:validatorless/validatorless.dart';
import 'transaction_modal_controller.dart';

class TransactionModal extends StatefulWidget {
  final TransactionModel? transaction;
  final TransactionType type;

  const TransactionModal({
    super.key,
    this.transaction,
    required this.type,
  });

  @override
  State<TransactionModal> createState() => _TransactionModalState();
}

class _TransactionModalState extends State<TransactionModal> {
  final controller = GetIt.I<TransactionModalController>();

  @override
  void initState() {
    super.initState();

    controller.selectedType = widget.type;

    controller.init(widget.type).then((_) {
      if (widget.transaction != null) {
        controller.loadTransactionToEdit(widget.transaction!);
      }
    });
  }

  String get _titleText {
    final base = controller.isEditing ? 'Editar' : 'Nova';
    return '$base ${widget.type == TransactionType.expense ? 'Despesa' : 'Receita'}';
  }

  String get _accountLabel {
    return widget.type == TransactionType.expense ? 'Pagar com' : 'Receber com';
  }

  void _handleDelete(String? transactionId) {
    final currentContext = context;

    Navigator.of(currentContext).pop(); // fecha o modal de edição

    Future.delayed(Duration.zero, () {
      showConfirmDeleteModal(
        context: currentContext,
        title: 'Excluir transação?',
        description: 'Essa ação não poderá ser desfeita.',
        isLoading: controller.isDeleting,
        onConfirm: () =>
            controller.deleteTransaction(currentContext, transactionId!),
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
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          if (controller.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }

          return Dialog(
              backgroundColor: Color(0xffffffff),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Form(
                      key: controller.formKey,
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
                                child: const Icon(Icons.close,
                                    color: Colors.black54),
                              ),
                              Text(
                                _titleText,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              controller.isEditing
                                  ? IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () {
                                        _handleDelete(
                                            controller.editingTransaction?.id);
                                      },
                                    )
                                  : const SizedBox(width: 48),
                            ],
                          ),

                          const SizedBox(height: 40),
                          // Form inputs
                          Input(
                            label: 'Nome da Transação',
                            controller: controller.nameController,
                            validator:
                                Validatorless.required('Nome é obrigatório'),
                          ),
                          const SizedBox(height: 16),
                          Input(
                            label: 'Valor',
                            controller: controller.valueController,
                            validator:
                                Validatorless.required('Valor é obrigatório'),
                            inputFormatters: [CurrencyInputFormatter()],
                          ),
                          const SizedBox(height: 16),
                          DropdownFormInput<String>(
                            label: 'Categoria',
                            value: controller.selectedCategory,
                            items: controller.categories
                                .map((cat) => DropdownMenuItem(
                                      value: cat.id,
                                      child: Text(cat.name),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) controller.setCategory(value);
                            },
                          ),

                          const SizedBox(height: 16),
                          DropdownFormInput<String>(
                            label: _accountLabel,
                            value: controller.selectedAccount,
                            items: controller.accounts
                                .map((acc) => DropdownMenuItem(
                                      value: acc.id,
                                      child: Text(acc.name),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) controller.setAccount(value);
                            },
                          ),
                          const SizedBox(height: 16),
                          DatePickerInput(
                            controller: controller.dateController,
                            label: 'Data',
                            initialDate: controller.selectedDate,
                            onDateSelected: (DateTime date) {
                              setState(() {
                                controller.selectedDate = date;
                              });
                            },
                          ),
                          const SizedBox(height: 40),
                          Button(
                            text: controller.isEditing ? 'Editar' : 'Criar',
                            isLoading: controller.isLoading,
                            onPressed: () => handleSubmitForm(),
                            disabled: controller.isLoading,
                            variant: ButtonVariant.normal,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
