
import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/network/json_model/emoji_json_model.dart';

import 'package:bench_hr/screens/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tap1Tap1 extends StatelessWidget {
  const Tap1Tap1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
          id: "newsFeed",
          builder: (logic) {
            return ListView.builder(
                controller: logic.newsFeedsListscrollController,
                itemCount: logic.newsFeedsList.length,
                itemBuilder: (context, pos) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    maxRadius: 20,
                                    backgroundImage: NetworkImage(logic
                                            .newsFeedsList[pos]
                                            .employee
                                            ?.profilePhoto ??
                                        ""),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Column(
                                    children: [
                                      Text(logic.newsFeedsList[pos].employee
                                              ?.fullName ??
                                          ""),
                                      Text(logic.newsFeedsList[pos].employee
                                              ?.jobTitle?.name ??
                                          ""),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                      "${logic.newsFeedsList[pos].publishedAt?.substring(0,10)}"),
                                  Icon(Icons.more_vert)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("${logic.newsFeedsList[pos].title}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child:
                                  Text(logic.newsFeedsList[pos].description!),
                            ),
                            SizedBox(
                                height: 100,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: logic
                                        .newsFeedsList[pos].attachment?.length,
                                    itemBuilder: (context, index) {
                                      if (logic.newsFeedsList[pos]
                                              .attachment![index].type ==
                                          "image") {
                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.network(
                                            logic.newsFeedsList[pos]
                                                .attachment![index].attachment!,
                                            height: 100,
                                            width: 200,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    })),
                            Wrap(
                                children: logic.newsFeedsList[pos].reactions!
                                    .map((e) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 2, left: 2),
                                child: GestureDetector(
                                  onTap: () {
                                    if (e.selected == 1) {
                                      logic.update();
                                      logic.deletEmoje(
                                          pos: pos,
                                          postId: logic.newsFeedsList[pos].id
                                              .toString(),
                                          emoje: e.defaultEmoji!);
                                      logic.update();
                                      if (e.total == 1) {
                                        logic.newsFeedsList[pos].reactions!
                                            .remove(e);
                                      } else {
                                        e.total = e.total! - 1;
                                        e.selected = 0;
                                        logic.update();
                                      }
                                    } else {
                                      e.total = e.total! + 1;
                                      e.selected = 1;
                                      logic.addEmojiToServer(
                                          default_emoji: e.defaultEmoji,
                                          postID: logic.newsFeedsList[pos].id!);

                                      logic.update();
                                    }
                                  },
                                  child: Chip(
                                      backgroundColor: e.selected == 1
                                          ? Colors.blue
                                          : Colors.white,
                                      label: Text(
                                          "${e.total}${AllEmojiToView.allEmojiMap[e.defaultEmoji]?.character ?? ""}")),
                                ),
                              );
                            }).toList()),
                            Row(children: [],),
                            Padding(
                              padding:
                              const EdgeInsets.only(right: 8, left: 8),
                              child: Container(
                                height: 50,
                                child: Row(children: [
                                  GestureDetector(
                                      onTap: () {

                                        logic.botomshhetemojeindex = 0;
                                        logic.EmojiBotomSheet(
                                            context: context,
                                            indexOfPostInList: pos,
                                            postId:
                                            logic.newsFeedsList[pos].id!);
                                      },
                                      child: Icon(Icons.emoji_emotions_outlined,color: ColorApp.PrimaryColor),),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        logic.postId =
                                        logic.newsFeedsList[pos].id!;
                                        logic.getAllComments(
                                            context: context,
                                            id: logic.newsFeedsList[pos].id
                                                .toString());
                                      },
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
                                        children: [ Icon(Icons.comment,color: ColorApp.PrimaryColor),SizedBox(width: 4,),
                                          Text(
                                              "${logic.newsFeedsList[pos].commentsCount} comments"),
                                        ],
                                      ))
                                ]),
                              ),
                            ),

                            SizedBox(
                              height: 8,
                            ),
                          ],
                        )),
                  );
                });
          }),
    );
  }
}
