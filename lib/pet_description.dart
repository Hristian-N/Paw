import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final String description;
  final bool editable;
  final Function(String) onDescriptionChanged;

  const DescriptionWidget({
    Key? key,
    required this.description,
    required this.editable,
    required this.onDescriptionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            editable
                ? Container(
              width: 500, // Adjust width as needed
              child: TextFormField(
                initialValue: description,
                onChanged: onDescriptionChanged,
                maxLines: null,
              ),
            )
                : Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
