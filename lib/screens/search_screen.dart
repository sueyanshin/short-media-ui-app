import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:short_media_app/screens/profile_screen.dart';
import 'package:short_media_app/widgets/custom_bottom_app_bar.dart';

import '../models/user_model.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<User> users = User.users;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Discover',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      body: MasonryGridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(10.0),
          shrinkWrap: true,
          itemCount: users.length,
          crossAxisCount: 2,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.routeName,
                    arguments: users[index]);
              },
              child: Stack(
                children: [
                  Container(
                    height: (index == 0) ? 250 : 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(users[index].imgPath),
                            fit: BoxFit.cover)),
                  ),
                  const Positioned.fill(
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                  ],
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                  stops: [0.4, 1.0])))),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(users[index].imgPath),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              users[index].userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '2 min ago',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
