import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_models.dart';

class ProductDetailScreen extends StatefulWidget {
    final Data product;
  final Set<int>cartIds;
  const ProductDetailScreen({
    required this.product,
    required this.cartIds,
    super.key});


  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Back"),
        backgroundColor: Colors.white,
        leadingWidth: 20,
        


    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Hero(
            tag: widget.product.id ?? 0,
            child: Image.network(widget.product.image ?? "",
            height: 350,
            width: double.infinity,
            fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.name ?? "",
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(widget.product.tagline ?? "",  
                style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 16),
                Text("Description",
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                 Text(widget.product.description ?? "",
                 style: TextStyle(fontSize: 16)),
                 SizedBox(height: 16),
                 Text(widget.product.price ?? "",
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                 SizedBox(height: 8,),
                 ElevatedButton(
                  onPressed: (){
                    setState(() {
                      widget.cartIds.add(widget.product.id ?? 0);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to cart")));
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size.fromHeight(50),
                  ),
                  child: Text("Add to Cart",style: TextStyle(color: Colors.white),),)
                 
                
              ],
            ),
          )
          ],
        ),
      )
    )
    );
  }
}