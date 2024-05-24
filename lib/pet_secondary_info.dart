import 'package:flutter/material.dart';

class PetSecondaryInfo extends StatelessWidget {
  final String age;
  final String weight;
  final String height;
  final bool editable;
  final Function(String) onAgeChanged;
  final Function(String) onWeightChanged;
  final Function(String) onHeightChanged;

  const PetSecondaryInfo({
    Key? key,
    required this.age,
    required this.weight,
    required this.height,
    required this.editable,
    required this.onAgeChanged,
    required this.onWeightChanged,
    required this.onHeightChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          editable ?
          Editable(label: 'Age (years)', value: age, onChanged: onAgeChanged)
              :
          NonEditable(label: 'Age', value: age),
          VerticalDivider(),
          editable ?
          Editable(label: 'Weight (kg)', value: weight, onChanged: onWeightChanged)
              :
          NonEditable(label: 'Weight:', value: weight),
          VerticalDivider(),
          editable ?
          Editable(label: 'Height (cm)', value: height, onChanged: onHeightChanged)
              :
          NonEditable(label: 'Height:', value: height),
        ],
      ),
    );
  }
}

class NonEditable extends StatelessWidget {
  final String label;
  final String value;

  const NonEditable({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class Editable extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onChanged;

  const Editable({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100, // Adjust width as needed
          child: TextFormField(
              initialValue: value,
              decoration: InputDecoration(
                labelText: label,
              ),
              onChanged: onChanged
          ),
        )
      ],
    );
  }
}
