import 'package:flutter/material.dart';
import 'services/kode_pos_service.dart';

void main() {
  runApp(AplikasiKodePos());
}

class AplikasiKodePos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Kode Pos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DaftarProvinsiScreen(),
    );
  }
}

class DaftarProvinsiScreen extends StatefulWidget {
  @override
  _DaftarProvinsiScreenState createState() => _DaftarProvinsiScreenState();
}

class _DaftarProvinsiScreenState extends State<DaftarProvinsiScreen> {
  late Future<Map<String, dynamic>> _provinsi;

  @override
  void initState() {
    super.initState();
    _provinsi = KodePosService().fetchProvinsi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Provinsi'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _provinsi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada provinsi yang ditemukan'));
          } else {
            var provinsiList = snapshot.data!.entries.toList();

            return ListView.builder(
              itemCount: provinsiList.length,
              itemBuilder: (context, index) {
                var provinsi = provinsiList[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      provinsi.value,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Kode Pos: ${provinsi.key}', // Misalkan key adalah kode pos
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(provinsi.value[
                          0]), // Mengambil huruf pertama dari nama provinsi
                    ),
                    onTap: () {
                      // Tambahkan aksi saat item di-tap jika diperlukan
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
