import 'package:card/resources/firestore_methods.dart';
import 'package:card/screens/comments_screen.dart';
import 'package:card/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:card/providers/user_provider.dart';
import 'package:card/utils/colors.dart';
import 'package:card/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: Text(
                            widget.snap['username'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(DateFormat.yMMMMEEEEd().format(
                            widget.snap['datePublished'].toDate(),
                          ))),
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: ListView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shrinkWrap: true,
                                  children: [
                                    'Sexual Content',
                                    'Violent or repulsive',
                                    'Hateful or abusive content',
                                    'Harmful or dangerous acts',
                                    'Spam or misleading',
                                    'Block User'
                                  ]
                                      .map(
                                        (e) => InkWell(
                                          onTap: () async {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ));
                    },
                    icon: const Icon(Icons.flag))
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreMethods().likePost(
                  widget.snap['postId'], user.uid, widget.snap['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(widget.snap['postUrl'], fit: BoxFit.fitWidth),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  child: const Icon(
                    Icons.thumb_up_alt,
                    color: Colors.white,
                    size: 120,
                  ),
                  isAnimating: isLikeAnimating,
                  duration: const Duration(milliseconds: 400),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                ),
              )
            ]),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                    onPressed: () async {
                      await FirestoreMethods().likePost(widget.snap['postId'],
                          user.uid, widget.snap['likes']);
                    },
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.thumb_up_alt,
                            color: Colors.white,
                          )
                        : const Icon(Icons.thumb_up_alt_outlined,
                            color: Colors.white)),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                          snap: widget.snap,
                        ))),
                icon: const Icon(Icons.comment),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${widget.snap['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
