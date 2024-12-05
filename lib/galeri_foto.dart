import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Galeri Foto',
      home: GaleriFoto(),
    );
  }
}

class GaleriFoto extends StatefulWidget {
  const GaleriFoto({super.key});

  @override
  GaleriFotoState createState() => GaleriFotoState();
}

class GaleriFotoState extends State<GaleriFoto> {
  // Daftar foto
  final List<String> _imageUrls = [
   'assets/1.jpg'
  ];

  // Fungsi untuk menambahkan gambar baru
  void _addImage() async {
    // Dialog untuk memasukkan URL gambar baru
    final TextEditingController urlController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Gambar'),
          content: TextField(
            controller: urlController,
            decoration: const InputDecoration(hintText: 'Masukkan URL gambar'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (urlController.text.isNotEmpty) {
                  setState(() {
                    _imageUrls.add(urlController.text);
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
             colors: [Colors.blue, Color.fromARGB(255, 11, 10, 11)],
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Galeri Foto',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _imageUrls.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailFoto(imageUrl: _imageUrls[index]),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  _imageUrls[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.error),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addImage,
        backgroundColor: const Color.fromARGB(255, 7, 199, 49),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Halaman detail untuk menampilkan foto dalam ukuran penuh
class DetailFoto extends StatelessWidget {
  final String imageUrl;

  const DetailFoto({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Foto'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.error),
            );
          },
        ),
      ),
    );
  }
}
