import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: const Text(
         'Profile Member',
         style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
       ),
       centerTitle: true,
       backgroundColor: Colors.red,
       elevation: 0,
     ),
     body: Column (
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: const EdgeInsets.only(top: 20,left: 30, right: 30),
           child: Container(
             height: 100,
             width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
               image: const DecorationImage(
                 image: AssetImage(
                   'assets/images/barcode.png',
                 ),
                 fit: BoxFit.contain),
                 borderRadius: BorderRadius.circular(10)),
             ),
           ),
           const Padding(
             padding: EdgeInsets.only(left: 30),
            child: Text(
              'Member card',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
           ),
           Padding(
            padding: const EdgeInsets.only(left: 30),
              child: TextButton(
              onPressed: () {},
              child: const Text(
              'Read More',
               style: TextStyle(color: Colors.white),
               ),
               style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all(
               Colors.green.shade600),
                shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                ))),
              ),
           ),
       ],
     ),
    );
  }
}