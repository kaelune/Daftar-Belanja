// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:daftarbelanja/ui/sidemenu.dart';
import 'package:daftarbelanja/ui/tambah_data.dart';
import 'package:daftarbelanja/ui/edit_data.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Map<String, String>> dataProduk = [];
  String url = Platform.isAndroid
      ? 'http://192.168.0.107/api_flutter/index.php'
      : 'http://localhost/api_flutter/index.php';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        dataProduk = List<Map<String, String>>.from(data.map((item) {
          return {
            'kode' : item['kode'] as int,
            'nama': item['nama'] as String,
            'harga': item['harga'] as int,
            'stock': item['stock'] as int,
          };
        }));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future deleteData(int kode) async {
    final response = await http.delete(Uri.parse('$url?kode=$kode'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Produk'),
      ),
      drawer: const Sidemenu(),
      body: Column(children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TambahData(),
              ),
            );
          },
          child: const Text('Tambah Data Produk'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataProduk.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dataProduk[index]['kode']!),
                subtitle:Text('harga: ${dataProduk[index]['harga']}'),
                
                

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteData(int.parse(dataProduk[index]['kode']!))
                            .then((result) {
                          if (result['pesan'] == 'berhasil') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Data berhasil di hapus'),
                                    content: const Text('ok'),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ListData(),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
