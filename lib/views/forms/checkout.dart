import 'package:flutter/material.dart';
import 'package:uaspm/class/class_gitar.dart';
import 'package:uaspm/class/class_transaksi.dart';
import 'package:uaspm/service/guitar_service.dart';

class CheckoutForm extends StatefulWidget {
  final Guitar guitar;

  CheckoutForm({required this.guitar});

  @override
  _CheckoutFormState createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  String? selectedOption;
  List<String> dropdownOptions = ['Laki-Laki', 'Perempuan'];
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Details:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Name: ${widget.guitar.name}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Price: \Rp.${widget.guitar.price}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Shipping Information:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Shipping Address',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: contactNumberController,
              keyboardType: TextInputType.phone, // Set the keyboard type to phone
              decoration: InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              hint: Text('Jenis Kelamin'),
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              items: dropdownOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
        ElevatedButton(
  onPressed: () async {
    try {
      await GuitarService().addTransaction(
        TransactionData(
          name: nameController.text,
          shippingAddress: addressController.text,
          contactNumber: contactNumberController.text,
          jenisKelamin: selectedOption!,
          noproduct: widget.guitar.noproduct,
          guitarName: widget.guitar.name,
          guitarPrice: widget.guitar.price,
        ),
      );

      // If the transaction is successful, show a success popup
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Berhasil'),
            content: Text('Anda berhasil membeli produk ini. Terima kasih!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error during checkout: $error');
      // Handle the error, e.g., show an error message
    }
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.black,
  ),
  child: Text(
    'Checkout',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
),


          ],
        ),
      ),
    );
  }
}
