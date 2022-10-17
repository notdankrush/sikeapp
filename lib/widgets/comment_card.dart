import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final snap;
  CommentCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                widget.snap['profilePic']),
            radius: 18,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: widget.snap['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: ' ${widget.snap['text']}',
                    )
                  ])),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMMEEEEd().format(
                        widget.snap['datePublished'].toDate()
                      ),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
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
                                      'Unwanted commercial cotent or spam',
                                      'Pornography or sexually explicit material',
                                      'Child abuse',
                                      'Hate speech or graphic violence',
                                      'Promotes terrorism',
                                      'Harassment or bullying',
                                      'Suicide or self injury',
                                      'Misinformation',
                                      'Block User',
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
                      icon: const Icon(Icons.flag)),
                  Divider(
                    color: Colors.white,
                    thickness: 1.0,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}