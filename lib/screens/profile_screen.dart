import 'package:flutter/material.dart';
import 'package:short_media_app/widgets/custom_bottom_app_bar.dart';
import 'package:short_media_app/widgets/custom_video_preview.dart';

import '../models/models.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = ModalRoute.of(context)!.settings.arguments as User?;
    user = user ??= User.users[0];

    List<Post> posts = Post.posts.where((post) {
      return post.user.id == user!.id;
    }).toList();
    return Scaffold(
      backgroundColor: Colors.black,
      // bottomNavigationBar: const CustomBottomAppBar(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          '@${user.userName}',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _ProfilePageInformation(user: user),
          _ProfileContent(posts: posts),
        ],
      )),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({super.key, required this.posts});

  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(indicatorColor: Colors.white, tabs: [
            Tab(
                icon: Icon(
              Icons.grid_view_rounded,
            )),
            Tab(
                icon: Icon(
              Icons.favorite,
            )),
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
// First Tab

              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 9 / 16),
                  itemBuilder: (context, index) {
                    return CustomVideoPlayerPreview(
                      post: posts[index],
                    );
                  })
            ]),
          )
        ],
      ),
    );
  }
}

// profile button ahtit ui
class _ProfilePageInformation extends StatelessWidget {
  final User user;
  const _ProfilePageInformation({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(user.imgPath),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              children: [
                _buildUserInfo(context, 'Following', '${user.followings}'),
                _buildUserInfo(context, 'Followers', '${user.followers}'),
                _buildUserInfo(context, 'Likes', '${user.likes}')
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF006E),
                  fixedSize: const Size(200, 50),
                ),
                child: Text(
                  'Follow',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: const Size(50, 50),
                ),
                child: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ))
          ],
        )
      ],
    );
  }

  Expanded _buildUserInfo(BuildContext context, String type, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            type,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.grey.shade200, letterSpacing: 1.5),
          )
        ],
      ),
    );
  }
}
