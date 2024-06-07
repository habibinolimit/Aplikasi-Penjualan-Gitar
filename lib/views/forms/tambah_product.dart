import 'package:flutter/material.dart';
import 'package:uaspm/class/class_gitar.dart';
import 'package:uaspm/service/guitar_service.dart';

class AddGuitarForm extends StatefulWidget {
  @override
  _AddGuitarFormState createState() => _AddGuitarFormState();
}

class _AddGuitarFormState extends State<AddGuitarForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noproductController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  final GuitarService _guitarService = GuitarService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  title: Text(
    'Add Guitar',
    style: TextStyle(
      color: Colors.white, // Set text color to black
      fontWeight: FontWeight.bold, // Make text bold
      fontSize: 24, // Set font size
    ),
  ),
  backgroundColor: Colors.black, // Set background color to white
  elevation: 0, // Remove the shadow
),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
    TextFormField(
      controller: _noproductController,
      decoration: InputDecoration(labelText: 'No Product'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a No Product';
        }
        return null;
      },
    ),
    TextFormField(
      controller: _nameController,
      decoration: InputDecoration(labelText: 'Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
    ),
    TextFormField(
      controller: _priceController,
      decoration: InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a price';
        }
        return null;
      },
    ),
    TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(labelText: 'Description'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    ),
    TextFormField(
      controller: _imageUrlController,
      decoration: InputDecoration(labelText: 'Image URL'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an image URL';
        }
        return null;
      },
    ),
    SizedBox(height: 16),
    ElevatedButton(
      onPressed: () {
        _addGuitar();
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.black, // Background color
        onPrimary: Colors.white, // Text color
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Button border radius
        ),
        elevation: 5, // Elevation
      ),
      child: Text(
        'Add Guitar',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
          ),
        ),
      ),
    );
  }

  void _addGuitar() {
    if (_formKey.currentState!.validate()) {
      final guitar = Guitar(
        noproduct: _noproductController.text,
        name: _nameController.text,
        price: _priceController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
      );

      _guitarService.addGuitar(guitar).then((_) {
        // Tutup form setelah menambahkan gitar
        Navigator.pop(context);

        // Tampilkan popup berhasil ditambahkan atau sesuaikan dengan kebutuhan Anda
        _showSuccessDialog();
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Product successfully added!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup pop-up
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
