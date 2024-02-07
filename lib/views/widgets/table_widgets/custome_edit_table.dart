import 'package:dine_in_resturant/bloc/tables/tables_bloc.dart';
import 'package:dine_in_resturant/core/utils/k_color_scheme.dart';
import 'package:dine_in_resturant/core/utils/responsive.dart';
import 'package:dine_in_resturant/core/utils/toast.dart';
import 'package:dine_in_resturant/data/model/tables/tables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconsax/flutter_iconsax.dart';
import 'package:go_router/go_router.dart';

class CustomeEditingTableDialogue extends StatefulWidget {
  const CustomeEditingTableDialogue({
    super.key,
    required this.model,
    required this.isEditable,
  });

  final TableModel model;
  final bool isEditable;
  @override
  State<CustomeEditingTableDialogue> createState() =>
      _CustomCreatingTableDialogueState();
}

class _CustomCreatingTableDialogueState
    extends State<CustomeEditingTableDialogue> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final capacityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = widget.model.name ?? '';
    numberController.text = (widget.model.tableNumber ?? 0).toString();
    capacityController.text = (widget.model.capacity ?? 0).toString();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TablesBloc, TablesState>(
      listener: (context, state) {
        if (state.message.isNotEmpty) {
          showToast(state.message);
          while (context.canPop()) {
            context.pop();
          }
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            widget.isEditable ? "Edit Table" : "Table Information",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SizedBox(
            width: Utils.screenWidth(context) * 0.5,
            height: Utils.screenHeight(context) * 0.4,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      fillColor: CustomColors.offWhite,
                      filled: true,
                      enabled: widget.isEditable ? true : false,
                      labelText: 'Table Name',
                      hintText: 'Table Name',
                      prefixIcon: const Icon(Iconsax.note),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please Table Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: numberController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      fillColor: CustomColors.offWhite,
                      filled: true,
                      enabled: widget.isEditable ? true : false,
                      labelText: 'Table Number',
                      hintText: 'Table Number',
                      prefixIcon: const Icon(Icons.dining_outlined),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please Table Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: capacityController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      fillColor: CustomColors.offWhite,
                      filled: true,
                      enabled: widget.isEditable ? true : false,
                      labelText: 'Table Capacity',
                      hintText: 'Table Capacity',
                      prefixIcon: const Icon(Icons.reduce_capacity_rounded),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please Capacity';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Cancel",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                widget.isEditable
                    ? SizedBox(
                        width: 130,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            final tableModel = TableModel(
                              id: widget.model.id ?? '',
                              name: nameController.text.trim(),
                              tableNumber:
                                  int.parse(numberController.text.trim()),
                              capacity:
                                  int.parse(capacityController.text.trim()),
                            );
                            context
                                .read<TablesBloc>()
                                .add(UpdateTable(table: tableModel));
                          },
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Edit Table",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            )
          ],
        );
      },
    );
  }
}
