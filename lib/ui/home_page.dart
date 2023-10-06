import 'package:flutter/material.dart';
import 'package:daftarbelanja/ui/sidemenu.dart';

class HomePage extends StatefulWidget{
  const HomePage ({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Card(
        margin: EdgeInsets.all(15),
        
        child: Column(
          children: [
            Text('Selamat datang'),
            const Divider(),
            Text('Untuk mengubah data dapat mengunjungi halaman list data pada sidemenu'),
          ],
        )
  
      ),
      drawer: const Sidemenu(),
    );    
  }
}