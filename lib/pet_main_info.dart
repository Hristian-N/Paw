import 'package:flutter/material.dart';
import 'pet_gender.dart';

class PetMainInfo extends StatefulWidget {
  final String name;
  final String breed;
  final bool editable;
  final Function(String) onNameChanged;
  final Function(String) onBreedChanged;
  final Function(String) onGenderChanged;

  const PetMainInfo({
    Key? key,
    required this.name,
    required this.breed,
    required this.editable,
    required this.onNameChanged,
    required this.onBreedChanged,
    required this.onGenderChanged,
  }) : super(key: key);

  @override
  _PetMainInfoState createState() => _PetMainInfoState();
}

class _PetMainInfoState extends State<PetMainInfo> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.editable ? _buildEditableContent() : _buildNonEditableContent();
  }

  Widget _buildEditableContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 250,
          child: TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            onChanged: widget.onNameChanged,
          ),
        ),
        Container(
          width: 250,
          child: TextFormField(
            initialValue: widget.breed,
            decoration: InputDecoration(
              labelText: 'Breed',
            ),
            onChanged: widget.onBreedChanged,
          ),
        ),
        SizedBox(height: 20),
        PetGender(onGenderChanged: widget.onGenderChanged, onSelected: () {  }, editable: widget.editable,),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildNonEditableContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${widget.name}',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${widget.breed}',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(width: 8),
            PetGender(onGenderChanged: widget.onGenderChanged, onSelected: () {  }, editable: widget.editable,),
          ],
        )
      ],
    );
  }
}
