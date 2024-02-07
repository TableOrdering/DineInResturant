import 'package:dine_in_resturant/bloc/tables/tables_bloc.dart';
import 'package:dine_in_resturant/core/utils/k_color_scheme.dart';
import 'package:dine_in_resturant/core/utils/responsive.dart';
import 'package:dine_in_resturant/core/utils/toast.dart';
import 'package:dine_in_resturant/views/widgets/table_widgets/custome_create_table.dart';
import 'package:dine_in_resturant/views/widgets/table_widgets/custome_edit_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconsax/flutter_iconsax.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({super.key});

  @override
  State<TablesPage> createState() => TablesPageState();
}

class TablesPageState extends State<TablesPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<TablesBloc>().add(const GetAllTables());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tables",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
              width: 170,
              height: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        CustomCreatingTableDialogue(formKey: _formKey),
                  );
                },
                label: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Add New Table",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                icon: const Icon(
                  Iconsax.add_square,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            width: Utils.screenWidth(context),
            height: Utils.screenHeight(context) * 0.9,
            child: BlocConsumer<TablesBloc, TablesState>(
              listener: (context, state) {
                if (state.error.isNotEmpty) {
                  showToast(state.error);
                }
              },
              builder: (context, state) {
                final loading = state.isLoading;
                final tablesData = state.tablesdata;
                if (loading && tablesData.isEmpty) {
                  return SizedBox(
                    width: Utils.screenWidth(context),
                    height: Utils.screenHeight(context),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (!loading && tablesData.isEmpty) {
                  return SizedBox(
                    width: Utils.screenWidth(context),
                    height: Utils.screenHeight(context),
                    child: const Center(
                      child: Text("No Tables Found"),
                    ),
                  );
                } else if (tablesData.isNotEmpty) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 335,
                      mainAxisExtent: 150,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemCount: tablesData.length,
                    itemBuilder: (context, index) {
                      final data = tablesData[index];
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomeEditingTableDialogue(
                              isEditable: false,
                              model: data,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            image: DecorationImage(
                              image: AssetImage("assets/tableBackground.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                  leading: Text(
                                    "0${data.tableNumber ?? 0}",
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.offWhite),
                                  ),
                                  trailing: InkWell(
                                    onTap: () {
                                      context
                                          .read<TablesBloc>()
                                          .add(TableStatus(id: data.id ?? ''));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      width: 70,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: CustomColors.offWhite,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          data.status ?? false
                                              ? "Free"
                                              : "Busy",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: data.status ?? false
                                                    ? Colors.green
                                                    : CustomColors.primary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                  )),
                              ListTile(
                                leading: const Icon(
                                  Iconsax.profile_2user5,
                                  color: CustomColors.offWhite,
                                ),
                                title: Text(
                                  data.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: CustomColors.offWhite),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("View QrCode"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 300,
                                                  height: 300,
                                                  child: QrImageView(
                                                    data: data.qrCodeData ?? '',
                                                    version: QrVersions.auto,
                                                    size: 200.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Iconsax.scan_barcode5,
                                        color: CustomColors.offWhite,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CustomeEditingTableDialogue(
                                              isEditable: true,
                                              model: data,
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: CustomColors.offWhite,
                                        )),
                                    const SizedBox(width: 5),
                                    InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Confirm Deletion'),
                                                content: Text(
                                                    'Are you sure you want to delete the table:- (${data.tableNumber ?? 0})'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      context.pop();
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<TablesBloc>()
                                                          .add(DeleteTable(
                                                            id: data.id ?? '',
                                                          ));
                                                      context.pop();
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Icon(
                                          Icons.delete_outline_rounded,
                                          color: CustomColors.offWhite,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text("Something Went Wrong "),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
