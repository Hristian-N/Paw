import 'package:flutter/material.dart';

class PetGender extends StatefulWidget {
  final VoidCallback onSelected;
  final bool editable;
  final Function(String) onGenderChanged;

  const PetGender({
    Key? key,
    required this.onSelected,
    required this.editable,
    required this.onGenderChanged,
  }) : super(key: key);

  @override
  _PetGenderState createState() => _PetGenderState();
}

class _PetGenderState extends State<PetGender> {
  String _selectedGender = 'Male'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: _selectedGender == 'Male'
              ? Icon(Icons.male, color: Colors.blue)
              : Icon(Icons.female, color: Colors.pink),
          onPressed: widget.editable ? _showGenderMenu : null,
        ),
      ],
    );
  }

  void _showGenderMenu() {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomLeft(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<String>(
          value: 'Male',
          child: Row(
            children: [
              Icon(Icons.male, color: Colors.blue),
              SizedBox(width: 8),
              Text('Male'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Female',
          child: Row(
            children: [
              Icon(Icons.female, color: Colors.pink),
              SizedBox(width: 8),
              Text('Female'),
            ],
          ),
        ),
      ],
    ).then((String? selectedGender) {
      if (selectedGender != null) {
        setState(() {
          widget.onGenderChanged(selectedGender); // call the onGenderChanged function
          _selectedGender = selectedGender; // update the _selectedGender state
        });
      }
    });
  }
}
