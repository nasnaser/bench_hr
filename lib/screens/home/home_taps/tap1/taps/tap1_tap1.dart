import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/network/json_model/emoji_json_model.dart';

import 'package:bench_hr/screens/home/controllers/home_controller.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Tap1Tap1 extends StatelessWidget {
  const Tap1Tap1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: "newsFeed",
        builder: (logic) {
          return ListView.builder(
              controller: logic.newsFeedsListscrollController,
              itemCount: logic.newsFeedsList.length,
              itemBuilder: (context, pos) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(logic.newsFeedsList[pos].employee
                                            ?.fullName ??
                                        ""),
                                    Text(
                                        logic.newsFeedsList[pos].employee
                                                ?.jobTitle?.name ??
                                            "",
                                        style: TextStyle(
                                            color: HexColor("#98A2B3"))),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  DateFormat.yMMMd("ar_SA").format(
                                    DateTime.parse(
                                      logic.newsFeedsList[pos].publishedAt!,
                                    ),
                                  )
                                  //  "${logic.newsFeedsList[pos].publishedAt?.substring(0, 10)}"
                                  ,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: HexColor("#98A2B3")),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //     height: 200,
                          //     child: ListView.builder(
                          //         scrollDirection: Axis.horizontal,
                          //         itemCount:
                          //         logic
                          //             .newsFeedsList[pos].attachment?.length,
                          //         itemBuilder: (context, index) {
                          //           if (logic.newsFeedsList[pos]
                          //                   .attachment![index].type ==
                          //               "image") {
                          //             return Padding(
                          //               padding:
                          //                   const EdgeInsets.only(left: 2.0),
                          //               child:
                          //               Image.network(
                          //                 logic.newsFeedsList[pos]
                          //                     .attachment![index].attachment!,
                          //                 height: 200,
                          //                 width:
                          //                     MediaQuery.of(context).size.width,
                          //                 fit: BoxFit.fill,
                          //               ),
                          //             );
                          //           } else {
                          //             return SizedBox();
                          //           }
                          //         })),

                          logic.newsFeedsList[pos].attachment!.isEmpty
                              ? SizedBox()
                              : logic.newsFeedsList[pos].attachment!.first
                              .attachment!
                              .split(".")
                              .last ==
                              "pdf"
                              ? Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, left: 20),
                            child: GestureDetector(onTap:(){
                           logic.   pdfBotomSheet(context: context,pdfUrl: logic.newsFeedsList[pos].attachment!.first
                               .attachment!);
                            } ,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    color: HexColor("#F2F6F6")),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [  SvgPicture.asset(
                                      "assets/image/dowenloadpdf.svg"),
                                    Spacer(),
                                    Column(crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(logic
                                              .newsFeedsList[pos]
                                              .attachment!
                                              .first
                                              .attachment!
                                              .split("/").last,style: TextStyle(color: HexColor("#015555"),fontSize: 16,fontWeight: FontWeight.w500)),
                                        )
                                      ],
                                    ),
                                    SvgPicture.asset(
                                        "assets/image/pdficon.svg"), ]),
                                ),
                              ),
                            ),
                          )
                              : CarouselSlider(
                            items: logic.newsFeedsList[pos].attachment
                                ?.map((e) {
                              //  print(e.attachment?.split(".").last);

                              return Image.network(
                                e.attachment!,
                                height: 300,
                                width:
                                MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              );
                            }).toList(),
                            carouselController:
                            logic.carouselController,
                            options: CarouselOptions(
                              height: 300,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: logic.newsFeedsList[pos]
                                  .attachment?.length ==
                                  1
                                  ? false
                                  : true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.2,
                              onPageChanged: (int i,
                                  CarouselPageChangedReason r) {},
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("${logic.newsFeedsList[pos].title}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 15.0,
                              left: 15,
                            ),
                            child: Text(logic.newsFeedsList[pos].description!),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.only(right: 16.0, left: 16),
                            child: Divider(
                                color: ColorApp.grayDividerColor2,
                                height: 1,
                                thickness: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  ...logic.newsFeedsList[pos].reactions!
                                      .map((e) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, left: 4, bottom: 4),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (e.selected == 1) {
                                            logic.update();
                                            logic.deletEmoje(
                                                //pos: pos,
                                                postId: logic
                                                    .newsFeedsList[pos].id
                                                    .toString(),
                                                emoje: e.defaultEmoji!);
                                            logic.update();
                                            if (e.total == 1) {
                                              logic
                                                  .newsFeedsList[pos].reactions!
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
                                                postID: logic
                                                    .newsFeedsList[pos].id!);

                                            logic.update();
                                          }
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                right: 8,
                                                left: 8,
                                                bottom: 4,
                                                top: 4),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: e.selected == 1
                                                      ? ColorApp.PrimaryColor
                                                          .withOpacity(.8)
                                                      : Colors.grey
                                                          .withOpacity(.2),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: e.selected == 1
                                                  ? ColorApp.PrimaryColor
                                                      .withOpacity(.1)
                                                  : ColorApp.graybackImojiColor,
                                            ),
                                            child: Text(
                                                "${AllEmojiToView.allEmojiMap[e.defaultEmoji]?.character ?? ""} ${e.total}")),
                                      ),
                                    );
                                  }).toList(),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        logic.my30EmojiBotomSheet(
                                            context: context,
                                            indexOfPostInList: pos,
                                            postId:
                                                logic.newsFeedsList[pos].id!);
                                        // logic.botomshhetemojeindex = 0;
                                        // logic.EmojiBotomSheet(
                                        //     context: context,
                                        //     indexOfPostInList: pos,
                                        //     postId: logic.newsFeedsList[pos].id!);
                                      },
                                      child: SvgPicture.asset(
                                        "assets/image/addemojisvg.svg",
                                        color: ColorApp.PrimaryColor,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Row(
                            children: [],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: Container(
                              height: 50,
                              child: Row(children: [
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
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/image/message.svg",
                                            width: 20,
                                            height: 20,
                                            color: ColorApp.PrimaryColor),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                            "${logic.newsFeedsList[pos].commentsCount} تعليق",
                                            style: TextStyle(
                                                color:
                                                    ColorApp.grayTextImojiColor,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.start),
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
        });
  }
}
