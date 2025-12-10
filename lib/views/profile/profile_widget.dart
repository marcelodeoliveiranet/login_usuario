import 'package:flutter/material.dart';
import 'package:login_usuario/controllers/login_controller.dart';
import 'package:login_usuario/dependencies/injetor.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final LoginController loginController = getIt<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfil do Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 24,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 100, color: Color(0XFFFFEDC2)),
            ),
            Text(
              "Marcelo".toUpperCase(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () async {
                await loginController.logOut();
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(color: Color(0XFFFFEDC2)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Icon(Icons.arrow_back), Text("Logout")],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
