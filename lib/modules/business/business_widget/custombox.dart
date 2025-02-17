// import 'package:flutter/material.dart';
// import 'package:mayway_business/config/theme/app_colors.dart';
//
// class BusinessDashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//               child: SizedBox(
//                 height: 150,
//                 child: Card(
//                   color: Colors.white,
//                   shadowColor: Colors.blue,
//                   elevation: 25,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: GridView.builder(
//                       scrollDirection: Axis.horizontal,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 1,
//                         childAspectRatio: 1.2,
//                         mainAxisSpacing: 16.0,
//                       ),
//                       itemCount: 3,
//                       itemBuilder: (context, index) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset('assets/icons/business/b17.png', height: 50),
//                             SizedBox(height: 8),
//                             Text('Self Invest', style: TextStyle(fontSize: 16)),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               color: Colors.white,
//               child: TabBar(
//                 dividerColor: Colors.orange,
//                 isScrollable: true,
//                 labelColor: Colors.black,
//                 indicatorColor: Colors.blue,
//                 tabs: [
//                   Tab(text: 'Dashboard'),
//                   Tab(text: 'Income'),
//                   Tab(text: 'Withdrawal'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   DashboardTab(),
//                   IncomeTab(),
//                   WithdrawalTab(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DashboardTab extends StatelessWidget {
//   final List<String> titles = [
//     "Total Earnings",
//     "Total Withdrawal",
//     "My Partners",
//     "Investment Earnings",
//     "Last Month Earnings",
//     "Till Date Earnings"
//   ];
//
//   final List<String> values = [
//     "₹ 50,000",
//     "₹ 20,000",
//     "5 Partners",
//     "₹ 30,000",
//     "₹ 5,000",
//     "₹ 1,00,000"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // 2 columns
//           mainAxisSpacing: 8.0,
//           crossAxisSpacing: 8.0,
//           childAspectRatio: 1.5,
//         ),
//         itemCount: titles.length,
//         itemBuilder: (context, index) {
//           return Card(
//             shadowColor: Colors.deepOrange,
//             color: AppColors.blueColorLink,
//             elevation: 8,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(values[index], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                 SizedBox(height: 8),
//                 Text(titles[index], style: TextStyle(fontSize: 16, color: Colors.white)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class IncomeTab extends StatelessWidget {
//   final List<String> titles = [
//     "Total Earnings",
//     "Investment Earnings",
//     "Last Month Earnings",
//   ];
//
//   final List<String> values = [
//     "₹ 50,000",
//     "₹ 30,000",
//     "₹ 5,000",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // 2 columns
//           mainAxisSpacing: 8.0,
//           crossAxisSpacing: 8.0,
//           childAspectRatio: 1.5,
//         ),
//         itemCount: titles.length,
//         itemBuilder: (context, index) {
//           return Card(
//             shadowColor: Colors.deepOrange,
//             color: AppColors.blueColorLink,
//             elevation: 8,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(values[index], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                 SizedBox(height: 8),
//                 Text(titles[index], style: TextStyle(fontSize: 16, color: Colors.white)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class WithdrawalTab extends StatelessWidget {
//   final List<String> titles = [
//     "Total Withdrawal",
//     "Last Month Withdrawal",
//   ];
//
//   final List<String> values = [
//     "₹ 20,000",
//     "₹ 5,000",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // 2 columns
//           mainAxisSpacing: 8.0,
//           crossAxisSpacing: 8.0,
//           childAspectRatio: 1.5,
//         ),
//         itemCount: titles.length,
//         itemBuilder: (context, index) {
//           return Card(
//             shadowColor: Colors.deepOrange,
//             color: AppColors.blueColorLink,
//             elevation: 8,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(values[index], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                 SizedBox(height: 8),
//                 Text(titles[index], style: TextStyle(fontSize: 16, color: Colors.white)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
