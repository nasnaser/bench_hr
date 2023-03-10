import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/network/apis/all_events_api.dart';
import 'package:bench_hr/network/apis/delete_comments_api.dart';
import 'package:bench_hr/network/apis/delete_emoje_api.dart';
import 'package:bench_hr/network/apis/event_types_api.dart';
import 'package:bench_hr/network/apis/news_feeds_comments_api.dart';
import 'package:bench_hr/network/apis/news_feeds_list_api.dart';
import 'package:bench_hr/network/apis/reactions_create_api.dart';
import 'package:bench_hr/network/apis/update_comments_api.dart';
import 'package:bench_hr/network/json_model/all_events_model.dart';
import 'package:bench_hr/network/json_model/emoji_json_model.dart';
import 'package:bench_hr/network/json_model/event-types_model.dart';
import 'package:bench_hr/network/json_model/events_model.dart';
import 'package:bench_hr/network/json_model/logIn_verify_model.dart';
import 'package:bench_hr/network/json_model/news_feeds_comments_model.dart';
import 'package:bench_hr/network/json_model/newsfeeds_model.dart';

import 'package:bench_hr/screens/home/home_taps/tap1/tap1_screen.dart';
import 'package:bench_hr/screens/home/home_taps/tap1/taps/tap1_tap1.dart';
import 'package:bench_hr/utility/date_Util.dart';
import 'package:bench_hr/utility/nested_open_page.dart';
import 'package:bench_hr/utility/storage.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../network/apis/event_details_api.dart';
import '../../../network/apis/events_api.dart';
import '../../../network/json_model/events_details.dart';
import '../../../utility/conest_image.dart';
import '../../attendace/attendace_screen.dart';
import '../../profile/profile_screen.dart';
import '../../shared_widget/custom_button.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  BuildContext? eventCotext;

  ScrollController newsFeedsListscrollController = ScrollController();
  ScrollController emojiscrollController = ScrollController();
  final CarouselController carouselController = CarouselController();
  NewsFeedsModel? newsFeedsModel;
  List<CommentsList> commentsList = [];
  NewsFeedsCommentsModel? newsFeedsCommentsModel;
  bool isUpdatecomment = false;
  String comentID = "";
  int postId = 0;
  int botomshhetemojeindex = 1;
  TextEditingController commentTextEditingController = TextEditingController();
  ScrollController commetscrollController = ScrollController();
  ItemScrollController itemScrollController = ItemScrollController();
  PdfViewerController pdfViewerController = PdfViewerController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  int event_type = 0;
  bool isFilter = false;

  updateevent_typeandisFilter({required int type, required bool filter}) {
    event_type = type;
    isFilter = filter;
    update();
  }

  List<Widget> screens = [
    Tap1Screen(),
    Attendance(),
    ProfileScreen(),
    Tap1Screen(),
    Tap1Screen(),
  ];
  late Widget screen;

  LogInVerifyModel? logInVerifyModel;

  late TabController tabController;
  int navigatorValue = 0;
  final List<Widget> myTabs = <Widget>[
    Container(
        width: double.infinity, height: double.infinity, color: Colors.green),
    Tap1Tap1(),
    Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amberAccent),
  ];

  DateTime selectedDay = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    AllEmojiToView.GetEmojis();

    screen = screens[navigatorValue];
    tabController = TabController(vsync: this, length: myTabs.length);
    var data = SecureStorage.readLogInJson();
    logInVerifyModel = LogInVerifyModel.fromJson(data!);
    getallPast();
    newsFeedsListscrollController.addListener(() {
      if (newsFeedsListscrollController.position.atEdge) {
        if (newsFeedsListscrollController.position.pixels == 0) {
          print('List scroll at top');
        } else {
          if (newsFeedsModel!.data!.pagination!.next!.trim().isNotEmpty) {
            NewsFeedsListAPI newsFeedsListAPI = NewsFeedsListAPI();
            // newsFeedsCommentsAPI.id = postId;

            newsFeedsListAPI
                .getpaginationData(url: newsFeedsModel!.data!.pagination!.next!)
                .then((value) {
              newsFeedsModel = value as NewsFeedsModel;

              newsFeedsList.addAll(newsFeedsModel?.data?.list ?? []);
              update(["newsFeed"]);
            });
          }
        }
      }
    });
    itemPositionsListener.itemPositions.addListener(() {
      final indices = itemPositionsListener.itemPositions.value.map((e) => e);
      print(indices.first.index);
      if (botomshhetemojeindex != indices.first.index) {
        botomshhetemojeindex = indices.first.index + 1;
        update();
      }
    });
    getEventTypes();
    getAllevents();
    geteventsDay();
  }

  List<NewsFeedsList> newsFeedsList = [];

  Future getallPast() async {
    NewsFeedsListAPI newsFeedsListAPI = NewsFeedsListAPI();
    newsFeedsListAPI.getData().then((value) {
      newsFeedsModel = value as NewsFeedsModel;
      // print(newsFeedsModel.toJson());
      newsFeedsList.addAll(newsFeedsModel!.data!.list!);
      update(["newsFeed"]);
    });
  }

  changeHomeTapsSelectedValue(int selectedValue) {
    screen = screens[selectedValue];
    navigatorValue = selectedValue;
    update();
  }

  getAllComments({required context, required String id}) {
    commentsList.clear();
    NewsFeedsCommentsAPI newsFeedsCommentsAPI = NewsFeedsCommentsAPI();
    newsFeedsCommentsAPI.id = id;
    newsFeedsCommentsAPI.getData().then((value) {
      newsFeedsCommentsModel = value as NewsFeedsCommentsModel;
      commentsList.addAll(newsFeedsCommentsModel!.data!.list!);
      commentsBotomSheet(context: context, data: commentsList, postId: id);
      //getXBotomShhet(context: context, data: commentsList, postId: id);
    });
  }

  addComments({required context, required String id}) {
    NewsFeedsCommentsAPI newsFeedsCommentsAPI = NewsFeedsCommentsAPI();
    newsFeedsCommentsAPI.id = id;
    newsFeedsCommentsAPI
        .post({"comment": commentTextEditingController.text}).then((value) {
      //getAllComments(context: context,id: id);
    });
  }

  deletEmoje({required String postId, required String emoje}) {
    update();
    DeleteEmojeAPI deleteEmojeAPI = DeleteEmojeAPI();
    deleteEmojeAPI.idPost = postId;
    deleteEmojeAPI.post({"default_emoji": emoje}).then((value) {});
  }

  addreactions({required int pos, required String emojei}) {
    int itempos = 0;

    bool isinlist = false;
    Reactions reactions =
        Reactions(defaultEmoji: emojei, selected: 1, total: 1);
    bool isSelect = false;
    for (int i = 0; i < newsFeedsList[pos].reactions!.length; i++) {
      if (newsFeedsList[pos].reactions![i].defaultEmoji == emojei) {
        isinlist = true;

        itempos = i;
        if (newsFeedsList[pos].reactions![i].selected == 1) {
          isSelect = true;
        }
        print(itempos);
      }
    }
    if (!isSelect) {
      if (isinlist) {
        newsFeedsList[pos].reactions![itempos].total =
            newsFeedsList[pos].reactions![itempos].total! + 1;
        newsFeedsList[pos].reactions![itempos].selected = 1;
      } else {
        newsFeedsList[pos].reactions!.add(reactions);
      }
    } else {
      newsFeedsList[pos].reactions![itempos].total =
          newsFeedsList[pos].reactions![itempos].total! - 1;
      deletEmoje(postId: newsFeedsList[pos].id.toString(), emoje: emojei);
    }

    update();
  }

  updateComments({required comentid}) {
    UpdateCommentsAPI newsFeedsCommentsAPI = UpdateCommentsAPI();
    newsFeedsCommentsAPI.idPost = postId.toString();
    newsFeedsCommentsAPI.idComment = comentid.toString();

    newsFeedsCommentsAPI
        .post({"comment": commentTextEditingController.text}).then((value) {});
  }

  deletcomments({required comentid}) {
    DeleteCommentsAPI deleteCommentsAPI = DeleteCommentsAPI();
    deleteCommentsAPI.idPost = postId.toString();
    deleteCommentsAPI.idComment = comentid.toString();
    deleteCommentsAPI.deletePost().then((value) {});
  }

  addEmojiToServer({required default_emoji, required int postID}) {
    print(postID);
    ReactionsCreateAPI reactionsCreateAPI = ReactionsCreateAPI();
    reactionsCreateAPI.idPost = postID.toString();

    reactionsCreateAPI.post({"default_emoji": default_emoji}).then((value) {});
  }

  getXBotomShhet(
      {required context, required List<CommentsList> data, required postId}) {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      height: 10000,
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Center(
              child: Container(
                height: 2,
                width: 100,
                decoration: BoxDecoration(color: ColorApp.PrimaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "??????????????????",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: HexColor("#015555")),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GetBuilder<HomeController>(builder: (logic) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: commetscrollController,
                        //shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          print(" data.length  =>${data.length}");
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                color: HexColor("#FFFFFF"),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 20,
                                      backgroundImage: NetworkImage(
                                          data[index].employee!.profilePhoto!),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: HexColor("#F7F9F9"),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                Text(
                                                    data[index]
                                                        .employee!
                                                        .fullName!,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14)),
                                                Spacer(),
                                                if (data[index]
                                                        .employee!
                                                        .uuid ==
                                                    logInVerifyModel!
                                                        .data!.user!.uuid)
                                                  GestureDetector(
                                                      onTap: () {
                                                        deletcomments(
                                                            comentid:
                                                                data[index].id);
                                                      },
                                                      child: Icon(Icons.delete))
                                              ],
                                            ),
                                            GestureDetector(
                                                onLongPress: () {
                                                  logic
                                                      .commentTextEditingController
                                                      .text = data[
                                                          index]
                                                      .comment!;
                                                  comentID =
                                                      data[index].id.toString();
                                                  logic.update();
                                                },
                                                child: Text(
                                                  data[index].comment!,
                                                  maxLines: 50,
                                                  textAlign: TextAlign.start,
                                                ))
                                          ]),
                                        ),
                                      ),
                                    ))
                                  ],
                                )),
                          );

                          //
                          // return Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Card(
                          //     child: Padding(
                          //       padding: EdgeInsets.all(8),
                          //       child: Column(children: [
                          //         //  Center(child: Text("${data.data?.pagination.}Comments")),
                          //         Row(
                          //           children: [
                          //             CircleAvatar(
                          //               maxRadius: 25,
                          //               backgroundImage: NetworkImage(
                          //                   data[index]
                          //                       .employee!
                          //                       .profilePhoto!),
                          //             ),
                          //             SizedBox(
                          //               width: 4,
                          //             ),
                          //             Text(data[index].employee!.fullName!),
                          //             Spacer(),
                          //             if (data[index].employee!.uuid ==
                          //                 logInVerifyModel!.data!.user!.uuid)
                          //               GestureDetector(
                          //                   onTap: () {
                          //                     deletcomments(
                          //                         comentid: data[index].id);
                          //                   },
                          //                   child: Icon(Icons.delete))
                          //           ],
                          //         ),
                          //
                          //         GestureDetector(
                          //             onLongPress: () {
                          //               // logic.coment.text =
                          //               // data[index].comment!;
                          //               // comentID = data[index].id.toString();
                          //               // logic.update();
                          //             },
                          //             child: Text(data[index].comment!))
                          //       ]),
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: ColorApp.PrimaryColor)),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                                    controller: commentTextEditingController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 4,
                                          top: 4,
                                          right: 15),
                                    ))),
                            GestureDetector(
                                onTap: () {
                                  if (logic.isUpdatecomment) {
                                    logic.updateComments(comentid: comentID);
                                  } else {
                                    logic.addComments(
                                        context: context, id: postId);
                                  }

                                  logic.commentTextEditingController.clear();
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.send))
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    ));
    commetscrollController.addListener(() {
      if (commetscrollController.position.atEdge) {
        if (commetscrollController.position.pixels == 0) {
          print('List scroll at top');
        } else {
          print(
              "999999999999999  =>  ${newsFeedsCommentsModel!.data!.pagination!.currentPage! < newsFeedsCommentsModel!.data!.pagination!.currentPage!}");
          if (newsFeedsCommentsModel!.data!.pagination!.next!
              .trim()
              .isNotEmpty) {
            NewsFeedsCommentsAPI newsFeedsCommentsAPI = NewsFeedsCommentsAPI();
            // newsFeedsCommentsAPI.id = postId;

            newsFeedsCommentsAPI
                .getpaginationData(
                    url: newsFeedsCommentsModel!.data!.pagination!.next!)
                .then((value) {
              newsFeedsCommentsModel = value as NewsFeedsCommentsModel;

              commentsList.addAll(newsFeedsCommentsModel!.data!.list!);
              update();
            });
          }
        }
      }
    });
  }

  commentsBotomSheet(
      {required context, required List<CommentsList> data, required postId}) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(36),
        ),
      ),
      backgroundColor: HexColor("#FFFFFF"),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: .85,
        minChildSize: 0.8,
        maxChildSize: 0.85,
        expand: false,
        builder: (_, controller) => Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20, top: 10),
          child: Column(
            children: [
              Center(
                  child: Container(
                height: 3,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "??????????????????",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: HexColor("#015555")),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                color: HexColor("#CFCFD0"),
                height: 1,
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GetBuilder<HomeController>(builder: (logic) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: commetscrollController,
                          //shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (_, index) {
                            print(" data.length  =>${data.length}");
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  color: HexColor("#FFFFFF"),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 20,
                                        backgroundImage: NetworkImage(
                                            data[index]
                                                .employee!
                                                .profilePhoto!),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: HexColor("#F7F9F9"),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          data[index]
                                                              .employee!
                                                              .fullName!,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14)),
                                                      Spacer(),
                                                      Text(
                                                        DateFormat.yMMMd(
                                                                "ar_SA")
                                                            .format(DateTime
                                                                .parse(data[
                                                                        index]
                                                                    .createdAt!)),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color: HexColor(
                                                                "#98A2B3")),
                                                      )
                                                      // if (data[index]
                                                      //     .employee!
                                                      //     .uuid ==
                                                      //     logInVerifyModel!
                                                      //         .data!
                                                      //         .user!
                                                      //         .uuid)
                                                      //   GestureDetector(
                                                      //       onTap: () {
                                                      //         deletcomments(
                                                      //             comentid:
                                                      //             data[index]
                                                      //                 .id);
                                                      //       },
                                                      //       child:
                                                      //       Icon(
                                                      //           Icons
                                                      //               .delete))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  GestureDetector(
                                                      onLongPress: () {
                                                        logic
                                                            .commentTextEditingController
                                                            .text = data[
                                                                index]
                                                            .comment!;
                                                        comentID = data[index]
                                                            .id
                                                            .toString();
                                                        logic.update();
                                                      },
                                                      child: Container(
                                                        child: Text(
                                                          data[index].comment!,
                                                          maxLines: 50,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ))
                                                ]),
                                          ),
                                        ),
                                      ))
                                    ],
                                  )),
                            );

                            //
                            // return Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Card(
                            //     child: Padding(
                            //       padding: EdgeInsets.all(8),
                            //       child: Column(children: [
                            //         //  Center(child: Text("${data.data?.pagination.}Comments")),
                            //         Row(
                            //           children: [
                            //             CircleAvatar(
                            //               maxRadius: 25,
                            //               backgroundImage: NetworkImage(
                            //                   data[index]
                            //                       .employee!
                            //                       .profilePhoto!),
                            //             ),
                            //             SizedBox(
                            //               width: 4,
                            //             ),
                            //             Text(data[index].employee!.fullName!),
                            //             Spacer(),
                            //             if (data[index].employee!.uuid ==
                            //                 logInVerifyModel!.data!.user!.uuid)
                            //               GestureDetector(
                            //                   onTap: () {
                            //                     deletcomments(
                            //                         comentid: data[index].id);
                            //                   },
                            //                   child: Icon(Icons.delete))
                            //           ],
                            //         ),
                            //
                            //         GestureDetector(
                            //             onLongPress: () {
                            //               // logic.coment.text =
                            //               // data[index].comment!;
                            //               // comentID = data[index].id.toString();
                            //               // logic.update();
                            //             },
                            //             child: Text(data[index].comment!))
                            //       ]),
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: HexColor("#CFCFD0"),
                        height: 1,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 4.0, left: 4, bottom: 8, top: 10),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: HexColor("#D0D5DD"))),
                                child: TextField(
                                    controller: commentTextEditingController,
                                    decoration: InputDecoration(
                                      fillColor: HexColor("#D0D5DD"),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 4,
                                          top: 4,
                                          right: 15),
                                    )),
                              )),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: ColorApp.PrimaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: ColorApp.PrimaryColor)),
                                child: GestureDetector(
                                    onTap: () {
                                      if (logic.isUpdatecomment) {
                                        logic.updateComments(
                                            comentid: comentID);
                                      } else {
                                        logic.addComments(
                                            context: context, id: postId);
                                      }

                                      logic.commentTextEditingController
                                          .clear();
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SvgPicture.asset(
                                        "assets/image/sendicon.svg",
                                        color: Colors.white,
                                        width: 20,
                                        height: 20,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );

    commetscrollController.addListener(() {
      if (commetscrollController.position.atEdge) {
        if (commetscrollController.position.pixels == 0) {
          print('List scroll at top');
        } else {
          print(
              "999999999999999  =>  ${newsFeedsCommentsModel!.data!.pagination!.currentPage! < newsFeedsCommentsModel!.data!.pagination!.currentPage!}");
          if (newsFeedsCommentsModel!.data!.pagination!.next!
              .trim()
              .isNotEmpty) {
            NewsFeedsCommentsAPI newsFeedsCommentsAPI = NewsFeedsCommentsAPI();
            // newsFeedsCommentsAPI.id = postId;

            newsFeedsCommentsAPI
                .getpaginationData(
                    url: newsFeedsCommentsModel!.data!.pagination!.next!)
                .then((value) {
              newsFeedsCommentsModel = value as NewsFeedsCommentsModel;

              commentsList.addAll(newsFeedsCommentsModel!.data!.list!);
              update();
            });
          }
        }
      }
    });
  }

  String emojiFilter = "smileys-emotion";

  updatemojiFilter({required String filter}) {
    emojiFilter = filter;
    update();
  }

  my30EmojiBotomSheet(
      {required context, required int postId, required int indexOfPostInList}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => GetBuilder<HomeController>(builder: (logic) {
        print("ooooooooooooooo");
        return DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.2,
            maxChildSize: 0.5,
            expand: false,
            builder: (_, controller) => Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Container(
                        height: 3,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "??????????????????",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: HexColor("#015555")),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: HexColor("#CFCFD0"),
                        height: 1,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: GridView.builder(
                          //
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: AllEmojiToView.all30EmojiMap.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 8,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6.0),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                addreactions(
                                    emojei: AllEmojiToView
                                        .all30EmojiMap[index].slug!,
                                    pos: indexOfPostInList);
                                update();
                                addEmojiToServer(
                                    default_emoji: AllEmojiToView
                                        .all30EmojiMap![index].slug!,
                                    postID: postId);

                                Navigator.pop(context);
                              },
                              child: Container(
                                  width: 5,
                                  height: 5,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(AllEmojiToView
                                        .all30EmojiMap![index].character!),
                                  )),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ));
      }),
    );
  }

  mojiBotomSheet(
      {required context, required int postId, required int indexOfPostInList}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => GetBuilder<HomeController>(builder: (logic) {
        print("ooooooooooooooo");
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          expand: false,
          builder: (_, controller) => Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Center(
                child: Container(
                  height: 2,
                  width: 30,
                  decoration: BoxDecoration(
                      color: ColorApp.greyIntroColor2.withOpacity(.5)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20),
                child: SizedBox(
                  height: 50,
                  child: ListView.builder(
                      controller: emojiscrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: AllEmojiToView.allgroupEmojiwithImage.length,
                      itemBuilder: (context, pos) {
                        if (AllEmojiToView.allgroupEmojiwithImage[pos].name ==
                            "1") {
                          return SizedBox();
                        } else {
                          print("0000000000000000000000000000000000000000");
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                itemScrollController.scrollTo(
                                    index: pos,
                                    duration: Duration(milliseconds: 20));

                                botomshhetemojeindex = pos;

                                logic.updatemojiFilter(
                                    filter: AllEmojiToView
                                        .allgroupEmoji[botomshhetemojeindex]);
                              },
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: pos == botomshhetemojeindex
                                          ? Colors.teal
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: SvgPicture.asset(
                                    fit: BoxFit.fill,
                                    AllEmojiToView
                                        .allgroupEmojiwithImage[pos].image,
                                    height: 20,
                                    width: 20,
                                    semanticsLabel: AllEmojiToView
                                        .allgroupEmojiwithImage[pos].name,
                                    color: Colors.black,
                                  )
                                  // Text(AllEmojiToView.allgroupEmoji[pos]
                                  // .replaceAll("-", " "))

                                  ),
                            ),
                          );
                        }
                      }),
                ),
              ),
              Expanded(
                  child: ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      shrinkWrap: true,
                      itemCount: AllEmojiToView.allgroupEmoji.length,
                      itemBuilder: (context, pos) {
                        // double size = getSizeImoji(AllEmojiToView
                        //     .groupEmoji[AllEmojiToView.allgroupEmoji[pos]]!
                        //     .length!);
                        print(AllEmojiToView.allgroupEmoji[pos]);
                        if (AllEmojiToView.allgroupEmoji[pos] == "1") {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 21.0, left: 21, bottom: 15, top: 15),
                            child: Text(
                                AllEmojiToView.getEmojiName(
                                  AllEmojiToView.allgroupEmoji[pos + 1],
                                ),
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          );
                          // return Text(AllEmojiToView.allgroupEmoji[pos+1]);
                        } else {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: GridView.builder(
                              //
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: AllEmojiToView
                                  .groupEmoji[
                                      AllEmojiToView.allgroupEmoji[pos]]!
                                  .length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 8,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6.0),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    addreactions(
                                        emojei: AllEmojiToView
                                            .groupEmoji[AllEmojiToView
                                                .allgroupEmoji[pos]]![index]
                                            .slug!,
                                        pos: indexOfPostInList);
                                    update();
                                    addEmojiToServer(
                                        default_emoji: AllEmojiToView
                                            .groupEmoji[AllEmojiToView
                                                .allgroupEmoji[pos]]![index]
                                            .slug!,
                                        postID: postId);

                                    if (AllEmojiToView.HostoryEmojiList
                                        .contains(AllEmojiToView.groupEmoji[
                                            AllEmojiToView
                                                .allgroupEmoji[pos]]![index])) {
                                    } else {
                                      AllEmojiToView.HostoryEmojiList.add(
                                          AllEmojiToView.groupEmoji[
                                              AllEmojiToView
                                                  .allgroupEmoji[pos]]![index]);
                                    }

                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      width: 5,
                                      height: 5,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(AllEmojiToView
                                            .groupEmoji[AllEmojiToView
                                                .allgroupEmoji[pos]]![index]
                                            .character!),
                                      )),
                                );
                              },
                            ),
                          );
                        }
                      }))
            ],
          ),
        );
      }),
    );
  }

  pdfBotomSheet({required context, required String pdfUrl}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => GetBuilder<HomeController>(builder: (logic) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.2,
          maxChildSize: 0.8,
          expand: false,
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
              child: SfPdfViewer.network(
                pdfUrl,
                enableTextSelection: true,
                enableDoubleTapZooming: true,
                controller: pdfViewerController,
                enableDocumentLinkAnnotation: true,
                enableHyperlinkNavigation: true,
                canShowPaginationDialog: true,
              ),
            ),
          ),
        );
      }),
    );
  }

  int steperIndex = 0;

  updatesteperIndex(int v) {
    steperIndex = v;
    update();
  }

  DateTime? focusedDay;
  Map<String, List<EventsList>> selectedEvents = {};

  List<EventsList> getdayEvent(DateTime dateTime) {
    print("0" * 50);
    print(DateTime.parse(dateTime.toString().substring(0, 10)));
    print(selectedEvents[dateTime.toString().substring(0, 10)]);

    return selectedEvents[dateTime.toString().substring(0, 10)] ?? [];
  }

  EventsModel? eventsDay;

  geteventsDay() {
    EventsAPI eventsAPI = EventsAPI();
    eventsAPI.date = selectedDay.toString().substring(0, 10);
    eventsAPI.getData().then((value) {
      eventsDay = value as EventsModel;
      update();
      print(eventsDay?.toJson());
    });
  }

  geteventsDetails({required contex, required String eventId}) {
    EventsDetailsApi eventsDetailsApi = EventsDetailsApi();
    eventsDetailsApi.id = eventId;
    eventsDetailsApi.getData().then((value) {
      EventsDetailsModel eventsDetailsModel = value as EventsDetailsModel;
      eventsDetailsBotomSheet(
          context: contex, eventsDetailsModel: eventsDetailsModel);
    });
  }

  eventsDetailsBotomSheet(
      {required context, required EventsDetailsModel eventsDetailsModel}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        expand: false,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: HexColor(
                  eventsDetailsModel.data!.eventType!.color!)),
          child: Column(children: [
            SizedBox(
              height: 16,
            ),
            Center(
              child: Container(
                height: 2,
                width: 30,
                decoration: BoxDecoration(
                    color: ColorApp.greyIntroColor2.withOpacity(.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Text("???????????? ??????????",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white)),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
                child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Column(children: [
                  SizedBox(
                    height: 26,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/image/calendar.svg",
                          color: HexColor(
                              eventsDetailsModel.data!.eventType!.color!),
                          fit: BoxFit.fill,
                          height: 20,
                          width: 20),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        DateFormat.yMMMd("ar_SA").format(
                          DateTime.parse(
                            eventsDetailsModel.data!.startDate!,
                          ),
                        ),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                          AppImage.getimageEventsIconPath(
                              eventIcon:
                                  eventsDetailsModel.data!.eventType!.icon!),
                          color: HexColor(
                              eventsDetailsModel.data!.eventType!.color!),
                          fit: BoxFit.fill,
                          height: 20,
                          width: 20),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        eventsDetailsModel.data!.name!,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/image/edit.svg",
                          color: HexColor(
                              eventsDetailsModel.data!.eventType!.color!),
                          fit: BoxFit.fill,
                          height: 20,
                          width: 20),
                      SizedBox(
                        width: 8,
                      ),
                Expanded(
                  child: Text(
                    eventsDetailsModel.data!.description!,maxLines: 50,
                    style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
                    ],
                  )
                ]),
              ),
            ))
          ]),
        ),
      ),
    );
  }

  updateselectedDay(selectedDay, focusedDay) {
    this.selectedDay = selectedDay;
    this.focusedDay = focusedDay;

    update();
  }

  DateTimeSheet({required context}) {
    late PageController _pageController;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => GetBuilder<HomeController>(builder: (logic) {
        // DraggableScrollableController draggableScrollableController = DraggableScrollableController();
        // draggableScrollableController.addListener(() {
        //
        // });
        return DraggableScrollableSheet(
          // controller: draggableScrollableController,
          initialChildSize: 0.9,
          minChildSize: 0.2,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                    height: 3,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "??????????????",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: HexColor("#015555")),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor("#F2F5F5"),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8, left: 8, right: 8),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/image/calendar.svg",
                                height: 25,
                                width: 25,
                                color: ColorApp.PrimaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                DateTableCalendarUtils
                                    .arweekdays[selectedDay.weekday - 1],
                                style: TextStyle(),
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              Text(
                                " ${DateFormat.d('ar_SA').format(selectedDay)}",
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                  " ${DateFormat.MMMM('ar_SA').format(selectedDay)}"),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "${DateFormat.y('ar_SA').format(selectedDay)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: HexColor("#CFCFD0"),
                    height: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    child: TableCalendar(
                      locale: "ar",
                      eventLoader: logic.getdayEvent,
                      onCalendarCreated: (controller) =>
                          _pageController = controller,
                      calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, _datetime, focusedDay) {
                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: HexColor("#E5EEEE"),
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Text(
                                //   DateTableCalendarUtils
                                //       .weekdays[_datetime.weekday - 1],
                                //   style: TextStyle(color: Colors.white),
                                // ),
                                Text(
                                  _datetime.day.toString(),
                                  style: TextStyle(
                                      color: HexColor("#013737"), fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, todayBuilder: (context, _datetime, focusedDay) {
                        return Container(
                          decoration: BoxDecoration(
                              color: focusedDay == _datetime
                                  ? ColorApp.PrimaryColor
                                  : HexColor("#E5EEEE"),
                              borderRadius: BorderRadius.circular(4.0)),
                          margin: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0.0),
                          child: focusedDay == _datetime
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        DateTableCalendarUtils
                                            .weekdays[_datetime.weekday - 1],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        _datetime.day.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    _datetime.day.toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                        );
                      }, selectedBuilder: (context, _datetime, focusedDay) {
                        return Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: ColorApp.PrimaryColor,
                              borderRadius: BorderRadius.circular(4.0)),
                          margin: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Text(
                                //   DateTableCalendarUtils
                                //       .weekdays[_datetime.weekday - 1],
                                //   style: TextStyle(color: Colors.white),
                                // ),
                                Text(
                                  _datetime.day.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, markerBuilder: (context, datetime, events) {
                        int i =
                            selectedEvents[datetime.toString().substring(0, 10)]
                                    ?.length ??
                                0;
                        return i == 0
                            ? SizedBox()
                            : Container(
                                // height: 20,
                                // width: 20,
                                // color: Colors.red,
                                // child: Center(
                                //   child: Text(
                                //       "${getdayEvent(DateTime.parse(datetime.toString().substring(0, 10))).length}"),
                                // ),
                                );
                      }),
                      selectedDayPredicate: (day) {
                        return isSameDay(logic.selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        logic.updateselectedDay(selectedDay, focusedDay);
                      },
                      calendarFormat: CalendarFormat.month,
                      headerVisible: true,
                      firstDay: DateTime.utc(2010, 10, 16),
                      // onPageChanged: (focusedDay) =>
                      //     this.focusedDay = focusedDay,
                      headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          formatButtonShowsNext: false,
                          titleTextStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: HexColor("#1D2939"))),
                      daysOfWeekVisible: true,
                      daysOfWeekHeight: 30,
                      lastDay: DateTime.utc(2050, 3, 14),
                      daysOfWeekStyle: DaysOfWeekStyle(
                          // decoration:
                          //     BoxDecoration(color: ColorApp.PrimaryColor),
                          weekdayStyle: TextStyle(
                        fontSize: 12,
                      )),
                      focusedDay: logic.selectedDay == null
                          ? DateTime.now()
                          : logic.selectedDay!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CustomButton(
                      onClick: () {
                        geteventsDay();
                        // draggableScrollableController.animateTo(
                        //     .1, duration: Duration(microseconds: 500),
                        //     curve: Curves.linear);

                        Scaffold.of(eventCotext!).showBodyScrim(false, 0.0);
                        Navigator.pop(context!);
                      },
                      width: double.infinity,
                      buttonColor: HexColor("#015555"),
                      title: "????????",
                      height: 50,
                      borderRadius: 12,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      titleColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  EventTypesModel? eventTypesModel;

  getEventTypes() {
    EventTypesApi eventTypesApi = EventTypesApi();

    eventTypesApi.getData().then((value) {
      eventTypesModel = value as EventTypesModel;
      update();
    });
  }

  AllEventsModel? allEventsModel;
  List<String> daysDateList = [];

  bool checkIfListHaveItemInFilter(
      {required filterId, required List<EventsList> list}) {
    bool listHaveItemInFilter = false;
    for (int i = 0; i < list.length; i++) {
      if (list[i].eventType!.id == filterId) {
        listHaveItemInFilter = true;
      }
    }

    return listHaveItemInFilter;
  }

  getAllevents() {
    AlleventsApi alleventsApi = AlleventsApi();

    alleventsApi.getData().then((value) {
      allEventsModel = value as AllEventsModel;

      for (int i = 0; i < allEventsModel!.data!.list!.length; i++) {
        if (selectedEvents[allEventsModel!.data!.list![i]!.startDate!] ==
            null) {
          selectedEvents[allEventsModel!.data!.list![i]!.startDate!] = [];
          daysDateList.add(allEventsModel!.data!.list![i]!.startDate!);
        }
        selectedEvents[allEventsModel!.data!.list![i]!.startDate!]
            ?.add(allEventsModel!.data!.list![i]);
      }
      daysDateList.sort();
      update();
    });
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM("ar_SA").format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          SizedBox(
            width: 120.0,
            child: Text(
              headerText,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: HexColor("#1D2939")),
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.calendar_today, size: 20.0),
          //   visualDensity: VisualDensity.compact,
          //   onPressed: onTodayButtonTap,
          // ),
          if (clearButtonVisible)
            IconButton(
              icon: Icon(Icons.clear, size: 20.0),
              visualDensity: VisualDensity.compact,
              onPressed: onClearButtonTap,
            ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}
