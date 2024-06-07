import 'package:flutter/material.dart';
import 'package:uaspm/class/class_gitar.dart';
import 'package:uaspm/service/guitar_service.dart';

class UpdateProductForm extends StatefulWidget {
  final Guitar guitar;

  UpdateProductForm({required this.guitar});

  @override
  _UpdateProductFormState createState() => _UpdateProductFormState();
}

class _UpdateProductFormState extends State<UpdateProductForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
    late final GuitarService _guitarService; // Tambahkan deklarasi ini
  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data produk yang akan di-update
     _guitarService = GuitarService(); // Inisialisasi _guitarService di initState
    _nameController.text = widget.guitar.name;
    _priceController.text = widget.guitar.price;
    _descriptionController.text = widget.guitar.description;
    _imageUrlController.text = widget.guitar.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Product'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
          ],
        ),
      ),
      actions: [
       ElevatedButton(
  onPressed: () {
    final updatedGuitar = Guitar(
      noproduct: widget.guitar.noproduct,
      name: _nameController.text,
      price: _priceController.text,
      description: _descriptionController.text,
      imageUrl: _imageUrlController.text,
    );

    _guitarService.updateGuitar(updatedGuitar).then((_) {
      // Menampilkan dialog pemberitahuan jika pembaruan sukses
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Product Updated'),
            content: Text('The product has been updated successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Tutup pop-up update
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  },
  child: Text('Update'),
),

        TextButton(
          onPressed: () {
            Navigator.pop(context); // Tutup pop-up
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
