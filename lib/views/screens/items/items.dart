import 'package:dine_in_resturant/bloc/items/items_bloc.dart';
import 'package:dine_in_resturant/core/routes/routes.dart';
import 'package:dine_in_resturant/core/utils/k_color_scheme.dart';
import 'package:dine_in_resturant/core/utils/responsive.dart';
import 'package:dine_in_resturant/core/utils/toast.dart';
import 'package:dine_in_resturant/views/widgets/custome_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconsax/flutter_iconsax.dart';
import 'package:go_router/go_router.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  void initState() {
    context.read<ItemsBloc>().add(const GetAllProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Items",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  context.pushNamed(kCreateItemsRoute);
                },
                label: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Add Items",
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
            child: BlocConsumer<ItemsBloc, ItemsState>(
              listener: (context, state) {
                if (state.error.isNotEmpty) {
                  showToast(state.error);
                }
              },
              builder: (context, state) {
                final loading = state.isLoading;
                final subCategoryData = state.subCategoryData;
                if (loading && state.subCategoryData.isEmpty) {
                  return SizedBox(
                    width: Utils.screenWidth(context),
                    height: Utils.screenHeight(context),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (!loading && state.subCategoryData.isEmpty) {
                  return SizedBox(
                    width: Utils.screenWidth(context),
                    height: Utils.screenHeight(context),
                    child: const Center(
                      child: Text("No subCategory Found"),
                    ),
                  );
                } else if (state.subCategoryData.isNotEmpty) {
                  return ListView.builder(
                    itemCount: subCategoryData.length,
                    itemBuilder: (context, index) {
                      final data = subCategoryData[index];
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  content: SizedBox(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: SizedBox(
                                                height: 140,
                                                child: CustomeNetworkImage(
                                                  fill: true,
                                                  data: data.productImage ?? '',
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Category : ${data.category?.name ?? ''}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Category Description : ${data.category?.description ?? ''}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Food Type : ${data.category?.foodType ?? ''}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Item Name : ${data.name ?? ''}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Item Description : ${data.description ?? ''}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text.rich(
                                            TextSpan(children: [
                                              const TextSpan(
                                                text: "Item Availability : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    " ${data.isAvailable ?? false ? "Available" : "Not Available"}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color:
                                                      data.isAvailable ?? false
                                                          ? Colors.green
                                                          : Colors.red,
                                                ),
                                              ),
                                            ]),
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                              child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                height: Utils.screenWidth(context) * 0.35,
                                width: Utils.screenWidth(context) * 0.4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CustomeNetworkImage(
                                    data: data.productImage ?? '',
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Utils.screenWidth(context) * 0.4,
                                    child: Text(
                                      "Name : ${data.name ?? ''}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Utils.screenWidth(context) * 0.4,
                                    child: Text(
                                      "Category : ${data.category?.name ?? ''}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      "Price : ${data.price ?? ''}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Text(
                                      "Discount : ${data.discount ?? ''}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      const TextSpan(
                                        text: "Availability : ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            " ${data.isAvailable ?? false ? "Available" : "Not Available"}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: data.isAvailable ?? false
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: CustomColors.primary,
                                          ),
                                          child: const Icon(
                                            Iconsax.edit4,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: () {
                                          context.read<ItemsBloc>().add(
                                              DeleteProduct(id: data.id ?? ''));
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: CustomColors.primary,
                                          ),
                                          child: const Icon(
                                            Icons.delete_outline_rounded,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      /// Update The Status Of the Category
                                      InkWell(
                                        onTap: () {
                                          context.read<ItemsBloc>().add(
                                              UpdateProductStatus(
                                                  id: data.id ?? ''));
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: CustomColors.primary,
                                          ),
                                          child: const Icon(
                                            Icons.event_available,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
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
          )
        ],
      ),
    );
  }
}
