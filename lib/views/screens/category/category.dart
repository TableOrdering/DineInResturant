import 'package:cached_network_image/cached_network_image.dart';
import 'package:dine_in/bloc/category/category_bloc.dart';
import 'package:dine_in/core/utils/k_color_scheme.dart';
import 'package:dine_in/core/utils/responsive.dart';
import 'package:dine_in/core/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconsax/flutter_iconsax.dart';

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
                onPressed: () {},
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
            height: Utils.screenHeight(context),
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state.error.isNotEmpty) {
                  showToast(state.error);
                }
              },
              builder: (context, state) {
                final loading = state.isLoading;
                final categoryData = state.categoriesData;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(-
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: categoryData.length,
                  itemBuilder: (context, index) {
                    final data = categoryData[index];
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
                      return Card(
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
                                        borderRadius: BorderRadius.circular(8),
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
                                    onTap: () {},
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
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
                                          CategoryStatus(id: data.id ?? ''));
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
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
                      ));
                    }
                    return const Center(
                      child: Text("Something Went Wrong "),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class CustomeNetworkImage extends StatelessWidget {
  const CustomeNetworkImage({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: data,
      placeholder: (context, url) => Container(
        width: Utils.screenWidth(context) * 0.11,
        color: Colors.blueGrey,
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Iconsax.box_remove),
      ),
    );
  }
}
