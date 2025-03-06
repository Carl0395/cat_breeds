import 'package:cat_breeds/ui/widgets/custom_appbar.dart';
import 'package:cat_breeds/ui/widgets/search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Catbreeds",
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 16, right: 16),
            child: Search(
              hintText: "Buscar",
              controller: TextEditingController(),
            ),
          ),
        ],
      ),
    );
  }
}
