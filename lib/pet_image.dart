import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PetImage extends StatefulWidget {
  final bool editable;
  final Function(String) onImageChanged;
  final String image; // Add this line to accept image data from the backend

  const PetImage({
    Key? key,
    required this.editable,
    required this.onImageChanged,
    required this.image, // Add this line
  }) : super(key: key);

  @override
  _PetImageState createState() => _PetImageState();
}

class _PetImageState extends State<PetImage> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _downloadAndSetImage(widget.image);
  }

  Future<void> _downloadAndSetImage(String imageUrl) async {
    if (imageUrl.isNotEmpty) {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/downloadedImage.png';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          _imageFile = file;
        });
      } else {
        // Handle errors or set up a fallback image
      }
    }
  }

  Future<void> _pickImage() async {
    if (!widget.editable) return;

    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        _imageFile = imageFile;
      });
      widget.onImageChanged(base64Image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: _imageFile != null
            ? Stack(
          children: [
            ClipPath(
              clipper: BottomArcClipper(),
              child: Image.file(
                _imageFile!,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 0.9),
                    end: Alignment(0, 0.4),
                    colors: [
                      Colors.white.withOpacity(1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
            : const Column(
          children: [
            SizedBox(height: 70),
            Icon(
              Icons.image_not_supported,
              size: 48.0,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40); // Start at the bottom-left corner
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 40); // Create an arc at the bottom
    path.lineTo(size.width, 0); // Finish at the bottom-right corner
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}