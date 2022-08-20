import 'dart:math';

import 'package:card/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: NetworkImage(snap['profImage']),
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
                          snap['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(DateFormat.yMMMMEEEEd().format(snap['datePublished'].toDate(),))
                      ),
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: ListView(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shrinkWrap: true,
                                  children: ['delete']
                                      .map(
                                        (e) => InkWell(
                                          onTap: () {},
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
                    icon: const Icon(Icons.settings))
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
                snap['postUrl'],
                fit: BoxFit.cover),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.comment),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${snap['likes'].length} likes',
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
