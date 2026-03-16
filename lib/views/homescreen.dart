import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/components/product_cart.dart';
import 'package:flutter_application_1/models/product_models.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/views/cart.dart';
import 'package:flutter_application_1/views/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
TextEditingController _searchController = TextEditingController();
bool isloading = false;
String errorMessage = "";
List<Data> products = [];
ApiService apiService = ApiService();
final Set<int> cartIds = {};
String SearchQuery = "";

void initState() {
  super.initState();
  loadproducts();
}
Future loadproducts() async {
  try {
    setState(() {
      isloading = true;
    });
    ProductModels resdata = await apiService.fetchProducts();
    setState(() {
      products = resdata.data ?? [];
    });
  } catch (e) {
    setState(() {
      errorMessage = "Failed to load products";
    });
  } finally {
    setState(() {
      isloading = false;
    });
  }
}
@override
  Widget build(BuildContext context) {
    final filteredProducts = SearchQuery.isEmpty
        ? products
        : products.where((product) => product.name?.toLowerCase().contains(SearchQuery.toLowerCase()) ?? false).toList();
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discover",
                     style: TextStyle(fontSize: 24,
                     fontWeight: FontWeight.bold,
                     letterSpacing: 0.5),
                     ),
                     IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(cartProducts: products.where((product) => cartIds.contains(product.id)).toList(), cartIds: cartIds,)));
                     }, icon: const Icon(Icons.shopping_bag))
                     
                  ],
                ),
                SizedBox(height: 8,),
                Text("Explore the best products from around the world",
                style: TextStyle(fontSize: 16,
                color: Colors.grey[600],),
                ),
                SizedBox(height: 14,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search for products...",
                      hintStyle: TextStyle(color: Colors.grey[400],),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400],),
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onChanged: (value){
                    setState(() {
                      SearchQuery = value;
                    });
                  },
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage("https://www.shutterstock.com/image-vector/super-sale-promotional-banner-promo-600nw-2570295095.jpg"),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                SizedBox(height: 16,),
                if(isloading)
                  Center(child: CircularProgressIndicator(),)
                else if(errorMessage.isNotEmpty)
                  Center(child: Text(errorMessage),)
                else
                  Expanded(child: GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index){
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product, cartIds: cartIds,)));
                      },
                      child: ProductCart(
                      product: product)
                      );
                  },

                  )
                  )
            



                
              ],
              ),
        )
        )
        );
  }
}