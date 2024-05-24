import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SaveButton extends StatefulWidget {
  final Function()? onPressed;
  final String id;
  final String image;
  final String name;
  final String breed;
  final String gender;
  final String phoneNumber;
  final String age;
  final String weight;
  final String height;
  final String description;

  SaveButton({Key? key,
    this.onPressed,
    required this.id,
    required this.name,
    required this.image,
    required this.breed,
    required this.gender,
    required this.phoneNumber,
    required this.age,
    required this.weight,
    required this.height,
    required this.description
  }) : super(key: key);

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 100.0), // Adjust the padding as needed
      child: ElevatedButton(
        onPressed: _saving ? null : _saveData,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        child: _saving ? CircularProgressIndicator() : Text('Save'),
      ),
    );
  }

  Future<void> _saveData() async {
    setState(() {
      _saving = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.wonderfulmemories.org/setpet'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'PetID': widget.id,
          'Name': widget.name,
          'Breed': widget.breed,
          'PhoneNumber': widget.phoneNumber,
          'Gender': widget.gender,
          'Age': int.parse(widget.age), // Parse and then convert to string
          'Weight': int.parse(widget.weight),
          'Height': int.parse(widget.height),
          'image': widget.image,
          'Description': widget.description
        }),

      );

      if (response.statusCode == 200) {
        print('Data saved');
        print(widget.image);
      } else {
        print('Failed to save data: ${response.statusCode} ${response.body}');
      }
    } catch (error) {
      print('Error saving data: $error');
      print(widget.image);
    }

    setState(() {
      _saving = false;
    });

    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }
}
