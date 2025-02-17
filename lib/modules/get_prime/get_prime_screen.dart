// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
//
// class InAppPurchaseScreen extends StatefulWidget {
//   @override
//   _InAppPurchaseScreenState createState() => _InAppPurchaseScreenState();
// }
//
// class _InAppPurchaseScreenState extends State<InAppPurchaseScreen> {
//   late InAppPurchase _inAppPurchase;
//   late Stream<List<PurchaseDetails>> _purchaseStream;
//   late List<ProductDetails> _productDetails;
//   bool _isLoading = true;
//
//   static const List<String> _kProductIds = [
//     'com.mayway.silver',
//     'com.mayway.gold',
//     'com.mayway.platinum',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _inAppPurchase = InAppPurchase.instance;
//     _purchaseStream = _inAppPurchase.purchaseStream;
//     _initialize();
//   }
//
//   void _initialize() async {
//     bool available = await _inAppPurchase.isAvailable();
//     if (!available) {
//       print("In-app purchases are not available.");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
//     if (response.error != null) {
//       print("Error fetching products: ${response.error}");
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     setState(() {
//       _productDetails = response.productDetails;
//       _isLoading = false;
//     });
//
//     _purchaseStream.listen((purchaseDetailsList) {
//       _handlePurchaseUpdates(purchaseDetailsList);
//     });
//   }
//
//   void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
//     for (var purchaseDetails in purchaseDetailsList) {
//       if (purchaseDetails.status == PurchaseStatus.purchased) {
//         String className = _getSubscriptionClassName(purchaseDetails.productID);
//         print("User purchased: $className");
//       } else if (purchaseDetails.status == PurchaseStatus.error) {
//         print("Purchase error: ${purchaseDetails.error}");
//       }
//     }
//   }
//
//   String _getSubscriptionClassName(String productId) {
//     switch (productId) {
//       case 'com.mayway.silver':
//         return 'Silver Subscription';
//       case 'com.mayway.gold':
//         return 'Gold Subscription';
//       case 'com.mayway.platinum':
//         return 'Platinum Subscription';
//       default:
//         return 'Unknown Subscription';
//     }
//   }
//
//   void _buySubscription(ProductDetails productDetails) {
//     final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
//     _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Choose Subscription',)),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _productDetails.isEmpty
//           ? _buildFallbackOptions()
//           : ListView.builder(
//         itemCount: _productDetails.length,
//         itemBuilder: (context, index) {
//           final product = _productDetails[index];
//           return _buildProductCard(product);
//         },
//       ),
//     );
//   }
//
//   Widget _buildProductCard(ProductDetails product) {
//     return Card(
//       elevation: 8,
//       margin: EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       color: _getCardColor(product.id),
//       child: SizedBox(
//         height: 250,
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 product.title,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 product.description,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white70,
//                 ),
//               ),
//               Spacer(),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       product.price,
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Expanded(
//                     flex: 1,
//                     child: ElevatedButton(
//                       onPressed: () => _buySubscription(product),
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: _getCardColor(product.id),
//                         backgroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Text(
//                         "Buy",
//                         style: TextStyle(
//                           color: _getCardColor(product.id),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFallbackOptions() {
//     return ListView(
//       children: [
//         _buildFallbackTile("Silver Subscription", "Basic tier", 'com.yourcompany.silver'),
//         _buildFallbackTile("Gold Subscription", "Advanced tier", 'com.yourcompany.gold'),
//         _buildFallbackTile("Platinum Subscription", "Premium tier", 'com.yourcompany.platinum'),
//       ],
//     );
//   }
//
//   Widget _buildFallbackTile(String title, String description, String productId) {
//     return Card(
//       elevation: 8,
//       margin: EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       color: _getCardColor(productId),
//       child: SizedBox(
//         height: 250,
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 description,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white70,
//                 ),
//               ),
//               Spacer(),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       'Price(100)',
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   Expanded(
//                     flex: 1,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _buySubscription(ProductDetails(
//                           id: productId,
//                           title: title,
//                           description: description,
//                           price: 'Price(100)',
//                           rawPrice: 110,
//                           currencyCode: '91',
//                         ));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: _getCardColor(productId),
//                         backgroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Text(
//                         "Buy",
//                         style: TextStyle(
//                           color: _getCardColor(productId),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Color _getCardColor(String productId) {
//     switch (productId) {
//       case 'com.yourcompany.silver':
//         return  Color(0xFFC0C0C0);
//       case 'com.yourcompany.gold':
//         return Color(0xFFFFD700);
//       case 'com.yourcompany.platinum':
//         return  Color(0xFF296CB9);
//       default:
//         return Colors.grey;
//     }
//   }
//
//   @override
//   void dispose() {
//     _inAppPurchase.purchaseStream.drain();
//     super.dispose();
//   }
// }
