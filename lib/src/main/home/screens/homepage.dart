import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:project/src/main/home/datamodels/postsmodel.dart";
import 'package:project/src/main/home/widgets/postcon.dart';
import "package:responsive_sizer/responsive_sizer.dart";

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<PostsModel> post = [
    PostsModel(name: "abc", text: "Hello", icon: ""),
    PostsModel(name: "def", text: "hi", icon: ""),
    PostsModel(name: "David", text: "Good morning", icon: ""),
    PostsModel(name: "FLutter", text: "Yahallo", icon: ""),
  ];
  List<PostsModel> posts = [
    PostsModel(name: "abc", text: "Hello", icon: ""),
    PostsModel(name: "def", text: "hi", icon: ""),
    PostsModel(name: "David", text: "Good morning", icon: ""),
    PostsModel(name: "FLutter", text: "Yahallo", icon: ""),
    PostsModel(name: "def", text: "hi", icon: ""),
    PostsModel(name: "David", text: "Good morning", icon: ""),
  ];
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(scrollistener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      //padding: EdgeInsets.fromLTRB(7.w, 0, 7.w, 0),
      // child: ListView.builder(
      //   controller: scrollController,
      //   shrinkWrap: true,
      //   scrollDirection: Axis.vertical,
      //   itemBuilder: List.generate(posts.length, (index) {
      //     return PostContainer(data: posts[index]);
      //}
      // ),
      child: ListView.builder(
        controller: scrollController,
        itemCount: isLoadingMore ? posts.length + 1 : posts.length,
        itemBuilder: (context, index) {
          if (index < posts.length) {
            return PostContainer(data: posts[index]);
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      // ),
    );
  }

  Future<void> scrollistener() async {
    if (isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      await timer();
      print("Called timer");
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Future<void> timer() async {
    print("Initiated timer");
    await Future.delayed(const Duration(seconds: 5));
    print("Finished timer");
    setState(() {
      posts = posts + post;
    });
  }
}
