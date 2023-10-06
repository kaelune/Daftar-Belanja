import 'dart:convert';
import 'dart:io';

import 'package:daftarbelanja/ui/list_data.dart';
import 'package:daftarbelanja/ui/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({Key? key}) : super(key: key);

  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final kodeController = TextEditingController();
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stockController = TextEditingController();


  Future postData(int kode, String nama, int harga, int stock) async {
    // print(nama);
    String url = Platform.isAndroid
        ? 'http://192.168.0.107/api_flutter/index.php'
        : 'http://localhost/api_flutter/index.php';
    //String url = 'http://127.0.0.1/apiTrash/prosesLoginDriver.php';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"kode": "$kode", "nama": "$nama", "harga": "$harga", "stock": "$stock"}';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Mahasiswa'),
      ),
      drawer: const Sidemenu(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: kodeController,
              decoration: const InputDecoration(
                hintText: 'kode Barang',
              ),
            ),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                hintText: 'Nama Barang',
              ),
            ),
            TextField(
              controller: hargaController,
              decoration: const InputDecoration(
                hintText: 'harga',
              ),
            ),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(
                hintText: 'stock',
              ),
            ),

            ElevatedButton(
              child: const Text('Tambah Mahasiswa'),
              onPressed: () {
                int kode = int.parse(kodeController.text);
                String nama = namaController.text;
                int harga = int.parse(hargaController.text);
                int stock = int.parse(stockController.text);

                // print(nama);
                postData(kode, nama, harga, stock).then((result) {
                  //print(result['pesan']);
                  if (result['pesan'] == 'berhasil') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          //var namauser2 = namauser;
                          return AlertDialog(
                            title: const Text('Data berhasil di tambah'),
                            content: const Text('ok'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ListData(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  }
                  setState(() {});
                });
              },
            ),
          ],
        ),

        //     ],
        //   ),
        // ),
      ),
    );
  }
}
