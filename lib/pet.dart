import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet/pet_description.dart';
import 'package:pet/pet_image.dart';
import 'package:pet/pet_main_info.dart';
import 'package:pet/pet_secondary_info.dart';
import 'package:pet/save_buttons.dart';

import 'action_buttons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Pet()),
      ),
    );
  }
}

class Pet extends StatefulWidget {
  @override
  _PetState createState() => _PetState();
}

class _PetState extends State<Pet> {
  late final bool editable = true;
  late String id = 'P004';
  late String image;
  late String name = '';
  late String age = '';
  late String breed = '';
  late String description = '';
  late String gender = '';
  late String height = '';
  late String phoneNumber = '';
  late String weight = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPetData();
  }

  void onImageChanged(String newImage) {
    setState(() {
      image = newImage;
    });
  }

  void onNameChanged(String newName) {
    setState(() {
      name = newName;
    });
  }

  void onBreedChanged(String newBreed) {
    setState(() {
      breed = newBreed;
    });
  }

  void onGenderChanged(String newGender) {
    setState(() {
      gender = newGender;
    });
  }

  void onAgeChanged(String newAge) {
    setState(() {
      age = newAge;
    });
  }

  void onWeightChanged(String newWeight) {
    setState(() {
      weight = newWeight;
    });
  }

  void onHeightChanged(String newHeight) {
    setState(() {
      height = newHeight;
    });
  }

  void onDescriptionChanged(String newDescription) {
    setState(() {
      description = newDescription;
    });
  }

  Future<void> fetchPetData() async {
    final response = await http.get(Uri.parse('https://api.wonderfulmemories.org/getpet?id=$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        image = data['imageUrl'] ?? 'https://demofree.sirv.com/products/123456/123456.jpg?profile=error-example';
        name = data['Name'] ?? 'error';
        age = data['Age'] != null ? data['Height'].toString() : 'error';; // Safely handle possible non-int values
        breed = data['Breed'] ?? 'error';
        description = data['Description'] ?? 'error';
        gender = data['Gender'] ?? 'error';
        height = data['Height'] != null ? data['Height'].toString() : 'error'; // Handle as string
        phoneNumber = data['PhoneNumber'] ?? 'error';
        weight = data['Weight'] != null ? data['Weight'].toString() : 'error'; // Handle as string
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load pet data');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading indicator while data is being fetched
      return Center(child: CircularProgressIndicator());
    } else {
      return CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                PetImage(
                  editable: editable,
                  onImageChanged: onImageChanged,
                  image: image,
                ),
                SizedBox(height: 20),
                PetMainInfo(
                  name: name,
                  breed: breed,
                  editable: editable,
                  onNameChanged: onNameChanged,
                  onBreedChanged: onBreedChanged,
                  onGenderChanged: onGenderChanged,
                ),
                SizedBox(height: 20),
                ActionButtons(editable: editable, phoneNumber: phoneNumber),
                SizedBox(height: 40),
                PetSecondaryInfo(
                  age: age.toString(),
                  weight: weight.toString(),
                  height: height.toString(),
                  onAgeChanged: onAgeChanged,
                  onWeightChanged: onWeightChanged,
                  onHeightChanged: onHeightChanged,
                  editable: editable,
                ),
                DescriptionWidget(
                  description: description,
                  editable: editable,
                  onDescriptionChanged: onDescriptionChanged,
                ),
                SaveButton(
                  id: id,
                  image: image,
                  name: name,
                  breed: breed,
                  gender: gender,
                  phoneNumber: phoneNumber,
                  age: age,
                  weight: weight,
                  height: height,
                  description: description,
                  onPressed: () {
                    print('Save button pressed!');
                  },
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
