import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class ActionButtons extends StatelessWidget {
  final bool editable;
  final String phoneNumber;

  const ActionButtons({
    Key? key,
    required this.editable,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return editable ? Editable() : NonEditable();
  }

  Widget NonEditable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedIconButton(
          iconData: Icons.local_phone,
          onPressed: () {
            _launchPhone("359 871 234");
          },
          color: Colors.blue,
        ),
        RoundedIconButton(
          iconData: Icons.share,
          onPressed: () {
            _openShareMenu("Share pet"); // Replace the message with your content to share
          },
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget Editable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20), // Adjust the value as needed
            child: TextFormField(
              initialValue: phoneNumber.toString(),
              decoration: InputDecoration(
                labelText: "Phone Number",
              ),
              // onChanged: onChanged
            ),
          ),
        )
      ],
    );
  }

  void _launchPhone(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openShareMenu(String text) {
    Share.share(text);
  }

  void _editContent() {
    // Implement your edit functionality here
  }

  void _deleteContent() {
    // Implement your delete functionality here
  }
}

class RoundedIconButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final VoidCallback onPressed;

  const RoundedIconButton({
    Key? key,
    required this.iconData,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(iconData),
        color: Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}
