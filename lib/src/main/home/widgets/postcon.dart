import 'package:flutter/material.dart';
import 'package:project/src/main/home/datamodels/postsmodel.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

const String ethereum =
    "https://seeklogo.com/images/E/ethereum-eth-logo-CF9DCCA696-seeklogo.com.png";
const String bitcoin =
    "https://upload.wikimedia.org/wikipedia/commons/5/50/Bitcoin.png";

class PostContainer extends StatelessWidget {
  const PostContainer({
    super.key,
    required this.data,
  });
  final PostsModel data;
  @override
  Widget build(BuildContext context) {
    final String url = data.name == "Ethereum" ? ethereum : bitcoin;
    return InkWell(
      onTap: () {},
      child: Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.5, color: Colors.white),
              ),
            ),
            //padding: const EdgeInsets.all(5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(2),
                      child: CircleAvatar(
                        radius: 2.25.h,
                        backgroundImage: NetworkImage(
                          url,
                        ),
                      )),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(data.name),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Text(data.text, textAlign: TextAlign.start),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_outline_rounded,
                        color: Colors.white60,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.comment_rounded,
                        color: Colors.white60,
                      )),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.repeat_rounded,
                      color: Colors.white60,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.coffee_rounded,
                        color: Colors.white60,
                      ))
                ],
              ),
              //SizedBox(
              //height: 0.5.h,
              //)
            ]),
          )),
    );
  }
}
