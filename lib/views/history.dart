import 'package:flutter/material.dart';
import 'package:uaspm/class/class_transaksi.dart';
import 'package:uaspm/service/guitar_service.dart';
import 'package:uaspm/views/forms/update_transaksi.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<TransactionData>> _transactions;
  
  @override
  void initState() {
    super.initState();
    _transactions = GuitarService().getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
    'Transactions History',
    style: TextStyle(
      color: Colors.white, // Set text color to black
      fontWeight: FontWeight.bold, // Make text bold
      fontSize: 24, // Set font size
    ),
  ),
  backgroundColor: Colors.black, // Set background color to white
  elevation: 0, // Remove the shadow
),
      body: FutureBuilder<List<TransactionData>>(
        future: _transactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No transactions available.'));
          } else {
            return _buildDataTable(snapshot.data!);
          }
        },
      ),
    );
  }
Widget _buildDataTable(List<TransactionData> transactions) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columns: [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Shipping Address')),
        DataColumn(label: Text('Contact Number')),
        DataColumn(label: Text('Gender')),
        DataColumn(label: Text('Product No')),
        DataColumn(label: Text('Product Name')),
        DataColumn(label: Text('Product Price')),
        DataColumn(label: Text('Actions')), // Add an extra column for actions
      ],
      rows: transactions.map((transaction) {
        return DataRow(
          cells: [
            DataCell(Text(transaction.name)),
            DataCell(Text(transaction.shippingAddress)),
            DataCell(Text(transaction.contactNumber)),
            DataCell(Text(transaction.jenisKelamin)),
            DataCell(Text(transaction.noproduct)),
            DataCell(Text(transaction.guitarName)),
            DataCell(Text(transaction.guitarPrice)),
            DataCell(
              Row(
                children: [
                   IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          // Show the update form when the edit button is pressed
          showDialog(
            context: context,
            builder: (context) => UpdateForm(transaction: transaction),
          );
        },
      ),
            IconButton(
  icon: Icon(Icons.delete),
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this transaction?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog
              },
              child: Text('Cancel'),
            ),
          ElevatedButton(
  onPressed: () async {
    // Assuming transaction is an instance of TransactionData
    await GuitarService().deleteTransaction(transaction.name);
    Navigator.of(context).pop(); // Close the confirmation dialog

    // Show a success message (SnackBar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Transaction successfully deleted'),
      ),
    );
  },
  child: Text('Delete'),
),

          ],
        );
      },
    );
  },
),


                ],
              ),
            ),
          ],
        );
      }).toList(),
    ),
  );
}



}

void main() {
  runApp(MaterialApp(
    home: HistoryPage(),
  ));
}
