import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_models.dart';

class ProductCart extends StatelessWidget {
  final Data product;
  const ProductCart({
    required this.product,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                      decoration : BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Expanded(
                          child: Hero(
                            tag: product.id ?? 0,

                            child: ClipRRect
                            (
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.network(product.image ?? "",)),
                          ),
                        ),Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16,)
                                                    ),
                                                    SizedBox(height: 1),
                                                    Text(product.tagline ?? "",
                                                    style: TextStyle(
                              color: Colors.grey.shade600,
                              overflow: TextOverflow.ellipsis
                              
                                                    ),
                                                    ),
                                                    SizedBox(height: 1),
                                                    Text(
                              product.price ?? "N/A",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),),
                            ],
                          ),
                        )
                  
                      ],
                      
                        
  
                      )
                      
                      
                    );
  }
}