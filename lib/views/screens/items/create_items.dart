import 'dart:io';

import 'package:dine_in_resturant/bloc/category/category_bloc.dart';
import 'package:dine_in_resturant/bloc/items/items_bloc.dart';
import 'package:dine_in_resturant/core/utils/k_color_scheme.dart';
import 'package:dine_in_resturant/core/utils/responsive.dart';
import 'package:dine_in_resturant/core/utils/toast.dart';
import 'package:dine_in_resturant/data/model/category/category.dart';
import 'package:dine_in_resturant/data/model/extensions_models/create_product_extension.dart';
import 'package:dine_in_resturant/views/screens/category/create_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CreateItemsPage extends StatefulWidget {
  const CreateItemsPage({super.key});

  @override
  State<CreateItemsPage> createState() => _CreateItemsPageState();
}

class _CreateItemsPageState extends State<CreateItemsPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController(text: "0");
  Availability _availability = Availability.available;
  CategoryModel? categoryId;

  File? imageFile;
  Future pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
      await cropImage();
    }
  }

  Future cropImage() async {
    if (imageFile != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop',
            cropGridColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            lockAspectRatio: true,
            hideBottomControls: true,
            showCropGrid: false,
            toolbarColor: CustomColors.primary,
          ),
          IOSUiSettings(title: 'Crop'),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 400,
              height: 400,
            ),
            viewPort: const CroppieViewPort(
              width: 300,
              height: 300,
              type: 'square',
            ),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );

      if (cropped != null) {
        setState(() {
          imageFile = File(cropped.path);
        });
      }
    }
  }

  void _clearImage() {
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoryBloc>().state.categoriesData;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Item",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: BlocConsumer<ItemsBloc, ItemsState>(
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
          return Container(
            padding: const EdgeInsets.all(16.0),
            width: Utils.screenWidth(context),
            height: Utils.screenHeight(context) * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageFile == null
                      ? GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            height: 150,
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                            child: const Text('No image picked'),
                          ),
                        )
                      : SizedBox(
                          height: 150,
                          width: 180,
                          child: Stack(
                            children: [
                              Image.file(
                                imageFile!,
                                width: 180,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    _clearImage();
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
                  ExpansionTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.black),
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.black),
                    ),
                    title: const Text("Select Category"),
                    subtitle:
                        Text("Selected Category : ${categoryId?.name ?? ''}"),
                    children: [
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = categories[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  categoryId = data;
                                });
                              },
                              child: ListTile(
                                leading: Text("${index + 1}"),
                                title: Text(data.name ?? ''),
                                subtitle: Text(
                                  data.isAvailable == true
                                      ? "Available"
                                      : "NotAvailable",
                                ),
                                trailing: Text(data.foodType ?? ''),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _priceController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: 'Enter Price'),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _discountController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        labelText: 'Enter Discount If Any'),
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
                              child:
                                  Text(availability.toString().split('.').last),
                            ))
                        .toList(),
                    decoration: const InputDecoration(
                      labelText: 'Availability',
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
                            final model = CreateItemExtension(
                              name: _nameController.text.trim(),
                              description: _descriptionController.text.trim(),
                              isAvailable:
                                  _availability == Availability.available
                                      ? true
                                      : false,
                              productImage: imageFile!,
                              category: categoryId?.id ?? '',
                              discount:
                                  int.parse(_discountController.text.trim()),
                              price: int.parse(_priceController.text.trim()),
                            );
                            context
                                .read<ItemsBloc>()
                                .add(CreateProduct(model: model));
                          },
                          child: const Text(
                            "Create Product",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
