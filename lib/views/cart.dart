import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_models.dart';

class CartScreen extends StatefulWidget {
  final List<Data> cartProducts;
  final Set<int> cartIds;
  const CartScreen({
    required this.cartProducts,
    required this.cartIds,
    super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.cartProducts.where((product) => widget.cartIds.contains(product.id)).toList();  
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.white,
        leadingWidth: 20,
      ),
      body: SafeArea(child: Padding(padding: EdgeInsets.all(16.0),
       child: Column(children: [
        Expanded(
          child: cartProducts.isEmpty ?
          Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text("Your cart is empty",
              style: TextStyle(fontSize: 18, color: Colors.grey),)
            ],
          ),
          )
          :ListView.builder(
          itemCount: cartProducts.length,
          itemBuilder: (context, index) {
            final product = cartProducts[index];
            return Padding(padding:   EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(product.image ?? ""),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name ?? "",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text(product.tagline ?? "",
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                      Text( product.price ?? "",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                

                IconButton(onPressed:() {
                  setState(() {
                    widget.cartIds.remove(product.id);
                  });
                }, icon: Icon(Icons.remove_circle, color: Colors.red,))
              ],
           
            ));
          },
        )),
        ElevatedButton(onPressed: (){}, child: Text("Buy Now"), style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),),
       ]),
       ),
       )

    );
  }
}