import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(key);

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
            ElevatedButton(onPressed: () => {}, child: const Text("Klik aku")),
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
              width: 300,
              height: 150,
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
