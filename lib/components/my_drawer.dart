import 'package:flutter/material.dart';
import 'package:music_app/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          //home tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 25.0),
            child: ListTile(
              title: Text(
                "H O M E",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
          ),
          //logo tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 0),
            child: ListTile(
              title: Text(
                "S E T T I N G S",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.settings),
              onTap: () {
                // pop Drawer
                Navigator.pop(context);

                // Navigator to settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
