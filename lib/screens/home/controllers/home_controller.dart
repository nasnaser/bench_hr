import 'package:bench_hr/constants/app_color.dart';
import 'package:bench_hr/network/apis/delete_comments_api.dart';
import 'package:bench_hr/network/apis/delete_emoje_api.dart';
import 'package:bench_hr/network/apis/news_feeds_comments_api.dart';
import 'package:bench_hr/network/apis/news_feeds_list_api.dart';
import 'package:bench_hr/network/apis/reactions_create_api.dart';
import 'package:bench_hr/network/apis/update_comments_api.dart';
import 'package:bench_hr/network/json_model/emoji_json_model.dart';
import 'package:bench_hr/network/json_model/logIn_verify_model.dart';
import 'package:bench_hr/network/json_model/news_feeds_comments_model.dart';
import 'package:bench_hr/network/json_model/newsfeeds_model.dart';

import 'package:bench_hr/screens/home/home_taps/tap1/tap1_screen.dart';
import 'package:bench_hr/screens/home/home_taps/tap1/taps/tap1_tap1.dart';
import 'package:bench_hr/utility/nested_open_page.dart';
import 'package:bench_hr/utility/storage.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
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

  List<Widget> screens = [
    Tap1Screen(),
    Tap1Screen(),
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
        botomshhetemojeindex = indices.first.index+1;
        update();
      }
    });
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

  commentsBotomSheet(
      {required context, required List<CommentsList> data, required postId}) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.2,
        maxChildSize: 0.5,
        expand: false,
        builder: (_, controller) => Column(
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
            Expanded(
              child: GetBuilder<HomeController>(builder: (logic) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: commetscrollController,
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(children: [
                                  //  Center(child: Text("${data.data?.pagination.}Comments")),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 25,
                                        backgroundImage: NetworkImage(
                                            data[index]
                                                .employee!
                                                .profilePhoto!),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(data[index].employee!.fullName!),
                                      Spacer(),
                                      if (data[index].employee!.uuid ==
                                          logInVerifyModel!.data!.user!.uuid)
                                        GestureDetector(
                                            onTap: () {
                                              deletcomments(
                                                  comentid: data[index].id);
                                            },
                                            child: Icon(Icons.delete))
                                    ],
                                  ),

                                  GestureDetector(
                                      onLongPress: () {
                                        // logic.coment.text =
                                        // data[index].comment!;
                                        // comentID = data[index].id.toString();
                                        // logic.update();
                                      },
                                      child: Text(data[index].comment!))
                                ]),
                              ),
                            ),
                          );
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

  EmojiBotomSheet(
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
                            child: Container(height: 20,width: 20,
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
                                  color:Colors.black,
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
                                  AllEmojiToView.allgroupEmoji[pos+1 ],
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
              padding: const EdgeInsets.only(top: 20,left: 8,right: 8),
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
}
