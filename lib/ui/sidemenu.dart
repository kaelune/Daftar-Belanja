import 'package:flutter/material.dart';
import 'package:daftarbelanja/ui/home_page.dart';
import 'package:daftarbelanja/ui/list_data.dart';


class Sidemenu extends StatelessWidget{
  const Sidemenu ({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Application'),),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: (){
              HomePage();
            },
          ),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('List data'),
            onTap: (){
              ListData();
            },
          ),

          
        ],
      ),
    );
  }
}