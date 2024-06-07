import 'package:flutter/material.dart';
import 'package:uaspm/class/class_gitar.dart';
import 'package:uaspm/service/guitar_service.dart';
import 'package:uaspm/views/forms/checkout.dart';
import 'package:uaspm/views/forms/update_product.dart';


class DetailsProductPage extends StatelessWidget {
  final Guitar guitar;
  final GuitarService _guitarService = GuitarService();

  DetailsProductPage({required this.guitar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details Guitar',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(guitar.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    guitar.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Price: \Rp.${guitar.price}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    guitar.description,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return UpdateProductForm(guitar: guitar);
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 0, 0, 0),
                          minimumSize: Size(150, 50),
                        ),
                        child: Text(
                          'Update Product',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text('Are you sure you want to delete this product?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _guitarService.deleteGuitar(guitar.noproduct).then((_) {
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Success'),
                                              content: Text('Product successfully deleted!'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      minimumSize: Size(150, 50),
                                    ),
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: Size(150, 50),
                        ),
                        child: Text(
                          'Delete Product',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    // Navigate to the checkout form
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutForm(guitar: guitar)),
    );
  },
  child: Icon(Icons.shopping_cart),
  backgroundColor: Colors.black, // Set the background color to black
),
floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}
