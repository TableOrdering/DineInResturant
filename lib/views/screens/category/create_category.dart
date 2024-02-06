import 'dart:typed_data';

import 'package:dine_in/bloc/category/category_bloc.dart';
import 'package:dine_in/core/utils/responsive.dart';
import 'package:dine_in/core/utils/toast.dart';
import 'package:dine_in/data/model/extensions_models/create_category_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

enum Availability { available, unavailable }

enum FoodType { veg, nonVeg }

class CreateCategoryPage extends StatefulWidget {
  const CreateCategoryPage({super.key});

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Availability _availability = Availability.available;
  FoodType _foodType = FoodType.veg;
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageBytes = await pickedImage.readAsBytes();
      setState(() {
        _imageBytes = Uint8List.fromList(imageBytes);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create category",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state.error.isNotEmpty) {
            showToast(state.error);
          } else if (state.message.isNotEmpty) {
            showToast(state.message);
            while (context.canPop()) {
              context.pop();
            }
          }
        },
        builder: (context, state) {
          return SizedBox(
            width: Utils.screenWidth(context),
            height: Utils.screenHeight(context) * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _imageBytes == null
                        ? GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 150,
                              width: 150,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black),
                              ),
                              child: const Text('No image picked'),
                            ),
                          )
                        : SizedBox(
                            height: 150,
                            width: 150,
                            child: Stack(
                              children: [
                                Image.memory(
                                  _imageBytes!,
                                  width: 150,
                                  height: 150,
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _imageBytes = null;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: Utils.screenWidth(context),
                      height: 100,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        controller: _descriptionController,
                        expands: true,
                        minLines: null,
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<Availability>(
                      value: _availability,
                      onChanged: (Availability? value) {
                        if (value != null) {
                          setState(() {
                            _availability = value;
                          });
                        }
                      },
                      items: Availability.values
                          .map((Availability availability) =>
                              DropdownMenuItem<Availability>(
                                value: availability,
                                child: Text(
                                    availability.toString().split('.').last),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Availability',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<FoodType>(
                      value: _foodType,
                      onChanged: (FoodType? value) {
                        if (value != null) {
                          setState(() {
                            _foodType = value;
                          });
                        }
                      },
                      items: FoodType.values
                          .map((FoodType availability) =>
                              DropdownMenuItem<FoodType>(
                                value: availability,
                                child: Text(
                                    availability.toString().split('.').last),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'FoodType',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    state.isLoading
                        ? const SizedBox(
                            width: 50,
                            height: 40,
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              final model = CreateCategoryExtension(
                                name: _nameController.text.trim(),
                                description: _descriptionController.text.trim(),
                                foodType: _foodType == FoodType.veg
                                    ? "veg"
                                    : "non-veg",
                                isAvailable:
                                    _availability == Availability.available
                                        ? true
                                        : false,
                                image: _imageBytes!,
                              );
                              context
                                  .read<CategoryBloc>()
                                  .add(CreateCategory(model: model));
                            },
                            child: const Text(
                              "Create Category",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
