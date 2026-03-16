import 'package:flutter_application_1/models/product_models.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class ApiService {

  Future<ProductModels> fetchProducts() async {
    
      final response = await http.get(Uri.parse("https://www.wantapi.com/products.php"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProductModels.fromJson(data);
      }
       else {
        throw Exception("Failed to load products");
       
  }
}
}