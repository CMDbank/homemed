import 'package:flutter/material.dart';

import 'config.dart';
import 'main.dart';

class loadingscreen extends StatefulWidget {
  @override
  State<loadingscreen> createState() => _loadingscreenState();
}

class _loadingscreenState extends State<loadingscreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => InputLogin()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: SizedBox(
                  height: 350, child: Image.asset("assets/loadingscreen.png")),
            ),
            textstyle_eng(
              text: "HomeMed+",
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
