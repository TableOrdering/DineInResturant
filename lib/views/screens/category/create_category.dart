import 'dart:io';

import 'package:flutter/material.dart';
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
  File? _pickedImage;
  Availability _availability = Availability.available;
  FoodType _foodType = FoodType.veg;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16.0),
            _pickedImage == null
                ? TextButton(
                    onPressed: _pickImage,
                    child: const Text('No image picked'),
                  )
                : Image.file(
                    _pickedImage!,
                    height: 150,
                    width: 150,
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
                        child: Text(availability.toString().split('.').last),
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
                        child: Text(availability.toString().split('.').last),
                      ))
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'FoodType',
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
