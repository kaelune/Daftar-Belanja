import 'dart:io';

import 'package:flutter/material.dart';
import 'package:daftarbelanja/ui/list_data.dart';


class EditData extends StatefulWidget {
  final  produk;

  const EditData({Key? key, required this.produk}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditDataState createState() => _EditDataState();
}


class _EditDataState extends State<EditData> {
  final kodeController = TextEditingController();
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stockController = TextEditingController();
 
  get http => null;


  @override
  void initState() {
    super.initState();
    kodeController.text = widget.produk.kode;
    namaController.text = widget.produk.nama;
    hargaController.text = widget.produk.harga;
    stockController.text = widget.produk.stock;
  }


  Future<void> updateData() async {
    String url = Platform.isAndroid
        ? 'http://192.168.0.107/api_flutter/update.php'
        : 'http://localhost/api_flutter/update.php';


    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody =
        '{"id": "${widget.produk.id}", "kode": "${kodeController.text}", "nama": "${namaController.text}", "harga": "${hargaController.text}","stock": "${stockController.text}"}';


    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );


    if (response.statusCode != 200) {
      throw Exception('Gagal mengupdate data');
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data produk'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: kodeController,
              decoration: const InputDecoration(
                hintText: 'Kode produk',
              ),
            ),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                hintText: 'Nama',
              ),
            ),
            TextField(
              controller: hargaController,
              decoration: const InputDecoration(
                hintText: 'Harga',
              ),
            ),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(
                hintText: 'Stock',
              ),
            ),
            ElevatedButton(
              child: const Text('Simpan Perubahan'),
              onPressed: () {
                updateData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
