import 'package:flutter/material.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage();

   @override
  State<BiodataPage> createState() => _BiodataState();
}

class _BiodataState extends State<BiodataPage> {
  void _showDetail() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Detail"),
        content: const Text("Halo nama saya M. Syafiq Paradisam, Hobi Ngoding C/C++,Go,Rust,PHP"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contoh komponen UI FLutter", style: TextStyle()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          spacing: 10,
          children: [
            Text(
              "Halo, ini adalah teks",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            Padding(padding: EdgeInsetsGeometry.all(20)),
            ElevatedButton(onPressed: _showDetail, child: const Text("Klik aku")),
            Padding(padding: EdgeInsetsGeometry.all(20)),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                140,
              ), // setengah dari width/height biar bulat
              child: Image.asset(
                'assets/images/profile.jpg',
                width: 280,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 250,
              height: 120,
              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(16), // <- Sudut membulat
              ),
              child: const Text(
                "Ini adalah container",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
