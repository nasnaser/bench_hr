import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../constants/app_color.dart';
import '../../../network/apis/departments_api.dart';
import '../../../network/apis/employees_api.dart';
import '../../../network/json_model/departments_list_model.dart';
import '../../../network/json_model/employees_model.dart';
import '../../shared_widget/custom_button.dart';
import '../widgets/filter_item_bottom.dart';

class AttendaceController extends GetxController {
  EmployeesModel? employeesModel;

  getAllEmployees() {
    EmployeesAPI employeesAPI = EmployeesAPI();
    employeesAPI.getData().then((value) {
      employeesModel = value as EmployeesModel;
      update();
    });
  }

  bool searchByLocation = true;
  bool isAll = false;

//
// bool marketing   =false;
// bool finance       =false;
// bool employment               =false;
// bool personnelAffairs        =false;
// bool  sales                =false;
// bool purchases                =false;
// bool informationTechnology   =false;
// bool legal                    =false;
// bool investorRelations       =false;
  updateSerchByLocation({required bool search}) {
    searchByLocation = search;
    update();
  }

  DepartmentsListModel? departmentsListModel;

  getDepartments({required context}) {
    DepartmentsAPI departmentsAPI = DepartmentsAPI();
    departmentsAPI.getData().then((value) {
      departmentsListModel = value as DepartmentsListModel;
      print("departmentsListModel   =>  ${departmentsListModel?.toJson()}");

      searchBotomSheet(
          context: context, departmentsListModel: departmentsListModel!);
    });
  }

  updateDepartmentsListIsCheck({required int pos, required bool v}) {
    departmentsListModel!.data!.list![pos].isCheck = v;
    update();
  }

  searchBotomSheet(
      {required context, required DepartmentsListModel departmentsListModel}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.2,
        maxChildSize: 0.7,
        expand: false,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20),
            child: GetBuilder<AttendaceController>(builder: (logic) {
              return Column(children: [
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(43),
                      color: HexColor("#E5EEEE")),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              updateSerchByLocation(search: false);
                            },
                            child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * .4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(43),
                                    color: searchByLocation
                                        ? Colors.white.withOpacity(0)
                                        : HexColor("#015555")),
                                child: Center(
                                  child: Text(
                                    "القسم",
                                    style: TextStyle(
                                        color: searchByLocation
                                            ? HexColor("#015555")
                                            : Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              updateSerchByLocation(search: true);
                            },
                            child: Center(
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width * .4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(43),
                                    color: searchByLocation
                                        ? HexColor("#015555")
                                        : Colors.white.withOpacity(0),
                                  ),
                                  child: Center(
                                    child: Text("الموقع",
                                        style: TextStyle(
                                            color: searchByLocation
                                                ? Colors.white
                                                : HexColor("#015555"),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16)),
                                  )),
                            ),
                          ),
                        ]),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: ColorApp.PrimaryColor,
                        shape: CircleBorder(),
                        value: isAll,
                        onChanged: (v) {
                          isAll = v!;
                          update();
                        }),
                    Text(
                      "إختيار الكل",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    )
                  ],
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
                  child:GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 50
                      ),
                      itemCount: departmentsListModel.data?.list?.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return FilterItemBottom(
                          title: departmentsListModel.data!.list![index].name!,
                          isCheck:
                              departmentsListModel.data!.list![index].isCheck,
                          onChanged: (v) {
                            updateDepartmentsListIsCheck(pos: index, v: v!);
                          },
                        );
                      }),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorApp.PrimaryColor),
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: FittedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "ابحث",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                    )),
                  ),
                )
              ]);
            }),
          ),
        ),
      ),
    );
  }
}
