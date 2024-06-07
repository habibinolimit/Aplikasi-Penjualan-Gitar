import 'package:flutter/material.dart';
import 'package:uaspm/class/class_transaksi.dart';
import 'package:uaspm/service/guitar_service.dart';

class UpdateForm extends StatefulWidget {
  final TransactionData transaction;

  UpdateForm({required this.transaction});

  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController noproductController = TextEditingController();
  TextEditingController guitarNameController = TextEditingController();
  TextEditingController guitarPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set the initial values in the form fields
    nameController.text = widget.transaction.name;
    shippingAddressController.text = widget.transaction.shippingAddress;
    contactNumberController.text = widget.transaction.contactNumber;
    jenisKelaminController.text = widget.transaction.jenisKelamin;
    noproductController.text = widget.transaction.noproduct;
    guitarNameController.text = widget.transaction.guitarName;
    guitarPriceController.text = widget.transaction.guitarPrice;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Transaction'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Add form fields for each property you want to update
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: shippingAddressController,
              decoration: InputDecoration(labelText: 'Shipping Address'),
            ),
            TextFormField(
              controller: contactNumberController,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            TextFormField(
              controller: jenisKelaminController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
           TextFormField(
  controller: noproductController,
  decoration: InputDecoration(labelText: 'Product No'),
  enabled: false, // Make it read-only
),
TextFormField(
  controller: guitarNameController,
  decoration: InputDecoration(labelText: 'Product Name'),
  enabled: false, // Make it read-only
),
TextFormField(
  controller: guitarPriceController,
  decoration: InputDecoration(labelText: 'Product Price'),
  enabled: false, // Make it read-only
),

          ],
        ),
      ),
      actions: [
      ElevatedButton(
  onPressed: () async {
    await GuitarService().updateTransaction(
      TransactionData(
        name: nameController.text,
        shippingAddress: shippingAddressController.text,
        contactNumber: contactNumberController.text,
        jenisKelamin: jenisKelaminController.text,
        noproduct: noproductController.text,
        guitarName: guitarNameController.text,
        guitarPrice: guitarPriceController.text,
      ),
    );

    // Close the update form dialog
    Navigator.of(context).pop();

    // Show a pop-up dialog for a successful update
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Transaction updated successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  },
  child: Text('Update'),
),


        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
