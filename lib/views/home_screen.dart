import 'package:flutter/material.dart';
import 'package:uaspm/class/class_gitar.dart';
import 'package:uaspm/service/guitar_service.dart';
import 'package:uaspm/views/detail_product.dart';
import 'package:uaspm/views/forms/tambah_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GuitarService _guitarService = GuitarService();
  late Future<List<Guitar>> _guitars;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _guitars = _guitarService.getGuitars();
  }

  Future<void> _searchGuitars(String keyword) async {
    setState(() {
      _guitars = _guitarService.searchGuitars(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Guitar List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Guitars',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchGuitars(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Guitar>>(
              future: _guitars,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Guitar> guitars = snapshot.data!;
                  if (guitars.isEmpty) {
                    return Center(child: Text('No guitars available.'));
                  }
                  return ListView.builder(
                    itemCount: guitars.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        guitars[index].name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Price: \Rp.${guitars[index].price}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    guitars[index].imageUrl,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 120,
                                        height: 120,
                                        color: Colors.grey[300],
                                        child: Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsProductPage(guitar: guitars[index]),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 0, 0, 0),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                'See Details',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddGuitarForm()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        elevation: 3,
      ),
    );
  }
}
