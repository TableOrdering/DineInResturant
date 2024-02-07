import 'package:dine_in_resturant/bloc/category/category_bloc.dart';
import 'package:dine_in_resturant/core/routes/routes.dart';
import 'package:dine_in_resturant/core/utils/k_color_scheme.dart';
import 'package:dine_in_resturant/core/utils/responsive.dart';
import 'package:dine_in_resturant/core/utils/toast.dart';
import 'package:dine_in_resturant/views/widgets/custome_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconsax/flutter_iconsax.dart';
import 'package:go_router/go_router.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Categories",
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
                  context.pushNamed(kCreateCategoryRoute);
                },
                label: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Add Category",
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
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state.error.isNotEmpty) {
                  showToast(state.error);
                }
              },
              builder: (context, state) {
                final loading = state.isLoading;
                final categoryData = state.categoriesData;
                if (loading) {
                  return SizedBox(
                    width: Utils.screenWidth(context),
                    height: Utils.screenHeight(context),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state.categoriesData.isEmpty) {
                  return SizedBox(
                    width: Utils.screenWidth(context),
                    height: Utils.screenHeight(context),
                    child: const Center(
                      child: Text("No Categories Found"),
                    ),
                  );
                } else if (state.categoriesData.isNotEmpty) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: categoryData.length,
                    itemBuilder: (context, index) {
                      final data = categoryData[index];

                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  content: SizedBox(
                                    height: Utils.screenHeight(context) * 0.5,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: SizedBox(
                                              width: 250,
                                              height: 200,
                                              child: CustomeNetworkImage(
                                                fill: true,
                                                data: data.categoryImage ?? '',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Name : ${data.name ?? ''}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Description : ${data.description ?? ''}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Food Type : ${data.foodType ?? ''}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
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
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: Utils.screenWidth(context) * 0.11,
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CustomeNetworkImage(
                                    data: data.categoryImage ?? '',
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    "Name : ${data.name ?? ''}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Food Type : ${data.foodType ?? ''}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
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
                                          context
                                              .read<CategoryBloc>()
                                              .add(DeleteCategory(
                                                id: data.id ?? '',
                                              ));
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
                                          context.read<CategoryBloc>().add(
                                              CategoryStatus(
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
          )
        ],
      ),
    );
  }
}
