import 'package:dio/dio.dart';
import 'package:uaspm/class/class_gitar.dart';
import 'package:uaspm/class/class_transaksi.dart';

class GuitarService {
  Dio _dio = Dio();

 Future<List<Guitar>> getGuitars() async {
  try {
    final response = await _dio.get('http://192.168.1.13/UasPmPHP/read_product.php');

    if (response.statusCode == 200) {
    List<dynamic> responseData = response.data;
if (responseData is List) {
  return responseData.map((json) => Guitar.fromJson(json)).toList();
} else {
  throw Exception('Failed to load guitars - Invalid response format');
}


    } else {
      throw Exception('Failed to load guitars - Server responded with status code ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Failed to load guitars - $error');
  }
}



  Future<void> addGuitar(Guitar guitar) async {
   try {
  await _dio.post(
    'http://192.168.1.13/UasPmPHP/add_product.php',
    data: guitar.toJson(),
  );
} catch (error) {
  print('Error adding guitar: $error');
}


  }

 Future<void> updateGuitar(Guitar guitar) async {
  try {
    await _dio.post(
      'http://192.168.1.13/UasPmPHP/update_product.php',
      data: {
        "noproduct": guitar.noproduct, // Sertakan noproduct sebagai identifikasi produk yang akan di-update
        "name": guitar.name,
        "price": guitar.price,
        "description": guitar.description,
        "imageUrl": guitar.imageUrl,
      },
    );
  } catch (error) {
    print('Error updating guitar: $error');
  }
}

Future<void> deleteGuitar(String noproduct) async {
  try {
    await _dio.post(
      'http://192.168.1.13/UasPmPHP/delete_product.php',
      data: {'noproduct': noproduct},
    );
  } catch (error) {
    print('Error deleting guitar: $error');
  }
}

Future<void> addTransaction(TransactionData transaction) async {
  try {
    Response response = await _dio.post(
      'http://192.168.1.13/UasPmPHP/checkout.php',
      data: transaction.toJson(),
    );

    print(response.data); // Print the full response

  } catch (error) {
    print('Error adding transaction: $error');
  }
}

Future<List<TransactionData>> getTransactions() async {
  try {
    Response response = await _dio.get(
      'http://192.168.1.13/UasPmPHP/get_transactions.php',
    );

    List<dynamic> responseData = response.data;

    if (responseData is List) {
      return responseData.map((json) => TransactionData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transactions - Invalid response format');
    }
  } catch (error) {
    print('Error getting transactions: $error');
    throw Exception('Failed to load transactions - $error');
  }
}

Future<void> updateTransaction(TransactionData transaction) async {
    try {
      await _dio.post(
        'http://192.168.1.13/UasPmPHP/update_transaction.php',
        data: transaction.toJson(),
      );
    } catch (error) {
      print('Error updating transaction: $error');
    }
  }

 Future<void> deleteTransaction(String name) async {
  try {
    await _dio.post(
      'http://192.168.1.13/UasPmPHP/delete_transaction.php',
      data: {'name': name},
    );
  } catch (error) {
    print('Error deleting transaction: $error');
    // Handle the error as needed
  }
}

Future<List<Guitar>> searchGuitars(String keyword) async {
  try {
    final Response response = await _dio.get(
      'http://192.168.1.13/UasPmPHP/search.php',
      queryParameters: {'keyword': keyword},
    );

    return (response.data as List)
        .map((json) => Guitar.fromJson(json))
        .toList();
  } catch (error) {
    print('Error searching guitars: $error');
    throw error;
  }
}


  // Tambahkan fungsi update, delete, dan search sesuai kebutuhan
}


