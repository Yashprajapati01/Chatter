import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../pages/Settings_page.dart';
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  void logout() {
    //get auth service for signing out
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              DrawerHeader(child: Image.asset(
                'images/icon.png',
                height: 60.0,
                width: 60.0,
              ),),
              //logo

              //home list tile
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              //settings list tile
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(Icons.settings),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage(),
                    ),
                    );
                  },
                ),
              ),
              //logout tile
            ],),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 15),
              child: ListTile(
                title: Text("L O G O U T"),
                leading: Icon(Icons.logout),
                onTap: logout
              ),
            ),
          ],
        ),
      ),
    );
  }
}
