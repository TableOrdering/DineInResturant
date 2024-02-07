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

class CustomCreatingTableDialogue extends StatefulWidget {
  const CustomCreatingTableDialogue({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<CustomCreatingTableDialogue> createState() =>
      _CustomCreatingTableDialogueState();
}

class _CustomCreatingTableDialogueState
    extends State<CustomCreatingTableDialogue> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final capacityController = TextEditingController();

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
          title: const Text(
            "Add Table",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: SizedBox(
            width: Utils.screenWidth(context),
            height: Utils.screenHeight(context) * 0.4,
            child: Form(
              key: widget._formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16)),
                      fillColor: CustomColors.offWhite,
                      filled: true,
                      hintText: 'Table Name',
                      prefixIcon: const Icon(Iconsax.note),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
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
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16)),
                      fillColor: CustomColors.offWhite,
                      filled: true,
                      hintText: 'Table Number',
                      prefixIcon: const Icon(Icons.dining_outlined),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
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
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16)),
                      fillColor: CustomColors.offWhite,
                      filled: true,
                      hintText: 'Table Capacity',
                      prefixIcon: const Icon(Icons.reduce_capacity_rounded),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
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
                SizedBox(
                  width: 110,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      final tableModel = TableModel(
                        name: nameController.text.trim(),
                        tableNumber: int.parse(numberController.text.trim()),
                        capacity: int.parse(capacityController.text.trim()),
                      );
                      context
                          .read<TablesBloc>()
                          .add(CreateTable(table: tableModel));
                    },
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Add Table",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
