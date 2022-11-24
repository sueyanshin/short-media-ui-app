import 'package:flutter/material.dart';
import 'package:short_media_app/screens/search_screen.dart';
import '../screens/home_screen.dart';

import '../screens/profile_screen.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 75,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, HomeScreen.routeName);
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, SearchScreen.routeName);
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.message,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, ProfileScreen.routeName);
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                )),
          ]),
        ));
  }
}
